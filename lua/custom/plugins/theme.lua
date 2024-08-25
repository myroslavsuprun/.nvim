return {
  'sainnhe/everforest',
  priority = 1000,
  lazy = false,
  config = function()
    vim.g.everforest_enable_italic = true
    vim.g.everforest_background = 'soft' -- 'hard'`, `'medium'`, `'soft'
    vim.g.everforest_sign_column_background = 'none' -- 'none', 'grey'
    vim.g.everforest_diagnostic_virtual_text = 'colored'

    vim.cmd.colorscheme 'everforest'
    vim.cmd.hi 'Comment gui=none'
  end,
}
