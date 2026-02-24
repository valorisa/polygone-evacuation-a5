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
