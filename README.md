
# 🗂️ Dotfiles de Jose

Configuración personal para Arch Linux con Qtile y Neovim. Esta estructura permite mantener todo en un repositorio Git con enlaces simbólicos para facilitar el backup y la portabilidad.

---

## 📁 Estructura

```
dotfiles/
├── nvim/                # Configuración de Neovim
│   └── lua/
│       └── config/
│           ├── theme.lua       # Selector de temas sepia
│           └── lsp.lua         # Configuración de LSP
├── qtile/               # Configuración de Qtile
├── setup.sh             # Script de instalación de symlinks
└── README.md
```

---

## 🧠 Características destacadas

### 📝 Neovim

- Plugins gestionados con `lazy.nvim`
- LSP autoconfigurado con `mason.nvim` y `lspconfig`
- Selector interactivo de temas sepia-friendly
- Explorador de archivos (`nvim-tree`)
- Cliente SQL integrado (`vim-dadbod + UI`)
- Atajos personalizados con `<leader>`

### 🖥️ Qtile

- Configuración personalizada en `qtile/config.py` (separado)

---

## 🚀 Instalación en una nueva máquina

1. Clona el repositorio:

```bash
git clone https://github.com/tuusuario/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Ejecuta el script de setup:

```bash
./setup.sh
```

Este script crea los symlinks necesarios:

- `~/.config/nvim → ~/dotfiles/nvim`
- `~/.config/qtile → ~/dotfiles/qtile`

3. Abre Neovim y sincroniza los plugins:

```bash
nvim
:Lazy sync
```

---

## 🎨 Selector de tema sepia en Neovim

Pulsa:

```
<Space>ct
```

y selecciona tu esquema de color favorito.

---

## 🛠 Requisitos recomendados

- Neovim ≥ 0.9
- `git`, `lua`, `ripgrep`, `fd`
- `node`, `npm`, `python3`, `pip`
- `mason`, `lazy.nvim`

---

## 🔒 Licencia

MIT – libre de usar, modificar y compartir.

---

