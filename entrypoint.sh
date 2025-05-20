#!/bin/sh
set -e

# Rutas
APP_DATA_DIR="/2826869/alejandro"      # Archivos iniciales en el contenedor
VOLUME_DIR="/app/app/static"  # Volumen montado desde el host

# Crea directorio en el contenedor si no existe
mkdir -p "$APP_DATA_DIR"

# Si el volumen está vacío, copia todo desde el contenedor
if [ ! -d "$VOLUME_DIR" ] || [ "$(ls -A "$VOLUME_DIR")" = "" ]; then
    echo "Volumen vacío. Copiando archivos iniciales del contenedor..."
    cp -r "$APP_DATA_DIR"/. "$VOLUME_DIR/"
else
    echo "Volumen no vacío. Fusionando archivos nuevos del contenedor..."
    
    # Usa rsync para copiar solo archivos nuevos o modificados (sin sobreescribir)
    rsync -a --ignore-existing "$APP_DATA_DIR"/ "$VOLUME_DIR"/
fi