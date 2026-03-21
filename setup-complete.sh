## setup-complete.sh

```bash
#!/bin/bash
echo "🧙‍♂️ SETUP COMPLET – polygone-evacuation-a5"
```

# Git
```bash
git init
git branch -M main
git add .
git commit -m "Initial commit: polygone-evacuation-a5 v1.0.0"
```

# Pre-commit
```bash
pip install pre-commit
pre-commit install
```
# Tests
```bash
pip install -e .[test]
make test-all
```

# PDF
```bash
make pdf
echo "✅ Setup terminé ! make pdf pour tester"
echo "🚀 git push && bash auto-release.sh"*
```
