require("config.plugins")
require("config.options")
require("config.keymaps")
require("config.nvimtree")
require("config.autocmds")
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {"ts_ls", "eslint"},
}
require("config.lsp")
