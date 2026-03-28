require('guess-indent').setup {}
vim.keymap.set('n', '<leader>gi', '<cmd>:GuessIndent<CR>', { desc = '[G]uess [I]ndent' })
