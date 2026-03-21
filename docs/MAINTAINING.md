# Guide Mainteneur

## Ajout nouvelle version
```bash
make changelog LEVEL=patch
bash auto-release.sh
```

## Structure fichiers
```text
├── plan-evacuation.md     # Contenu principal
├── style-pdf.css          # Styles A5 sécurité
├── build.py              # Génération PDF
├── Makefile              # Commandes principales
└── tests/                # Tests Python
```

## Dépendances

```bash
# macOS
brew install pandoc wkhtmltopdf

# Ubuntu/Debian
sudo apt install pandoc wkhtmltopdf
```

***


