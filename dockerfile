# Image Pandoc officielle (légère, maintenue)
FROM pandoc/core:3.1

# Installe wkhtmltopdf + polices de base
RUN apk add --no-cache \
    wkhtmltopdf \
    ttf-dejavu \
    fontconfig \
    bash \
    ca-certificates && \
    update-ca-certificates

WORKDIR /data
COPY . /data

# Par défaut : génère le PDF
CMD ["python3", "build.py"]
