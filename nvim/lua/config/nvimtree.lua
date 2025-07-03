require("nvim-tree").setup {
  view = {
    width = 30,
    side = "left",
    preserve_window_proportions = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  git = {
    enable = true,
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
}