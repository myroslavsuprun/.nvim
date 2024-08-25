return {
  'nvim-lualine/lualine.nvim',
  event = 'VimEnter',
  opts = {
    options = {
      icons_enabled = true,
      theme = 'everforest',
      component_separators = '|',
      section_separators = '',
      fmt = string.lower,
    },
    sections = {
      lualine_a = { {
        'mode',
        fmt = function(str)
          return str:sub(1, 1)
        end,
      } },
      lualine_c = {
        {
          'filename',
          path = 1,
        },
      },
      lualine_x = { 'filetype' },
    },
  },
}
