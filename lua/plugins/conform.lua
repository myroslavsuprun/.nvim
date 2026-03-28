require('conform').setup {
  default_format_opts = {
    lsp_format = 'prefer',
  },
}
vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true }
end, { desc = 'Format buffer' })
