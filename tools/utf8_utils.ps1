#Requires -Version 5.1
<#
.SYNOPSIS
 Utilitaires UTF-8 et GitIngest pour Windows PowerShell 5.1+
.DESCRIPTION
 - Force UTF-8 pour Python
 - Lecture UTF-8 propre
 - Nettoyage des caractères box-drawing
 - Dumps GitIngest propres et compatibles LLM
#>

# UTF-8 global pour Python
$env:PYTHONIOENCODING = "utf-8"
$env:PYTHONUTF8 = "1"

function cat8 {
    param([Parameter(Mandatory, Position=0)][string]$Path)
    Get-Content $Path -Encoding UTF8
}

function Clean-Tree {
    param([string]$Path)
    if (Test-Path $Path) {
        $content = Get-Content $Path -Encoding UTF8 -Raw
        $regex = '[\u2514\u251c\u2502\u2500\u256d\u256e\u256f\u2570]'
        $content = $content -replace $regex, ' '
        $content | Out-File -Encoding UTF8 $Path
    }
}

function gi-utf8 {
    param(
        [Parameter(Mandatory)][string]$Repo,
        [string]$Output = $null
    )

    if (-not (Get-Command gitingest -ErrorAction SilentlyContinue)) {
        Write-Host "❌ gitingest n'est pas installé. Utilisez: pip install gitingest" -ForegroundColor Yellow
        return
    }

    $cleanRepo = $Repo -replace '^\[.*\]\((.*)\)$','$1' -replace '\.git$',''
    if (-not $Output) { $Output = "$(Split-Path $cleanRepo -Leaf).txt" }

    Write-Host "[GI] Analyse GitHub: $cleanRepo" -ForegroundColor Cyan
    gitingest $cleanRepo -o temp.txt

    Clean-Tree temp.txt

    if (Test-Path temp.txt) {
        Move-Item temp.txt $Output -Force
        $sizeKB = [math]::Round((Get-Item $Output).Length / 1KB, 1)
        Write-Host "[OK] Digest ASCII: $Output ($sizeKB KB)" -ForegroundColor Green
    }
}

function gi-quick {
    param([Parameter(Mandatory)][string]$Repo)

    if (-not (Get-Command gitingest -ErrorAction SilentlyContinue)) {
        Write-Host "❌ gitingest n'est pas installé. Utilisez: pip install gitingest" -ForegroundColor Yellow
        return
    }

    $cleanRepo = $Repo -replace '^\[.*\]\((.*)\)$','$1' -replace '\.git$',''
    $fileName = "quick-$(Split-Path $cleanRepo -Leaf).txt"

    gitingest $cleanRepo -i "*.py" -i "*.js" -i "*.md" -s 102400 -o temp.txt

    Clean-Tree temp.txt

    if (Test-Path temp.txt) {
        Move-Item temp.txt $fileName -Force
        Write-Host "[OK] Quick ASCII: $fileName" -ForegroundColor Green
    }
}
