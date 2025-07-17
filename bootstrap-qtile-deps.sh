#!/usr/bin/env bash
# install-qtile-deps.sh
# Script para instalar automáticamente las dependencias listadas en:
#  - qtile-system-deps.txt  (paquetes de pacman)
#  - qtile-python-deps.txt  (módulos Python)

set -euo pipefail
IFS=$'\n\t'

# Archivos de dependencias generados por audit-qtile-deps.sh
def SYS_DEPS_FILE="${1:-./qtile-system-deps.txt}"
def PY_DEPS_FILE="${2:-./qtile-python-deps.txt}"

# Verificar existencia de archivos
echo "==> Comprobando archivos de dependencias"
if [[ ! -f "$SYS_DEPS_FILE" ]]; then
  echo "⚠️ No existe $SYS_DEPS_FILE. Ejecuta primero audit-qtile-deps.sh" >&2
  exit 1
fi
if [[ ! -f "$PY_DEPS_FILE" ]]; then
  echo "⚠️ No existe $PY_DEPS_FILE. Ejecuta primero audit-qtile-deps.sh" >&2
  exit 1
fi

echo "==> Instalando paquetes del sistema con pacman"
# Filtrar líneas vacías y comentarios y pasar a pacman
grep -E '^[[:alnum:]-]+' "$SYS_DEPS_FILE" | xargs sudo pacman -S --needed --noconfirm

echo "==> Instalando módulos Python con pip (usuario)"
# Leer módulos y pip install cada uno
grep -E '^[[:alnum:]_.]+' "$PY_DEPS_FILE" | \
while IFS= read -r mod; do
  echo "> pip install --user $mod"
  pip install --user "$mod"
done

cat <<EOF

✅ Instalación completada.
Revisa la salida para posibles errores y adapta los archivos de dependencias según sea necesario.
EOF

