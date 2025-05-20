#!/bin/sh
set -e

# Rutas
HOST_DIR="/2826869/alejandro"      
CONTAINER_DIR="/app/app/static"  
INITIAL_FILES_DIR="/app/app/initial_files"

# Create/mount the host directory if it doesn't exist
if [ ! -d "$HOST_DIR" ]; then
  mkdir -p "$HOST_DIR"
fi

# Create target data directory in container
if [ ! -d "$CONTAINER_DIR" ]; then
  mkdir -p "$CONTAINER_DIR"
fi

# Symlink host directory into container path if not already
if [ ! -L "$CONTAINER_DIR/data" ]; then
  # Remove any existing files and create link
  rm -rf "$CONTAINER_DIR"
  ln -s "$HOST_DIR" "$CONTAINER_DIR"
fi

# If host directory is empty, copy initial files
if [ -z "$(ls -A "$HOST_DIR")" ]; then
  echo "[entrypoint] Host data empty, copying initial files..."
  cp -r "$INITIAL_FILES_DIR/." "$HOST_DIR/"
else
  echo "[entrypoint] Host data found, skipping initial copy."
fi

# Asegura permisos (ajusta según el usuario del contenedor)
chown -R $(whoami) "$HOST_DIR"