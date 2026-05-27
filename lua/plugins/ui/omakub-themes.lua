local settings = require 'config.settings'

if not settings.is_enabled('ui', 'colorscheme') then
  return {}
end

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    priority = 1000,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'neanias/everforest-nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    priority = 1000,
  },
  {
    'tahayvr/matteblack.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'ribru17/bamboo.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('bamboo').setup {}
    end,
  },
  {
    'loctvl842/monokai-pro.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('monokai-pro').setup {
        filter = 'ristretto',
        override = function()
          return {
            NonText = { fg = '#948a8b' },
          }
        end,
      }
    end,
  },
}
