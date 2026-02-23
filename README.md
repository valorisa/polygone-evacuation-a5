# 🧯 **Polygone-Evacuation-a5**

[![Tests](https://img.shields.io/badge/tests-passing-brightgreen)](https://github.com/valorisa/polygone-evacuation-a5/actions)
[![Build PDF](https://img.shields.io/badge/PDF-A5%20ready-brightgreen)](https://github.com/valorisa/polygone-evacuation-a5)
[![Release](https://img.shields.io/badge/version-1.0.1-blue.svg)](https://github.com/valorisa/polygone-evacuation-a5/releases)

**Plan d'évacuation A5 bilingue (FR/EN) – Parking Polygone Montpellier**

> **Génère automatiquement** un PDF A5 imprimable de **sécurité professionnelle** avec schéma ASCII, procédures d'urgence, contacts et **header/footer automatiques**.

![PDF A5 exemple](https://via.placeholder.com/300x420/ffebee/000000?text=A5+Plan+%C3%89vacuation)

## 🚀 **Usage rapide (4 commandes)**

```bash
./setup-complete.sh        # 🧙‍♂️ Init complète (3 min)
make pdf                   # 📄 Génère PDF A5 parfait
make changelog LEVEL=patch # 🆕 Nouvelle version
bash auto-release.sh       # 🚀 Publier GitHub
```

## 📋 **Commandes principales**

| Action | Commande | Résultat |
|--------|----------|----------|
| **PDF** | `make pdf` | `plan-evacuation.pdf` (A5) |
| **Tests** | `make test-all` | 100% coverage |
| **Release** | `make changelog` | v1.0.1 + CHANGELOG |
| **Setup** | `./setup-complete.sh` | Git + pre-commit + tests |
| **Clean** | `make clean` | Supprime PDF |

## 🎨 **Fonctionnalités clés**

- ✅ **Format A5 portrait** (148×210mm) – Imprimable urgence
- ✅ **Header/footer automatique** – Chaque page numérotée
- ✅ **Couleurs sécurité** – Rouge/Vert/Jaune norme
- ✅ **Schéma ASCII optimisé** – Bordures + ombre CSS
- ✅ **Bilingue FR/EN** – Procédures + contacts
- ✅ **100% automatisé** – Makefile + Python + GitHub Actions
- ✅ **Multiplateforme** – Linux/macOS/Windows

## 📁 **Structure du projet**

```
📁 polygone-evacuation-a5/
├── 📄 plan-evacuation.md     # Contenu principal bilingue
├── 🎨 style-pdf.css          # CSS A5 sécurité pro
├── 🖼️ 1000023888.jpg         # Photo parking (filigrane)
├── 🐍 build.py               # Génération PDF Python
├── 🚀 Makefile               # 20+ commandes
├── 🧪 tests/                 # Tests Python complets
├── ⚙️ pyproject.toml         # Dépendances modernes
└── .github/workflows/        # CI/CD GitHub Actions
```

## 🧪 **Installation rapide**

```bash
# 1. Clone
git clone https://github.com/valorisa/polygone-evacuation-a5.git
cd polygone-evacuation-a5

# 2. Setup (3 min)
./setup-complete.sh

# 3. Test
make pdf
ls -lh plan-evacuation.pdf  # ~150KB A5 parfait
```

## 🔧 **Prérequis**

| Système | Commande |
|---------|----------|
| **macOS** | `brew install pandoc wkhtmltopdf` |
| **Ubuntu** | `sudo apt install pandoc wkhtmltopdf` |
| **Windows** | `winget install Pandoc.Wkhtmltopdf` |

## 🎯 **Exemple de rendu PDF A5**

```
[HEADER ROUGE] PLAN D'ÉVACUATION – Page 1/2 | 23 fév. 2026

🅿️ SCHÉMA ASCII (5 sorties)
📋 PROCÉDURES FR (5 étapes)
📋 PROCEDURES EN (5 steps)
📞 CONTACTS (112, sécurité, etc.)
⚠️ RÈGLES (NE PAS / À FAIRE)

[FOOTER] Page 1/2 | 23 février 2026
```

## 🤝 **Contribuer**

1. Fork le projet
2. `git checkout -b feature/improvements`
3. `make test-all`
4. `git push origin feature/improvements`
5. Pull Request !

## 📄 **Licence**

[MIT](LICENSE) – © 2026 Bertrand Brodeau (@valorisa)
