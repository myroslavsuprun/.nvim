-- [[ Setting options ]]

require 'opts'

-- [[ Basic Keymaps ]]

require 'keys'

-- [[ Basic Autocommands ]]

require 'autocmd'

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  require 'custom.plugins.which-key',
  require 'custom.plugins.telescope',
  require 'custom.plugins.harpoon',

  -- LSP Plugins
  require 'custom.plugins.lua-lsp',
  require 'custom.plugins.copilot',
  require 'custom.plugins.copilot-cmp',

  require 'custom.plugins.lsp',
  require 'custom.plugins.lint',
  require 'custom.plugins.format',
  require 'custom.plugins.completion',
  require 'custom.plugins.theme',

  require 'custom.plugins.treesitter',

  require 'custom.plugins.lualine',
  require 'custom.plugins.indent_line',
  require 'custom.plugins.autopairs',
  require 'custom.plugins.oil',
  require 'custom.plugins.gitsigns',
  require 'custom.plugins.lazygit',
}, {
  ui = {
    icons = {},
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
