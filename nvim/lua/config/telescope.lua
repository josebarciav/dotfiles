
-- ~/.config/nvim/lua/config/telescope.lua

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
    sorting_strategy = "ascending",
    winblend = 10,
    border = true,
    prompt_prefix = "🔍 ",
    selection_caret = " ",
  },
  pickers = {
    find_files = { theme = "dropdown" },
    live_grep = { theme = "dropdown" },
    buffers = { theme = "dropdown" },
    help_tags = { theme = "dropdown" },
  },
})

-- 📦 Keymaps útiles para Telescope
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>ff", builtin.find_files, { desc = "Buscar archivos (Telescope)" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Buscar texto (live grep)" })
map("n", "<leader>fb", builtin.buffers, { desc = "Listar buffers abiertos" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Buscar en ayuda" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Archivos recientes" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Ver diagnósticos" })
map("n", "<leader>fm", builtin.marks, { desc = "Ver marcadores" })
map("n", "<leader>cs", builtin.colorscheme, { desc = "Seleccionar colorscheme" })
