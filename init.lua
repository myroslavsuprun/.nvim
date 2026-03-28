require 'config'

vim.api.nvim_create_autocmd('PackChanged', {
  group = vim.api.nvim_create_augroup('pack-build-steps', { clear = true }),
  callback = function()
    if vim.fn.exists(':TSUpdate') == 2 then
      vim.cmd('TSUpdate')
    end
    -- telescope-fzf-native
    local fzf_path = vim.fn.stdpath('data') .. '/site/pack/core/opt/telescope-fzf-native.nvim'
    if vim.fn.isdirectory(fzf_path) == 1 then
      vim.fn.system({ 'make', '-C', fzf_path })
    end

  end,
})

vim.pack.add {
  -- Standalone
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/sainnhe/everforest',
  'https://github.com/echasnovski/mini.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/lukas-reineke/indent-blankline.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  -- Telescope chain
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
  'https://github.com/nvim-telescope/telescope.nvim',
  -- todo-comments (needs plenary)
  'https://github.com/folke/todo-comments.nvim',
  -- Mason chain
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  -- LSP (needs mason + blink)
  'https://github.com/neovim/nvim-lspconfig',
  -- Oil (needs web-devicons)
  'https://github.com/stevearc/oil.nvim',
}

-- Plugin configs
require 'plugins.everforest'
require 'plugins.guess-indent'
require 'plugins.fidget'
require 'plugins.mini'
require 'plugins.todo-comments'
require 'plugins.lazydev'
require 'plugins.telescope'
require 'plugins.lsp'
require 'plugins.mason'
require 'plugins.treesitter'
require 'plugins.gitsigns'
require 'plugins.indent_line'
require 'plugins.lualine'
require 'plugins.oil'
