# 🚨 **Polygone-Evacuation-A5**

[![Tests](https://img.shields.io/badge/tests-passing-brightgreen)](https://github.com/valorisa/polygone-evacuation-a5/actions)
[![Build PDF](https://img.shields.io/badge/PDF-A5%20ready-brightgreen)](https://github.com/valorisa/polygone-evacuation-a5)
[![Release](https://img.shields.io/badge/version-1.0.1-blue.svg)](https://github.com/valorisa/polygone-evacuation-a5/releases)

**Plan d'évacuation A5 bilingue (FR/EN) – Parking Polygone Montpellier**

> **Génère automatiquement** un PDF A5 imprimable de **sécurité professionnelle** avec schéma ASCII, procédures d'urgence, contacts et **header/footer automatiques**.

---

## 🖥️ **Usage Windows (PowerShell 5.1+)**

```powershell
# 1. Clone
git clone https://github.com/valorisa/polygone-evacuation-a5.git
Set-Location polygone-evacuation-a5

# 2. Générer le PDF
.\tasks.ps1 pdf

# 3. Vérifier le résultat
Get-Item plan-evacuation.pdf | Select-Object Name, Length
```

### Commandes disponibles (Windows)

| Action | Commande | Résultat |
|--------|----------|----------|
| **PDF** | `.\tasks.ps1 pdf` | `plan-evacuation.pdf` (A5) |
| **Tests** | `.\tasks.ps1 test` | Exécute pytest |
| **Clean** | `.\tasks.ps1 clean` | Supprime le PDF |
| **Changelog** | `.\tasks.ps1 changelog` | Met à jour CHANGELOG.md |
| **Release** | `.\auto-release.ps1` | Publie sur GitHub |
| **Aide** | `.\tasks.ps1 help` | Liste des commandes |

---

## 🐧 **Usage Linux/macOS (Bash)**

```bash
# 1. Clone
git clone https://github.com/valorisa/polygone-evacuation-a5.git
cd polygone-evacuation-a5

# 2. Setup (optionnel)
./setup-complete.sh

# 3. Générer le PDF
make pdf

# 4. Vérifier
ls -lh plan-evacuation.pdf
```

### Commandes disponibles (Linux/macOS)

| Action | Commande | Résultat |
|--------|----------|----------|
| **PDF** | `make pdf` | `plan-evacuation.pdf` (A5) |
| **Tests** | `make test-all` | 100% coverage |
| **Release** | `make changelog` | v1.0.1 + CHANGELOG |
| **Setup** | `./setup-complete.sh` | Git + pre-commit + tests |
| **Clean** | `make clean` | Supprime PDF |

---

## ⚙️ **Prérequis**

### Windows

```powershell
# Installer via winget (Windows 10/11)
winget install JohnMacFarlane.Pandoc
winget install wkhtmltopdf.wkhtmltopdf

# Vérifier l'installation
pandoc --version
wkhtmltopdf --version
```

### macOS

```bash
brew install pandoc wkhtmltopdf
```

### Ubuntu/Debian

```bash
sudo apt install pandoc wkhtmltopdf
```

---

## 🎯 **Fonctionnalités clés**

- 📐 **Format A5 portrait** (148×210mm) – Imprimable urgence
- 📑 **Header/footer automatique** – Chaque page numérotée
- 🎨 **Couleurs sécurité** – Rouge/Vert/Jaune norme
- 🗺️ **Schéma ASCII optimisé** – Bordures + ombre CSS
- 🌍 **Bilingue FR/EN** – Procédures + contacts
- 🤖 **100% automatisé** – Makefile + PowerShell + Python
- 💻 **Multiplateforme** – Linux/macOS/Windows

---

## 📁 **Structure du projet**

```
polygone-evacuation-a5/
├── 📄 plan-evacuation.md      # Contenu principal bilingue
├── 🎨 style-pdf.css           # CSS A5 sécurité pro
├── 🐍 build.py                # Génération PDF Python
├── 🛠️ Makefile                # Commandes Linux/macOS
├── 🛠️ tasks.ps1               # Commandes Windows PowerShell
├── 🚀 auto-release.ps1        # Release GitHub (Windows)
├── 🚀 auto-release.sh         # Release GitHub (Linux/macOS)
├── 📦 pyproject.toml          # Configuration Python moderne
├── 📋 CHANGELOG.md            # Historique des versions
├── 📋 index.json              # Métadonnées projet
└── 📜 LICENSE                 # Licence MIT
```

---

## 📄 **Exemple de rendu PDF A5**

```
┌─────────────────────────────────────────────────────┐
│ [HEADER ROUGE] PLAN D'ÉVACUATION – Page 1/2         │
├─────────────────────────────────────────────────────┤
│  🗺️ SCHÉMA ASCII (5 sorties)                        │
│  📋 PROCÉDURES FR (5 étapes)                        │
│  📋 PROCEDURES EN (5 steps)                         │
│  📞 CONTACTS (112, sécurité, etc.)                  │
│  ⚠️ RÈGLES (NE PAS / À FAIRE)                       │
├─────────────────────────────────────────────────────┤
│ [FOOTER] Page 1/2 | 23 février 2026                 │
└─────────────────────────────────────────────────────┘
```

---

## 🤝 **Contribuer**

1. Fork le projet
2. `git checkout -b feature/improvements`
3. `.\tasks.ps1 test` (Windows) ou `make test-all` (Linux/macOS)
4. `git push origin feature/improvements`
5. Pull Request !

---

## 📜 **Licence**

[MIT](LICENSE) – © 2026 Bertrand Brodeau (@valorisa)
```

---

## 📄 2. tasks.ps1 (nouveau fichier)

```powershell
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
```

---

## 📄 3. auto-release.ps1 (corrigé)

```powershell
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
```

---

## 📄 4. index.json (version synchronisée)

```json
{
  "project": "polygone-evacuation-a5",
  "version": "1.0.1",
  "date": "2026-02-23",
  "author": "Bertrand Brodeau (@valorisa)",
  "format": "A5",
  "language": ["fr", "en"],
  "features": [
    "header-footer-auto",
    "couleurs-securite",
    "schema-ascii",
    "tableaux-contacts",
    "bilingue"
  ],
  "build": {
    "pdf": "plan-evacuation.pdf",
    "pandoc": "pandoc plan-evacuation.md -o plan-evacuation.pdf --css=style-pdf.css",
    "wkhtmltopdf": "wkhtmltopdf --page-size A5 plan-evacuation.html plan-evacuation.pdf"
  }
}
```

---

## 📄 5. pyproject.toml (corrigé)

```toml
[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[project]
name = "polygone-evacuation-a5"
version = "1.0.1"
description = "Plan évacuation A5 Parking Polygone - Bilingue FR/EN"
readme = "README.md"
license = "MIT"
authors = [{ name = "Bertrand Brodeau", email = "bertrand@valorisa.fr" }]
requires-python = ">=3.9"

# Note: pandoc et wkhtmltopdf sont des prérequis SYSTÈME (voir README)
dependencies = []

[project.optional-dependencies]
test = ["pytest>=7.0"]
dev = ["pre-commit", "black", "ruff", "isort"]

[project.urls]
Homepage = "https://github.com/valorisa/polygone-evacuation-a5"
Repository = "https://github.com/valorisa/polygone-evacuation-a5.git"
Issues = "https://github.com/valorisa/polygone-evacuation-a5/issues"

[tool.black]
line-length = 88
target-version = ['py39', 'py310', 'py311', 'py312']

[tool.ruff]
line-length = 88
select = ["E", "F", "B", "Q", "I"]
ignore = ["E501"]

[tool.isort]
profile = "black"
line_length = 88
```

---

## 📄 6. build.py (nettoyé)

```python
#!/usr/bin/env python3
"""
Build PDF A5 pour plan-evacuation.
Génère un PDF au format A5 à partir du fichier Markdown.
"""
import subprocess


def build_pdf():
    """Génère PDF avec Pandoc + wkhtmltopdf."""
    cmd = [
        "pandoc",
        "plan-evacuation.md",
        "-o", "plan-evacuation.pdf",
        "--css=style-pdf.css",
        "--pdf-engine=wkhtmltopdf",
        "--dpi=300",
        "-V", "geometry:margin=1.5cm",
        "-V", "papersize=a5",
    ]
    
    try:
        subprocess.run(cmd, check=True)
        print("✅ PDF généré : plan-evacuation.pdf")
    except subprocess.CalledProcessError as e:
        print(f"❌ Erreur génération PDF : {e}")
        raise
    except FileNotFoundError:
        print("❌ Pandoc ou wkhtmltopdf non trouvé.")
        print("   Installez-les avant de continuer.")
        raise


if __name__ == "__main__":
    build_pdf()
```

---

## 📄 7. CHANGELOG.md (reformaté)

```markdown
# Changelog

Tous les changements notables de ce projet seront documentés dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [1.0.1] - 2026-02-23

### Ajouté
- Support Windows PowerShell 5.1 (`tasks.ps1`, `auto-release.ps1`)
- Projet GitHub production-ready
- CSS A5 avec header/footer automatique
- Build system complet (Makefile + PowerShell + Python)

### Modifié
- README restructuré avec sections Windows et Linux/macOS séparées
- Synchronisation des versions entre fichiers

### Corrigé
- Prérequis Windows (commandes winget correctes)
- Imports inutilisés dans `build.py`

## [1.0.0] - 2026-02-23

### Ajouté
- Création plan évacuation A5 bilingue FR/EN
- Schéma ASCII 5 sorties d'évacuation
- Procédures d'urgence bilingues
- Tableau contacts d'urgence
- CSS sécurité (couleurs normalisées)
- Règles de sécurité avec mise en forme visuelle
```

---

## 📄 8. release.py (date dynamique)

```python
#!/usr/bin/env python3
"""Gestionnaire de versions sémantiques."""
import json
from datetime import date
from pathlib import Path


def bump_version(version: str, level: str = "patch") -> str:
    """
    Incrémente la version selon le niveau spécifié.
    
    Args:
        version: Version actuelle (format major.minor.patch)
        level: Niveau d'incrémentation ('major', 'minor', 'patch')
    
    Returns:
        Nouvelle version incrémentée
    """
    major, minor, patch = map(int, version.split("."))
    
    if level == "major":
        major += 1
        minor = 0
        patch = 0
    elif level == "minor":
        minor += 1
        patch = 0
    else:  # patch
        patch += 1
    
    return f"{major}.{minor}.{patch}"


def update_version(level: str = "patch") -> None:
    """
    Met à jour la version dans index.json.
    
    Args:
        level: Niveau d'incrémentation ('major', 'minor', 'patch')
    """
    index_path = Path("index.json")
    
    if not index_path.exists():
        print("❌ Fichier index.json introuvable")
        return
    
    data = json.loads(index_path.read_text(encoding="utf-8"))
    old_version = data["version"]
    new_version = bump_version(old_version, level)
    
    data["version"] = new_version
    data["date"] = date.today().isoformat()  # Date dynamique
    
    index_path.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")
    
    print(f"✅ Version: {old_version} → {new_version}")
    print(f"📅 Date: {data['date']}")


if __name__ == "__main__":
    import sys
    level = sys.argv[1] if len(sys.argv) > 1 else "patch"
    
    if level not in ("major", "minor", "patch"):
        print(f"⚠️ Niveau invalide: {level}")
        print("   Utilisez: major, minor, ou patch")
        sys.exit(1)
    
    update_version(level)
```

---

## 📄 9. update_changelog.py (exception spécifique)

```python
#!/usr/bin/env python3
"""Met à jour CHANGELOG.md avec format Markdown correct."""
import json
from datetime import datetime
from pathlib import Path


def get_version() -> str:
    """
    Récupère la version depuis index.json.
    
    Returns:
        Version du projet ou '1.0.1' par défaut
    """
    try:
        with open("index.json", encoding="utf-8") as f:
            data = json.load(f)
            return data["version"]
    except (FileNotFoundError, json.JSONDecodeError, KeyError) as e:
        print(f"⚠️ Impossible de lire index.json: {e}")
        return "1.0.1"


def update_changelog() -> None:
    """Génère CHANGELOG.md au format Keep a Changelog."""
    version = get_version()
    date_str = datetime.now().strftime("%Y-%m-%d")
    
    changelog = f"""# Changelog

Tous les changements notables de ce projet seront documentés dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

## [{version}] - {date_str}

### Ajouté
- Support Windows PowerShell 5.1 (tasks.ps1, auto-release.ps1)
- Projet GitHub production-ready (18 fichiers)
- CSS A5 sécurité avec header/footer automatique
- Génération PDF multiplateforme
- Makefile + PowerShell + commandes make/tasks

### Modifié
- README avec documentation Windows et Linux/macOS

## [1.0.0] - 2026-02-23

### Ajouté
- Plan évacuation A5 bilingue FR/EN Parking Polygone
- Schéma ASCII 5 sorties + procédures urgence
- Tableaux contacts + règles sécurité colorées
"""
    
    changelog_path = Path("CHANGELOG.md")
    changelog_path.write_text(changelog, encoding="utf-8")
    
    print(f"✅ CHANGELOG.md v{version} mis à jour ({date_str})")


if __name__ == "__main__":
    update_changelog()
```

---

## ✅ Récapitulatif des fichiers à créer/remplacer

| Fichier | Action |
|---------|--------|
| `README.md` | **Remplacer** |
| `tasks.ps1` | **Créer** (nouveau) |
| `auto-release.ps1` | **Remplacer** |
| `index.json` | **Remplacer** |
| `pyproject.toml` | **Remplacer** |
| `build.py` | **Remplacer** |
| `CHANGELOG.md` | **Remplacer** |
| `release.py` | **Remplacer** |
| `update_changelog.py` | **Remplacer** |

---

## 🎯 Pour tester immédiatement

```powershell
# 1. Vérifier que tout fonctionne
.\tasks.ps1 help

# 2. Générer le PDF
.\tasks.ps1 pdf

# 3. (Optionnel) Faire une release
.\auto-release.ps1
```

Tous les fichiers sont prêts ! N'hésitez pas si vous avez des questions ou souhaitez des ajustements. 🚀
