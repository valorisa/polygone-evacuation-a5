#!/usr/bin/env python3
"""Build PDF A5 pour plan-evacuation."""

import subprocess
import sys
import shutil
from pathlib import Path

def build_pdf():
    """Génère PDF avec Pandoc + CSS."""
    cmd = [
        "pandoc", "plan-evacuation.md",
        "-o", "plan-evacuation.pdf",
        "--css=style-pdf.css",
        "--pdf-engine=wkhtmltopdf",
        "--dpi=300",
        "-V", "geometry:margin=1.5cm",
        "-V", "papersize=a5"
    ]
    subprocess.run(cmd, check=True)
    print("✅ PDF généré : plan-evacuation.pdf")

if __name__ == "__main__":
    build_pdf()
