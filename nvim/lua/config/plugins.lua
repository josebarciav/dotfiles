vim.opt.rtp:prepend("~/.config/nvim/lua/lazy")

require("lazy").setup({
  -- Soporte básico
  { "nvim-lua/plenary.nvim" },
  { "nvim-tree/nvim-web-devicons" },

  -- UI
  { "nvim-lualine/lualine.nvim" },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Explorador de archivos
  { "nvim-tree/nvim-tree.lua" },

  -- Git
  {
  "kdheepak/lazygit.nvim",
  cmd = "LazyGit",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Abrir LazyGit" }
  }
},

  -- Fuzzy Finder
  { "nvim-telescope/telescope.nvim", tag = "0.1.3" },

  -- Syntax Highlight + Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Autocompletado
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },
  { "saadparwaiz1/cmp_luasnip" },
  { "rafamadriz/friendly-snippets" },

  -- THEMES
  -- 🌿 Everforest
{
  "sainnhe/everforest",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.everforest_background = "soft"  -- soft | medium | hard
    vim.g.everforest_enable_italic = 1
    vim.cmd("colorscheme everforest")
  end,
},

-- 🟤 Gruvbox
{
  "morhetz/gruvbox",
  lazy = true,
},

-- 🌸 Rosé Pine (modo dawn para sepia claro)
{
  "rose-pine/neovim",
  name = "rose-pine",
  lazy = true,
},

-- 🟤 Oxocarbon
{
  "nyoom-engineering/oxocarbon.nvim",
  lazy = true,
},

-- 🔥 Edge (modo warm)
{
  "sainnhe/edge",
  lazy = true,
},


  -- Cliente SQL tipo DBeaver
  {
    "tpope/vim-dadbod",
    lazy = true,
    cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection" },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    lazy = true,
    dependencies = { "tpope/vim-dadbod" },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection" },
    init = function()
      vim.g.db_ui_save_location = vim.fn.stdpath("config") .. "/db_ui"
    end,
  },
})
