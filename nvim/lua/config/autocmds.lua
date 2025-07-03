vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local stats = vim.loop.fs_stat(vim.fn.argv(0))
    if stats and stats.type == "directory" then
      require("nvim-tree.api").tree.open()
    end
  end
})
