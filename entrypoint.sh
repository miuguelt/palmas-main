#!/bin/sh
set -e

# Paths\ nSTATIC_DIR="/app/app/static"
INITIAL_DIR="/initial_static"

# If host static is empty, first initialization
if [ -d "$STATIC_DIR" ] && [ -z "$(ls -A "$STATIC_DIR")" ]; then
  echo "[entrypoint] Initializing static files in host volume..."
  cp -r "$INITIAL_DIR/." "$STATIC_DIR/"
else
  echo "[entrypoint] Merging new static files into host volume..."
  # Copy only new files from initial to host
  find "$INITIAL_DIR" -type f | while read src; do
    relpath="${src#$INITIAL_DIR/}"
    dest="$STATIC_DIR/$relpath"
    if [ ! -e "$dest" ]; then
      echo "[entrypoint] Copying new file: $relpath"
      mkdir -p "$(dirname "$dest")"
      cp "$src" "$dest"
    fi
  done
fi

# Fix permissions (adjust user:group if needed)
chown -R nobody:nogroup "$STATIC_DIR" || true

# Execute main process
exec "$@"