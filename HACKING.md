# Dev Avancé

## Debug PDF
```bash
pandoc plan-evacuation.md -o debug.html --css=style-pdf.css
wkhtmltopdf --debug-javascript debug.html plan-evacuation.pdf
```

## Tests locaux
```bash
make test-all
pytest tests/test_build_pdf.py -v
```

## Pre-commit
```bash
pre-commit install
pre-commit run --all-files
```

***
