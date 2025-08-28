return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon.setup {
      settings = {
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    }

    vim.keymap.set('n', '<M-q>', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon file 1' })
    vim.keymap.set('n', '<M-w>', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon file 2' })
    vim.keymap.set('n', '<M-e>', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon file 3' })
    vim.keymap.set('n', '<M-r>', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon file 4' })
    vim.keymap.set('n', '<M-t>', function()
      harpoon:list():select(5)
    end, { desc = 'Harpoon file 5' })
    vim.keymap.set('n', '<M-f>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon toggle menu' })
    vim.keymap.set('n', '<M-a>', function()
      harpoon:list():add()
    end, { desc = 'Harpoon add file' })
  end,
}
