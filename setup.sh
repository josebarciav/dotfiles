
#!/bin/bash

echo "🔗 Creando enlaces simbólicos de configuración..."

DOTFILES_DIR=~/dotfiles

# Crear symlinks
ln -sf $DOTFILES_DIR/nvim ~/.config/nvim
ln -sf $DOTFILES_DIR/qtile ~/.config/qtile

echo "✅ Symlinks creados"

# Función para instalar un paquete si no existe
install_if_missing() {
  local pkg=$1
  local cmd=$2

  if ! command -v $cmd &> /dev/null; then
    echo "📦 $pkg no está instalado. Instalando..."
    if command -v pacman &> /dev/null; then
      sudo pacman -S --noconfirm $pkg
    elif command -v brew &> /dev/null; then
      brew install $pkg
    elif command -v apt &> /dev/null; then
      sudo apt update && sudo apt install -y $pkg
    else
      echo "❌ No se pudo determinar el gestor de paquetes para instalar $pkg"
    fi
  else
    echo "✅ $pkg ya está instalado."
  fi
}

echo "🔍 Verificando dependencias clave..."

install_if_missing "neovim" "nvim"
install_if_missing "lazygit" "lazygit"
install_if_missing "ripgrep" "rg"
install_if_missing "fd" "fd"
install_if_missing "nodejs" "node"
install_if_missing "npm" "npm"
install_if_missing "python3" "python3"
install_if_missing "pip" "pip"

echo "🚀 Setup completado con todas las dependencias."
