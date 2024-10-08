vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Toggle hightlighting
vim.keymap.set('n', 'm', ':set hlsearch!<CR>', { silent = true })
vim.keymap.set('v', 'm', ':set hlsearch!<CR>', { silent = true })

-- Remove default copying to clipboard (only "y" and visual "x" is left)
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('n', 'd', '"_d', { noremap = true, silent = true })
vim.keymap.set('n', 'D', '"_D', { noremap = true, silent = true })
vim.keymap.set('n', 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set('n', 'C', '"_C', { noremap = true, silent = true })
vim.keymap.set('n', 's', '"_s', { noremap = true, silent = true })
vim.keymap.set('n', 'S', '"_S', { noremap = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Moving lines of code up and down
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { silent = true })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })

-- Moving between different buffers as windows (don't know exactly how it is called)
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- LazyGit keymaps
vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { silent = true, desc = 'Open [L]azy[G]it' })

-- Saving the current buffer
vim.keymap.set('n', '<C-s>', function()
  vim.cmd 'silent! w'
end, { desc = 'Save current buffer' })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>sr', function()
  require('telescope').extensions.frecency.frecency {
    workspace = 'CWD',
  }
end, { desc = '[S]earch [R]ecently opened files' })

-- Oil nvim
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sl', require('telescope.builtin').resume, { desc = '[S]earch [L]ast' })

local harpoon = require 'harpoon'

-- local conf = require('telescope.config').values
-- local function toggle_telescope(harpoon_files)
--   local file_paths = {}
--   for _, item in ipairs(harpoon_files.items) do
--     table.insert(file_paths, item.value)
--   end
--
--   require('telescope.pickers')
--       .new({}, {
--         prompt_title = 'Harpoon',
--         finder = require('telescope.finders').new_table {
--           results = file_paths,
--         },
--         previewer = conf.file_previewer {},
--         sorter = conf.generic_sorter {},
--       })
--       :find()
-- end

vim.keymap.set('n', '<M-1>', function()
  harpoon:list():select(1)
end, { desc = 'Harpoon file 1' })
vim.keymap.set('n', '<M-2>', function()
  harpoon:list():select(2)
end, { desc = 'Harpoon file 2' })
vim.keymap.set('n', '<M-3>', function()
  harpoon:list():select(3)
end, { desc = 'Harpoon file 3' })
vim.keymap.set('n', '<M-4>', function()
  harpoon:list():select(4)
end, { desc = 'Harpoon file 4' })
vim.keymap.set('n', '<M-5>', function()
  harpoon:list():select(5)
end, { desc = 'Harpoon file 5' })
vim.keymap.set('n', '<M-e>', function()
  -- toggle_telescope(harpoon:list())
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = 'Harpoon toggle menu' })
vim.keymap.set('n', '<M-a>', function()
  harpoon:list():add()
end, { desc = 'Harpoon add file' })
