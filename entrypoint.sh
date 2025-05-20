#!/bin/sh
set -e

# The static dir inside container is a mounted volume pointing to host
STATIC_DIR="/app/app/static"
# We saved initial static in image under /initial_static
INITIAL_DIR="/initial_static"

# If host static is empty, copy initial files
if [ -d "$STATIC_DIR" ] && [ -z "$(ls -A "$STATIC_DIR")" ]; then
  echo "[entrypoint] Initializing static files in host volume..."
  cp -r "$INITIAL_DIR/." "$STATIC_DIR/"
else
  echo "[entrypoint] Static volume contains files; skipping initialization."
fi

# Asegura permisos (ajusta según el usuario del contenedor)
chown -R $(whoami) "$STATIC_DIR"