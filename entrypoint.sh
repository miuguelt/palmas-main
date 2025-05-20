#!/bin/sh
set -e

# Rutas
APP_DATA_DIR="/app/app/static"      # Archivos iniciales en el contenedor
VOLUME_DIR="/2826869/alejandro"  # Volumen montado desde el host

# Verifica si el volumen está vacío
if [ -d "$VOLUME_DIR" ] && [ "$(ls -A $VOLUME_DIR)" ]; then
    echo "El volumen ya tiene datos. No se copian archivos iniciales."
else
    echo "El volumen está vacío. Copiando archivos iniciales..."
    cp -r "$APP_DATA_DIR"/. "$VOLUME_DIR"
fi