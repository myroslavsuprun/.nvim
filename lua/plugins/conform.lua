require('conform').setup {
  formatters_by_ft = {
    kotlin = { 'ktfmt' },
  },
  formatters = {
    ktfmt = {
      args = { '--kotlinlang-style', '-' },
    },
  },
}

vim.keymap.set('n', '<leader>f', function()
  require('conform').format { async = true }
end, { desc = 'Format buffer' })

vim.keymap.set('v', '<leader>f', function()
  require('conform').format { async = false }
end, { desc = 'Format selection' })
