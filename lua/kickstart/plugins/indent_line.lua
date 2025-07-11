return {
  'lukas-reineke/indent-blankline.nvim',
  -- See `:help ibl`
  main = 'ibl',
  config = function()
    local hl_list = {}
    for i, color in pairs { '#a13232', '#767621', '#216631', '#325a5e', '#324b7b', '#562155' } do
      local name = 'IndentBlanklineIndent' .. i
      vim.api.nvim_set_hl(0, name, { fg = color })
      table.insert(hl_list, name)
    end

    require('ibl').setup {
      indent = { highlight = hl_list, char = '▏' },
      whitespace = {
        highlight = hl_list,
        remove_blankline_trail = false,
      },
    }
  end,
}
