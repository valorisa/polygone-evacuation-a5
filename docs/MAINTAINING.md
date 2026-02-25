# Guide Mainteneur

## Ajout nouvelle version
```bash
make changelog LEVEL=patch
bash auto-release.sh
Structure fichiers
text
├── plan-evacuation.md     # Contenu principal
├── style-pdf.css          # Styles A5 sécurité
├── build.py              # Génération PDF
├── Makefile              # Commandes principales
└── tests/                # Tests Python
Dépendances
bash
# macOS
brew install pandoc wkhtmltopdf

# Ubuntu/Debian
sudo apt install pandoc wkhtmltopdf
text

***

## 1️⃣6️⃣ **`HACKING.md`**

```markdown
# Dev Avancé

## Debug PDF
```bash
pandoc plan-evacuation.md -o debug.html --css=style-pdf.css
wkhtmltopdf --debug-javascript debug.html plan-evacuation.pdf
Tests locaux
bash
make test-all
pytest tests/test_build_pdf.py -v
Pre-commit
bash
pre-commit install
pre-commit run --all-files
text

***

## 1️⃣7️⃣ **`setup-complete.sh`**

```bash
#!/bin/bash
echo "🧙‍♂️ SETUP COMPLET – polygone-evacuation-a5"

# Git
git init
git branch -M main
git add .
git commit -m "Initial commit: polygone-evacuation-a5 v1.0.0"

# Pre-commit
pip install pre-commit
pre-commit install

# Tests
pip install -e .[test]
make test-all

# PDF
make pdf

echo "✅ Setup terminé ! make pdf pour tester"
echo "🚀 git push && bash auto-release.sh"
