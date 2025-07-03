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
