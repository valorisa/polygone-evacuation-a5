# 🚨 **Polygone-Evacuation-A5**

[![Version](https://img.shields.io/badge/dynamic/json?url=https://raw.githubusercontent.com/valorisa/polygone-evacuation-a5/refs/heads/main/index.json&label=version&query=$.version&color=blue)](https://github.com/valorisa/polygone-evacuation-a5/releases)
[![Tests](https://img.shields.io/badge/tests-passing-brightgreen)](https://github.com/valorisa/polygone-evacuation-a5/actions)
[![Docker Ready](https://img.shields.io/badge/Docker-ready-blue)](Dockerfile)
[![Build PDF](https://img.shields.io/badge/PDF-A5%20ready-brightgreen)](https://github.com/valorisa/polygone-evacuation-a5)
[![Release](https://img.shields.io/badge/version-1.0.1-blue.svg)](https://github.com/valorisa/polygone-evacuation-a5/releases)

**Plan d'évacuation au format A5 bilingue (FR/EN) – Parking Polygone Montpellier**

> **Génère automatiquement** un PDF A5 imprimable de **sécurité professionnelle** avec schéma ASCII, procédures d'urgence, contacts et **header/footer automatiques**.

---

## 🚀 Démarrage rapide (recommandé)

### 🐳 Via Docker (toutes plateformes)
Docker garantit un environnement identique et évite d’installer Pandoc/wkhtmltopdf localement.

```bash
# 1. Build de l'image
docker build -t polygone-evacuation-a5 .

# 2. Génération du PDF (plan-evacuation.pdf apparaît dans le dossier courant)
docker run --rm -v "$(pwd):/data" polygone-evacuation-a5
```

*Note Windows (PowerShell) : utilisez `${PWD}` à la place de `$(pwd)`*  
```powershell
docker run --rm -v ${PWD}:/data polygone-evacuation-a5
```

---

## 🖥️ Usage Windows (PowerShell 5.1+)

```powershell
# 1. Cloner
git clone https://github.com/valorisa/polygone-evacuation-a5.git
Set-Location polygone-evacuation-a5

# 2. Générer le PDF
.\tasks.ps1 pdf

# 3. Vérifier le résultat
Get-Item plan-evacuation.pdf | Select-Object Name, Length
```

### Commandes disponibles (Windows)
| Action | Commande | Résultat |
| ------ | -------- | -------- |
| **PDF** | `.\tasks.ps1 pdf` | `plan-evacuation.pdf` (A5) |
| **Tests** | `.\tasks.ps1 test` | Exécute pytest |
| **Clean** | `.\tasks.ps1 clean` | Supprime le PDF |
| **Changelog** | `.\tasks.ps1 changelog` | Met à jour CHANGELOG.md |
| **Release** | `.\auto-release.ps1` | Publie sur GitHub |
| **Aide** | `.\tasks.ps1 help` | Liste des commandes |

---

## 🐧 Usage Linux/macOS (Bash)

```bash
# 1. Cloner
git clone https://github.com/valorisa/polygone-evacuation-a5.git
cd polygone-evacuation-a5

# 2. Générer le PDF
make pdf

# 3. Vérifier
ls -lh plan-evacuation.pdf
```

### Commandes disponibles (Linux/macOS)
| Action | Commande | Résultat |
| ------ | -------- | -------- |
| **PDF** | `make pdf` | `plan-evacuation.pdf` (A5) |
| **Tests** | `make test-all` | Exécute pytest |
| **Release** | `make changelog` | Met à jour CHANGELOG.md |
| **Setup** | `./setup-complete.sh` | Git + pre-commit + tests |
| **Clean** | `make clean` | Supprime PDF |

---

## ⚙️ Prérequis

### Docker (recommandé)
Aucune dépendance locale supplémentaire.

### Installation locale (si sans Docker)

**Windows**
```powershell
winget install JohnMacFarlane.Pandoc
winget install wkhtmltopdf.wkhtmltopdf
```

**macOS**
```bash
brew install pandoc wkhtmltopdf
```

**Ubuntu/Debian**
```bash
sudo apt install pandoc wkhtmltopdf
```

---

## 🔤 Encodage UTF‑8 et GitIngest (Windows)

Les utilisateurs PowerShell 5.1 peuvent rencontrer des problèmes d’encodage (mojibake, box‑drawing, etc.).  
Un guide dédié est disponible, avec un mini‑script prêt à l’emploi :

👉 **Voir : [DEV_SETUP.md](DEV_SETUP.md)**  
👉 Script : `tools/utf8_utils.ps1`

---

## 🎯 Fonctionnalités clés

- 📐 **Format A5 portrait** (148×210mm) – Imprimable urgence  
- 📑 **Header/footer automatique** – Chaque page numérotée  
- 🎨 **Couleurs sécurité** – Rouge/Vert/Jaune norme  
- 🗺️ **Schéma ASCII optimisé** – Bordures + ombre CSS  
- 🌍 **Bilingue FR/EN** – Procédures + contacts  
- 🤖 **100% automatisé** – Makefile + PowerShell + Python  
- 🐳 **Docker Ready** – Génération sans dépendances locales  

---

## 📁 Structure du projet

```text
polygone-evacuation-a5/
├── Dockerfile
├── DEV_SETUP.md
├── .editorconfig
├── .gitattributes
├── plan-evacuation.md
├── style-pdf.css
├── build.py
├── Makefile
├── tasks.ps1
├── auto-release.ps1
├── auto-release.sh
├── index.json
├── pyproject.toml
├── CHANGELOG.md
├── tools/
│   └── utf8_utils.ps1
└── LICENSE
```

---

## 📄 Exemple de rendu PDF A5

```text
┌─────────────────────────────────────────────────────┐
│ [HEADER ROUGE] PLAN D'ÉVACUATION – Page 1/2         │
├─────────────────────────────────────────────────────┤
│ 🗺️ SCHÉMA ASCII (5 sorties)                         │
│ 📋 PROCÉDURES FR (5 étapes)                         │
│ 📋 PROCEDURES EN (5 steps)                          │
│ 📞 CONTACTS (112, sécurité, etc.)                   │
│ ⚠️ RÈGLES (NE PAS / À FAIRE)                        │
├─────────────────────────────────────────────────────┤
│ [FOOTER] Page 1/2 | 23 février 2026                 │
└─────────────────────────────────────────────────────┘
```

---

## 🤖 Contribuer

1. Fork le projet  
2. `git checkout -b feature/improvements`  
3. **Configurer Git en LF** :
   ```bash
   git config core.autocrlf false
   git config core.eol lf
   ```
4. `.\tasks.ps1 test` (Windows) ou `make test-all` (Linux/macOS)  
5. `git push origin feature/improvements`  
6. Pull Request 🎉  

---

## 📜 Licence

[MIT](LICENSE) – © 2026 Bertrand Brodeau (@valorisa)
