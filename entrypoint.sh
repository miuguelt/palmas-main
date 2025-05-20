#!/bin/sh
set -e

# Rutas
HOST_DIR="/2826869/alejandro"      # Archivos iniciales en el contenedor
CONTAINER_DIR="/2826869/alejandro"  # Volumen montado desde el host


# Crea enlaces simbólicos o copia archivos para que la app use HOST_DIR
ln -s "$HOST_DIR" "$CONTAINER_DIR"

# Si HOST_DIR no existe, intenta crearla (esto fallará si el usuario no tiene permisos en el host)
if [ ! -d "$HOST_DIR" ]; then
    echo "La carpeta $HOST_DIR no existe en el host. Esto causará un error en el contenedor."
    echo "Por favor, crea la carpeta manualmente o usa un script de inicialización en el host."
    exit 1
fi

# Si la carpeta está vacía, copia archivos iniciales
if [ "$(ls -A "$HOST_DIR")" = "" ]; then
    echo "Carpeta del host vacía. Copiando archivos iniciales..."
    cp -r /initial_files/* "$HOST_DIR/"
else
    echo "Carpeta del host no vacía. Fusionando archivos nuevos del contenedor..."
    
    # Copia solo archivos nuevos (sin sobreescribir)
    find /initial_files -type f -exec sh -c '
        for file; do
            base=$(basename "$file")
            if [ ! -f "$HOST_DIR/$base" ]; then
                cp "$file" "$HOST_DIR/$base"
            fi
        done
    ' sh {} +
fi

# Asegura permisos (ajusta según el usuario del contenedor)
chown -R $(whoami) "$HOST_DIR"