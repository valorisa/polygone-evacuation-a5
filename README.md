# 🏢 Polygone Evacuation A5

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![Pandoc](https://img.shields.io/badge/pandoc-required-orange.svg)](https://pandoc.org/)

Plan d'évacuation pour le bâtiment Le Polygone à Montpellier, généré automatiquement en PDF A5 à partir d'un script.

---

## 📋 Table des matières

- [Fonctionnalités](#-fonctionnalités)
- [Structure du projet](#-structure-du-projet)
- [Prérequis](#-prérequis)
- [Installation](#-installation)
- [Usage](#-usage)
- [Dépannage (Accès PDF Refusé)](#-dépannage-accès-pdf-refusé)
- [Développement](#-développement)
- [Tests](#-tests)
- [Releases automatiques](#-releases-automatiques)
- [Contribution](#-contribution)
- [Licence](#-licence)

---

## ✨ Fonctionnalités

- ✅ Génération PDF A5 optimisée pour l'impression
- 🎨 Mise en page personnalisée avec CSS
- 🖼️ Support d'image de fond (plan du bâtiment)
- 🔄 Pipeline de build automatisé
- 📦 Releases GitHub automatiques
- 🐳 Support Docker pour builds reproductibles
- 🧪 Tests unitaires avec pytest

---

## 📂 Structure du projet

```text
PS C:\Users\bbrod\Projets\Polygone-Evacuation-a5> tree
.
├── DEV_SETUP.md
├── Dockerfile
├── LICENSE
├── Makefile
├── README.md
├── assets
│   ├── plan-background.jpg
│   └── style-pdf.css
├── build.py
├── docs
│   ├── CHANGELOG.md
│   ├── Hello-World.txt
│   ├── MAINTAINING.md
│   ├── Polygone-Evacuation-a5.txt
│   └── mon_projet.txt
├── index.json
├── plan-evacuation.md
├── plan-evacuation.pdf
├── pyproject.toml
├── pytest.ini
├── scripts
│   ├── auto-release.ps1
│   ├── auto-release.sh
│   ├── release.py
│   └── update_changelog.py
├── tasks.ps1
├── tests
│   ├── test-clean.txt
│   ├── test-hello.txt
│   ├── test-manuel.txt
│   └── test_utf8.txt
└── tools
    └── utf8_utils.ps1

5 directories, 28 files
```

---

## 🔧 Prérequis

### Outils requis

| Outil | Version minimale | Installation |
|-------|------------------|--------------|
| **Python** | 3.8+ | [python.org](https://www.python.org/downloads/) |
| **Pandoc** | 2.0+ | [pandoc.org](https://pandoc.org/installing.html) |
| **wkhtmltopdf** | 0.12.6+ | [wkhtmltopdf.org](https://wkhtmltopdf.org/downloads.html) |

### Vérification rapide

```powershell
python --version
pandoc --version
wkhtmltopdf --version
```

---

## 📥 Installation

### Windows (Chocolatey recommandé)

```powershell
# 1. Installer Chocolatey (si nécessaire)
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# 2. Installer les dépendances
choco install python pandoc wkhtmltopdf -y

# 3. Redémarrer PowerShell et vérifier
python --version
pandoc --version
wkhtmltopdf --version
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install python3 python3-pip pandoc wkhtmltopdf -y
```

### macOS (Homebrew)

```bash
brew install python pandoc wkhtmltopdf
```

---

## 🚀 Usage

### Usage Windows (PowerShell 5.1+)

```powershell
# 1. Cloner le projet
git clone https://github.com/valorisa/polygone-evacuation-a5.git
Set-Location polygone-evacuation-a5

# 2. Générer le PDF
.\tasks.ps1 pdf

# --- Résultat attendu en cas de succès ---
# Loading pages (1/6)
# Counting pages (2/6)
# Resolving links (4/6)
# Loading headers and footers (5/6)
# Printing pages (6/6)
# Done
# ✅ PDF généré : plan-evacuation.pdf
# ------------------------------------------

# 3. Vérifier le résultat
Get-Item plan-evacuation.pdf | Select-Object Name, Length
```

### Usage Linux/macOS

```bash
# 1. Cloner
git clone https://github.com/valorisa/polygone-evacuation-a5.git
cd polygone-evacuation-a5

# 2. Générer
make pdf

# 3. Vérifier
ls -lh plan-evacuation.pdf
```

### Usage Docker

```bash
docker build -t polygone-pdf .
docker run --rm -v $(pwd):/app polygone-pdf
```

---

## 🔍 Dépannage (Accès PDF Refusé)

Si vous rencontrez l'erreur **"L'accès au fichier a été refusé"** lors de l'ouverture du PDF avec Microsoft Edge, voici les solutions testées qui fonctionnent :

### 1. Ouvrir avec le lecteur système par défaut (Solution directe)
Au lieu de passer par le navigateur, utilisez ces commandes pour forcer l'ouverture avec votre application PDF (Acrobat, etc.) :
```powershell
Start-Process .\plan-evacuation.pdf
# OU
Invoke-Item .\plan-evacuation.pdf
```

### 2. Débloquer le fichier
Parfois, Windows bloque les fichiers générés par des scripts pour votre sécurité :
```powershell
Unblock-File -Path .\plan-evacuation.pdf
```

### 3. Solution radicale (Copie locale)
Si les droits du dossier projet sont trop restrictifs, copiez le fichier dans vos téléchargements :
```powershell
Copy-Item .\plan-evacuation.pdf -Destination $env:USERPROFILE\Downloads\
Start-Process "$env:USERPROFILE\Downloads\plan-evacuation.pdf"
```

---

## 🛠️ Développement

### Commandes disponibles

| Action | Windows | Linux/macOS | Résultat |
|--------|---------|-------------|----------|
| **PDF** | `.\tasks.ps1 pdf` | `make pdf` | `plan-evacuation.pdf` (A5) |
| **Tests** | `.\tasks.ps1 test` | `make test` | Exécute pytest |
| **Clean** | `.\tasks.ps1 clean` | `make clean` | Supprime les artifacts |
| **Release** | `.\tasks.ps1 release` | `make release` | Crée une release GitHub |

### Modifier le contenu

1. Éditez `plan-evacuation.md` avec vos informations
2. Ajustez le style dans `assets/style-pdf.css`
3. Remplacez l'image de fond `assets/plan-background.jpg` si nécessaire
4. Regénérez avec `python build.py`

---

## 🧪 Tests

```powershell
# Windows
.\tasks.ps1 test

# Linux/macOS
make test
```

Les tests vérifient :
- ✅ Encodage UTF-8 des fichiers Markdown
- ✅ Présence des dépendances (pandoc, wkhtmltopdf)
- ✅ Validation de la structure des fichiers

---

## 📦 Releases automatiques

Le projet inclut des scripts pour automatiser les releases GitHub :

### Windows
```powershell
.\scripts\auto-release.ps1 -Version "v1.2.0" -Message "Ajout de nouvelles sections"
```

### Linux/macOS
```bash
./scripts/auto-release.sh v1.2.0 "Ajout de nouvelles sections"
```

Les scripts :
1. Mettent à jour `CHANGELOG.md`
2. Créent un tag Git
3. Génèrent le PDF
4. Publient la release sur GitHub avec le PDF attaché

---

## 🤝 Contribution

Les contributions sont les bienvenues ! Consultez [MAINTAINING.md](docs/MAINTAINING.md) pour les détails.

### Workflow de contribution

1. Fork le projet
2. Créez une branche (`git checkout -b feature/AmazingFeature`)
3. Committez vos changements (`git commit -m 'feat: Add AmazingFeature'`)
4. Pushez vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request

### Conventions de commits

Nous utilisons [Conventional Commits](https://www.conventionalcommits.org/) :

- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Documentation
- `style:` Formatage, CSS
- `refactor:` Refactorisation de code
- `test:` Ajout/modification de tests
- `chore:` Tâches de maintenance

---

## 📄 Licence

Ce projet est sous licence MIT. Voir le fichier [LICENSE](LICENSE) pour plus de détails.

---

## 📞 Contact

- **Projet** : [Polygone-Evacuation-a5](https://github.com/valorisa/Polygone-Evacuation-a5)
- **Issues** : [GitHub Issues](https://github.com/valorisa/Polygone-Evacuation-a5/issues)

---

## 🙏 Remerciements

- [Pandoc](https://pandoc.org/) pour la conversion Markdown → HTML
- [wkhtmltopdf](https://wkhtmltopdf.org/) pour le rendu HTML → PDF
- La communauté Open Source pour les outils utilisés

---

**Made with ❤️ by Valorisa**
