# Utilisation d'une image légère avec Pandoc pré-installé
FROM pandoc/core:3.1-alpine

# Installation de wkhtmltopdf et des polices essentielles pour le rendu
RUN apk add --no-cache \
    wkhtmltopdf \
    ttf-dejavu \
    fontconfig \
    python3 \
    bash

# Création d'un utilisateur non-root pour la sécurité
RUN adduser -D pandocexpert
USER pandocexpert

WORKDIR /data

# On ne copie que le nécessaire pour le build
COPY --chown=pandocexpert:pandocexpert . .

# Définition de l'encodage pour éviter tout souci sur les caractères spéciaux
ENV PYTHONUTF8=1
ENV LANG=C.UTF-8

# Commande de génération
ENTRYPOINT ["python3", "build.py"]
