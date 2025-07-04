
-- ~/.config/nvim/lua/config/theme.lua

-- 🌿 Configuración predeterminada del tema al iniciar
vim.g.everforest_background = "soft"
vim.g.everforest_enable_italic = 1
vim.cmd("colorscheme everforest")

-- 🌅 Selector de temas cálidos/sepia
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>ct", function()
  local themes = {
    "everforest",
    "gruvbox",
    "rose-pine-dawn",
    "oxocarbon",
    "quiet",
    "edge"
  }

  vim.ui.select(themes, { prompt = "🌅 Selecciona un tema sepia:" }, function(choice)
    if choice then
      if choice == "rose-pine-dawn" then
        vim.cmd("colorscheme rose-pine-dawn")
      else
        vim.cmd("colorscheme " .. choice)
      end
      print("✅ Tema aplicado: " .. choice)
    end
  end)
end, opts)
