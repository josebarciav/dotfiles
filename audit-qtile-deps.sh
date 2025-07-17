#!/usr/bin/env bash
# audit-qtile-deps.sh
# Script para generar listados de dependencias de tu configuración de Qtile

# Ruta al config.py de Qtile (por defecto ~/.config/qtile/config.py)
CONFIG_PATH="${1:-$HOME/.config/qtile/config.py}"
# Directorio donde se guardarán los archivos de salida (por defecto .)
OUTPUT_DIR="${2:-.}"

# Archivos de salida
PY_DEPS_FILE="$OUTPUT_DIR/qtile-python-deps.txt"
SYS_DEPS_FILE="$OUTPUT_DIR/qtile-system-deps.txt"

echo "Generando listado de módulos Python desde $CONFIG_PATH → $PY_DEPS_FILE"
grep -Eo "^import [[:alnum:]_.]+|^from [[:alnum:]_.]+ import" \
  "$CONFIG_PATH" \
  | sed -E "s/import |from //" \
  | cut -d' ' -f1 \
  | sort -u > "$PY_DEPS_FILE"

echo "Generando listado de paquetes del sistema (pacman -Qqe) → $SYS_DEPS_FILE"
pacman -Qqe | sort > "$SYS_DEPS_FILE"

echo "Listados generados en $OUTPUT_DIR:"
echo "  - Dependencias Python: $PY_DEPS_FILE"
echo "  - Dependencias sistema: $SYS_DEPS_FILE"

