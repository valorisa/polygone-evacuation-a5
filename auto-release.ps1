# Auto-release PowerShell Windows
Write-Host "🚀 AUTO-RELEASE GitHub (Windows)"
& make test-all
& make pdf
git add .
git commit -m "Release v1.0.1"
git push
Write-Host "✅ Exécute manuellement sur GitHub.com"
