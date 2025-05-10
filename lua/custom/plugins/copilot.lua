return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      -- Due to cmp usage.
      -- suggestion = { enabled = false },
      -- panel = { enabled = false },

      suggestion = {
        auto_trigger = true,
      },
      filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
        gitrebase = true,
        hgcommit = true,
      },
    }
  end,
}
