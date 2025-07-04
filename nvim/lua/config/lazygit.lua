
-- ~/.config/nvim/lua/config/lazygit.lua

-- Abre LazyGit en una ventana flotante o terminal integrada
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Atajo: <leader>gg para abrir lazygit
map("n", "<leader>gg", function()
  local lazygit_cmd = "LazyGit"

  -- Si lazygit.nvim está instalado
  if pcall(require, "lazygit") then
    require("lazygit").lazygit()
  else
    -- Abre lazygit en terminal flotante como fallback
    vim.cmd("botright 15split | terminal lazygit")
  end
end, opts)
