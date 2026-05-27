-- Omakub integration module
-- Detects Omakub environment and parses theme/font configuration
local M = {}

-- Check if Omakub is installed
function M.is_installed()
  local omakub_path = vim.fn.expand '~/.local/share/omakub'
  return vim.fn.isdirectory(omakub_path) == 1
end

-- Parse Alacritty theme.toml to detect current theme
function M.detect_theme()
  local theme_file = vim.fn.expand '~/.config/alacritty/theme.toml'

  if vim.fn.filereadable(theme_file) ~= 1 then
    return nil
  end

  local content = table.concat(vim.fn.readfile(theme_file), '\n')

  local theme_map = {
    ['1a1b26'] = 'tokyo-night',
    ['24273a'] = 'catppuccin',
    ['2e3440'] = 'nord',
    ['2d353b'] = 'everforest',
    ['282828'] = 'gruvbox',
    ['1f1f28'] = 'kanagawa',
    ['121212'] = 'matte-black',
    ['111c18'] = 'osaka-jade',
    ['2c2525'] = 'ristretto',
    ['faf4ed'] = 'rose-pine',
  }

  for color, theme in pairs(theme_map) do
    if content:find(color, 1, true) then
      return theme
    end
  end

  return nil
end

-- Parse Alacritty font.toml to detect current font
function M.detect_font()
  local font_file = vim.fn.expand '~/.config/alacritty/font.toml'

  if vim.fn.filereadable(font_file) ~= 1 then
    return nil
  end

  local content = table.concat(vim.fn.readfile(font_file), '\n')

  -- Extract font family from: family = "CaskaydiaMono Nerd Font"
  local font_family = content:match 'family%s*=%s*"([^"]+)"'

  return font_family
end

-- Map Omakub theme name to Neovim colorscheme
M.theme_to_colorscheme = {
  ['tokyo-night'] = 'tokyonight',
  ['catppuccin'] = 'catppuccin',
  ['nord'] = 'nordfox',
  ['everforest'] = 'everforest',
  ['gruvbox'] = 'gruvbox',
  ['kanagawa'] = 'kanagawa',
  ['matte-black'] = 'matteblack',
  ['osaka-jade'] = 'bamboo',
  ['ristretto'] = 'monokai-pro',
  ['rose-pine'] = 'rose-pine-dawn',
}

-- Get the colorscheme to use (respects override priority)
function M.get_colorscheme()
  local settings = require 'config.settings'

  -- Priority 1: Manual override in settings.lua
  if settings.omakub and settings.omakub.colorscheme then
    return settings.omakub.colorscheme
  end

  -- Priority 2: Omakub auto-detection
  if M.is_installed() then
    local theme = M.detect_theme()
    if theme then
      return M.theme_to_colorscheme[theme]
    end
  end

  -- Priority 3: Default fallback
  return 'tokyonight-night'
end

-- Get the font to use (respects override priority)
function M.get_font()
  local settings = require 'config.settings'

  -- Priority 1: Manual override in settings.lua
  if settings.omakub and settings.omakub.font then
    return settings.omakub.font
  end

  -- Priority 2: Omakub auto-detection
  if M.is_installed() then
    local font = M.detect_font()
    if font then
      return font
    end
  end

  -- Priority 3: Default fallback (nil means use terminal font)
  return nil
end

return M
