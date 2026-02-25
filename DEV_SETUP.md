# 🧰 DEV_SETUP – Encodage UTF‑8 & GitIngest (Windows)

Ce guide est destiné aux mainteneurs et utilisateurs avancés **PowerShell 5.1** qui analysent le dépôt via **GitIngest** ou des outils LLM.

---

## 🔤 Problème rencontré (PowerShell 5.1)

- Encodage par défaut **CP1252** → mojibake (`documentÃ©` au lieu de `documenté`)
- Les caractères Unicode box‑drawing (`│ └ ─`) cassent l’arborescence ASCII
- Certains dumps deviennent illisibles pour les LLM

---

## ✅ Solution recommandée

Le projet fournit un mini‑script prêt à l’emploi :

**tools/utf8_utils.ps1**

Il ajoute :
- ✅ lecture UTF‑8 (`cat8`)
- ✅ nettoyage box‑drawing (`Clean-Tree`)
- ✅ GitIngest propre (`gi-utf8`, `gi-quick`)
- ✅ variables d’environnement Python UTF‑8

---

## 📦 Installer GitIngest (si nécessaire)

```bash
pip install gitingest
# ou
pipx install gitingest
```

---

## 🚀 Usage rapide (session PowerShell)

```powershell
# Charger les fonctions
. .\tools\utf8_utils.ps1

# Lire un fichier en UTF‑8
cat8 CHANGELOG.md

# Dump GitIngest propre
gi-utf8 https://github.com/octocat/Hello-World
```

---

## 🧠 Ajout permanent dans le profil PowerShell

```powershell
# Ouvrir votre profil
notepad $PROFILE
```

Ajoutez à la fin :

```powershell
# UTF‑8 global
$env:PYTHONIOENCODING = "utf-8"
$env:PYTHONUTF8 = "1"

# Charger les utilitaires UTF‑8 du projet
. "C:\chemin\vers\polygone-evacuation-a5\tools\utf8_utils.ps1"
```

Rechargez ensuite :

```powershell
. $PROFILE
```

---

## ✅ Résultat attendu

- Plus de mojibake  
- Dumps GitIngest propres  
- Arborescences ASCII stables  
- Compatibilité LLM garantie  

---

## ℹ️ Astuce Git (LF recommandé)

```bash
git config core.autocrlf false
git config core.eol lf
```

---

© 2026 Bertrand Brodeau (@valorisa) – Licence MIT
