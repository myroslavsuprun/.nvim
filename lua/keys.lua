-- Moving lines of code up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remove default copying to clipboard (only "y" and visual "x" is left)
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true, silent = true })
vim.keymap.set('n', 's', '"_s', { noremap = true, silent = true })
vim.keymap.set('n', 'S', '"_S', { noremap = true, silent = true })

-- Toggle highlighting
vim.keymap.set('n', 'm', ':set hlsearch!<CR>', { silent = true })
vim.keymap.set('v', 'm', ':set hlsearch!<CR>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>de', function()
  vim.diagnostic.open_float(nil)
end, { desc = 'Show [D]iagnostics [E]rror' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
