
-- ~/.config/nvim/lua/config/nvimtree.lua

-- Configuración de NvimTree con keymaps personalizados y ayuda flotante
require("nvim-tree").setup({
  view = {
    width = 35,
    relativenumber = true,
  },
  renderer = {
    indent_markers = { enable = true },
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open = "",
        },
      },
    },
  },
  on_attach = function(bufnr)
    local api = require("nvim-tree.api")
    local map = vim.keymap.set

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true }
    end

    -- Keymaps personalizados
    map("n", "<CR>", api.node.open.edit, opts("Abrir archivo"))
    map("n", "o", api.node.open.edit, opts("Abrir archivo"))
    map("n", "<BS>", api.node.navigate.parent_close, opts("Cerrar carpeta"))
    map("n", "h", api.node.navigate.parent_close, opts("Subir nivel"))
    map("n", "l", api.node.open.edit, opts("Abrir"))
    map("n", "v", api.node.open.vertical, opts("Abrir en split vertical"))
    map("n", "s", api.node.open.horizontal, opts("Abrir en split horizontal"))
    map("n", "a", api.fs.create, opts("Crear archivo o carpeta"))
    map("n", "d", api.fs.remove, opts("Eliminar"))
    map("n", "r", api.fs.rename, opts("Renombrar"))
    map("n", "x", api.fs.cut, opts("Cortar"))
    map("n", "y", api.fs.copy.node, opts("Copiar"))
    map("n", "p", api.fs.paste, opts("Pegar"))
    map("n", "R", api.tree.reload, opts("Recargar árbol"))
    map("n", "q", api.tree.close, opts("Cerrar árbol"))
    map("n", ".", api.tree.change_root_to_node, opts("Cambiar raíz"))
    map("n", "u", api.tree.change_root_to_parent, opts("Subir raíz"))

    -- Ventana flotante de ayuda
    vim.defer_fn(function()
      local help_lines = {
        "  NvimTree Keymaps",
        "----------------------------------------",
        "<CR> / o / l     → Abrir archivo",
        "<BS> / h         → Subir/cerrar carpeta",
        "v / s            → Abrir vertical / horizontal",
        "a / d / r        → Crear / borrar / renombrar",
        "x / y / p        → Cortar / copiar / pegar",
        "R                → Recargar árbol",
        "q                → Cerrar árbol",
        ". / u            → Cambiar / subir raíz",
      }

      local buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, help_lines)
      vim.api.nvim_buf_set_option(buf, "modifiable", false)

      local width = 40
      local height = #help_lines
      local win_opts = {
        relative = "editor",
        width = width,
        height = height,
        row = 2,
        col = vim.o.columns - width - 2,
        style = "minimal",
        border = "rounded",
      }

      local win = vim.api.nvim_open_win(buf, false, win_opts)

      -- Cerrar ventana al salir del buffer o con 'q'
      vim.api.nvim_create_autocmd({ "BufLeave", "BufHidden" }, {
        buffer = bufnr,
        callback = function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end,
      })

      vim.keymap.set("n", "q", function()
        if vim.api.nvim_win_is_valid(win) then
          vim.api.nvim_win_close(win, true)
        end
      end, { buffer = buf, silent = true })
    end, 200)
  end,
})
