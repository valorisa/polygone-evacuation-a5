#Requires -Version 5.1
<#
.SYNOPSIS
    Script de release automatique pour GitHub (Windows)

.DESCRIPTION
    - Lance les tests
    - Génère le PDF
    - Commit et push
    - Crée une release GitHub (si gh CLI installé)

.EXAMPLE
    .\auto-release.ps1

.NOTES
    Auteur: Bertrand Brodeau (@valorisa)
    Prérequis: git, python, pytest, GitHub CLI (optionnel)
#>

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Step {
    param([string]$Message, [string]$Icon = "▶")
    Write-Host ""
    Write-Host "$Icon $Message" -ForegroundColor Cyan
    Write-Host ("-" * 50) -ForegroundColor DarkGray
}

# ═══════════════════════════════════════════════════════
# DÉBUT DU SCRIPT
# ═══════════════════════════════════════════════════════

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║  🚀 AUTO-RELEASE GitHub (Windows PowerShell)      ║" -ForegroundColor Green
Write-Host "╚═══════════════════════════════════════════════════╝" -ForegroundColor Green

# ─────────────────────────────────────────────────────────
# 1. Lecture de la version depuis index.json
# ─────────────────────────────────────────────────────────
Write-Step "Lecture de la version..." "📦"

if (-not (Test-Path "index.json")) {
    Write-Host "❌ Fichier index.json introuvable" -ForegroundColor Red
    exit 1
}

try {
    $indexContent = Get-Content -Path "index.json" -Raw -Encoding UTF8 | ConvertFrom-Json
    $version = $indexContent.version
    Write-Host "   Version détectée: v$version" -ForegroundColor Yellow
}
catch {
    Write-Host "❌ Erreur lecture index.json: $_" -ForegroundColor Red
    exit 1
}

# ─────────────────────────────────────────────────────────
# 2. Lancement des tests
# ─────────────────────────────────────────────────────────
Write-Step "Lancement des tests..." "🧪"

if (Test-Path "tests") {
    pytest tests/ -v
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Tests échoués. Release annulée." -ForegroundColor Red
        exit 1
    }
    Write-Host "   ✅ Tests passés" -ForegroundColor Green
}
else {
    Write-Host "   ⚠️ Dossier tests/ non trouvé, tests ignorés" -ForegroundColor Yellow
}

# ─────────────────────────────────────────────────────────
# 3. Génération du PDF
# ─────────────────────────────────────────────────────────
Write-Step "Génération du PDF..." "📄"

python build.py
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Génération PDF échouée. Release annulée." -ForegroundColor Red
    exit 1
}

if (Test-Path "plan-evacuation.pdf") {
    $pdfSize = [math]::Round((Get-Item "plan-evacuation.pdf").Length / 1KB, 1)
    Write-Host "   ✅ PDF généré ($pdfSize KB)" -ForegroundColor Green
}
else {
    Write-Host "❌ PDF non trouvé après build" -ForegroundColor Red
    exit 1
}

# ─────────────────────────────────────────────────────────
# 4. Commit et Push Git
# ─────────────────────────────────────────────────────────
Write-Step "Commit et push Git..." "📤"

git add .
git commit -m "Release v$version" --allow-empty
git push

Write-Host "   ✅ Push effectué" -ForegroundColor Green

# ─────────────────────────────────────────────────────────
# 5. Création de la release GitHub
# ─────────────────────────────────────────────────────────
Write-Step "Création release GitHub..." "🏷️"

if (Get-Command gh -ErrorAction SilentlyContinue) {
    try {
        gh release create "v$version" `
            --title "Plan Évacuation A5 v$version" `
            --notes "📄 PDF A5 sécurité Parking Polygone Montpellier`n`n- Format A5 imprimable`n- Bilingue FR/EN`n- Schéma ASCII + contacts urgence" `
            "plan-evacuation.pdf"
        
        Write-Host ""
        Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
        Write-Host "  ✅ Release v$version publiée avec succès !" -ForegroundColor Green
        Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ Erreur création release: $_" -ForegroundColor Yellow
        Write-Host "   Créez la release manuellement sur GitHub.com" -ForegroundColor Yellow
    }
}
else {
    Write-Host ""
    Write-Host "⚠️ GitHub CLI (gh) non installé." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Pour installer GitHub CLI:" -ForegroundColor Cyan
    Write-Host "   winget install GitHub.cli" -ForegroundColor White
    Write-Host ""
    Write-Host "Ou créez la release manuellement:" -ForegroundColor Cyan
    Write-Host "   https://github.com/valorisa/polygone-evacuation-a5/releases/new" -ForegroundColor White
    Write-Host ""
}

Write-Host ""
Write-Host "🎉 Processus terminé !" -ForegroundColor Green
Write-Host ""
