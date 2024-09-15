return {
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  config = function()
    -- Set the default shiftwidth
    vim.opt.shiftwidth = 4
  end,
}
