local settings = require 'config.settings'
local omakub = require 'config.omakub'

return {
  'folke/tokyonight.nvim',
  enabled = settings.is_enabled('ui', 'colorscheme'),
  lazy = false,
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('tokyonight').setup {
      styles = {
        comments = { italic = false },
      },
    }

    local colorscheme = omakub.get_colorscheme()
    vim.cmd.colorscheme(colorscheme)
  end,
}
