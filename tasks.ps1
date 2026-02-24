#Requires -Version 5.1
<#
.SYNOPSIS
    Gestionnaire de tâches pour polygone-evacuation-a5 (Windows)

.DESCRIPTION
    Équivalent du Makefile pour Windows PowerShell 5.1+

.EXAMPLE
    .\tasks.ps1 pdf
    .\tasks.ps1 clean
    .\tasks.ps1 test

.NOTES
    Auteur: Bertrand Brodeau (@valorisa)
    Version: 1.0.1
#>

param(
    [Parameter(Position = 0)]
    [ValidateSet('pdf', 'clean', 'test', 'changelog', 'help')]
    [string]$Task = 'help'
)

$ErrorActionPreference = "Stop"

function Write-TaskHeader {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host ""
    Write-Host "═══════════════════════════════════════════" -ForegroundColor $Color
    Write-Host "  $Message" -ForegroundColor $Color
    Write-Host "═══════════════════════════════════════════" -ForegroundColor $Color
    Write-Host ""
}

function Invoke-Pdf {
    Write-TaskHeader "📄 Génération du PDF A5..." "Green"
    
    # Vérifier les prérequis
    if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
        Write-Host "❌ Pandoc non trouvé. Installez-le avec:" -ForegroundColor Red
        Write-Host "   winget install JohnMacFarlane.Pandoc" -ForegroundColor Yellow
        exit 1
    }
    
    if (-not (Get-Command wkhtmltopdf -ErrorAction SilentlyContinue)) {
        Write-Host "❌ wkhtmltopdf non trouvé. Installez-le avec:" -ForegroundColor Red
        Write-Host "   winget install wkhtmltopdf.wkhtmltopdf" -ForegroundColor Yellow
        exit 1
    }
    
    # Générer le PDF
    python build.py
    
    if ($LASTEXITCODE -eq 0 -and (Test-Path "plan-evacuation.pdf")) {
        $file = Get-Item "plan-evacuation.pdf"
        $sizeKB = [math]::Round($file.Length / 1KB, 1)
        Write-Host "✅ PDF généré avec succès !" -ForegroundColor Green
        Write-Host "   📁 Fichier: $($file.Name)" -ForegroundColor White
        Write-Host "   📏 Taille:  $sizeKB KB" -ForegroundColor White
    }
    else {
        Write-Host "❌ Erreur lors de la génération du PDF" -ForegroundColor Red
        exit 1
    }
}

function Invoke-Clean {
    Write-TaskHeader "🧹 Nettoyage..." "Yellow"
    
    $filesToClean = @("plan-evacuation.pdf", "debug.html")
    $cleaned = 0
    
    foreach ($file in $filesToClean) {
        if (Test-Path $file) {
            Remove-Item -Path $file -Force
            Write-Host "   🗑️ Supprimé: $file" -ForegroundColor Gray
            $cleaned++
        }
    }
    
    if ($cleaned -eq 0) {
        Write-Host "   ℹ️ Aucun fichier à nettoyer" -ForegroundColor Gray
    }
    else {
        Write-Host "✅ $cleaned fichier(s) supprimé(s)" -ForegroundColor Green
    }
}

function Invoke-Test {
    Write-TaskHeader "🧪 Lancement des tests..." "Magenta"
    
    if (-not (Get-Command pytest -ErrorAction SilentlyContinue)) {
        Write-Host "❌ pytest non trouvé. Installez-le avec:" -ForegroundColor Red
        Write-Host "   pip install pytest" -ForegroundColor Yellow
        exit 1
    }
    
    if (Test-Path "tests") {
        pytest tests/ -v
    }
    else {
        Write-Host "⚠️ Dossier 'tests/' non trouvé" -ForegroundColor Yellow
        pytest -v
    }
}

function Invoke-Changelog {
    Write-TaskHeader "📝 Mise à jour du CHANGELOG..." "Blue"
    
    python update_changelog.py
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ CHANGELOG.md mis à jour" -ForegroundColor Green
        
        # Afficher un aperçu
        Write-Host ""
        Write-Host "📋 Aperçu:" -ForegroundColor Cyan
        Get-Content "CHANGELOG.md" -Head 15
    }
}

function Show-Help {
    Write-Host ""
    Write-Host "🚨 polygone-evacuation-a5 - Gestionnaire de tâches Windows" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Usage: .\tasks.ps1 <tâche>" -ForegroundColor White
    Write-Host ""
    Write-Host "Tâches disponibles:" -ForegroundColor Yellow
    Write-Host "  pdf        Génère plan-evacuation.pdf (A5)" -ForegroundColor White
    Write-Host "  clean      Supprime les fichiers générés" -ForegroundColor White
    Write-Host "  test       Lance les tests pytest" -ForegroundColor White
    Write-Host "  changelog  Met à jour CHANGELOG.md" -ForegroundColor White
    Write-Host "  help       Affiche cette aide" -ForegroundColor White
    Write-Host ""
    Write-Host "Exemples:" -ForegroundColor Yellow
    Write-Host "  .\tasks.ps1 pdf" -ForegroundColor Gray
    Write-Host "  .\tasks.ps1 clean" -ForegroundColor Gray
    Write-Host ""
}

# Exécution de la tâche demandée
switch ($Task) {
    'pdf'       { Invoke-Pdf }
    'clean'     { Invoke-Clean }
    'test'      { Invoke-Test }
    'changelog' { Invoke-Changelog }
    'help'      { Show-Help }
    default     { Show-Help }
}
