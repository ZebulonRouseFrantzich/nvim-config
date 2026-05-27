-- [[ User Commands ]]

vim.api.nvim_create_user_command('OmakubStatus', function()
  local omakub = require 'config.omakub'
  local is_installed = omakub.is_installed()
  local detected_theme = omakub.detect_theme()
  local detected_font = omakub.detect_font()
  local active_colorscheme = vim.g.colors_name or 'none'
  local active_font = vim.o.guifont ~= '' and vim.o.guifont or 'terminal font'

  print('=== Omakub Integration Status ===')
  print('Omakub installed: ' .. (is_installed and 'yes' or 'no'))
  print('Detected theme: ' .. (detected_theme or 'none'))
  print('Detected font: ' .. (detected_font or 'none'))
  print('Active colorscheme: ' .. active_colorscheme)
  print('Active font: ' .. active_font)
end, { desc = 'Show Omakub integration status' })

vim.api.nvim_create_user_command('ShowTheme', function()
  local colorscheme = vim.g.colors_name or 'none'
  print('Active colorscheme: ' .. colorscheme)
end, { desc = 'Show active colorscheme' })

vim.api.nvim_create_user_command('ShowFont', function()
  local font = vim.o.guifont ~= '' and vim.o.guifont or 'terminal font'
  print('Active font: ' .. font)
end, { desc = 'Show active font' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
