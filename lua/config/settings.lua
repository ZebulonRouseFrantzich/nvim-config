-- Plugin enable/disable settings
-- Plugins are disabled by default unless explicitly enabled here
-- Organized by plugin folder for easy navigation

local M = {}

-- Plugin toggles organized by category (folder structure)
M.plugins = {
  -- lua/plugins/coding/
  coding = {
    autopairs = true,
    ['blink-cmp'] = true,
    copilot = true,
    luasnip = true,
    ['mini-comment'] = false,
    ['nvim-ts-autotag'] = true,
  },

  -- lua/plugins/editor/
  editor = {
    telescope = false,
    ['mini-pick'] = true,
    ['mini-ai'] = true,
    ['mini-files'] = false,
    ['mini-jump2d'] = true,
    ['mini-surround'] = true,
    harpoon = true,
    oil = true,
    ['which-key'] = true,
  },

  -- lua/plugins/formatting/
  formatting = {
    conform = true,
  },

  -- lua/plugins/git/
  git = {
    gitsigns = true,
    lazygit = true,
  },

  -- lua/plugins/lsp/
  lsp = {
    lspconfig = true,
    mason = true,
    ['typescript-tools'] = true,
  },

  -- lua/plugins/treesitter/
  treesitter = {
    treesitter = true,
  },

  -- lua/plugins/ui/
  ui = {
    colorscheme = true,
    ['indent-line'] = true,
    ['mini-animate'] = true,
    ['mini-icons'] = true,
    ['mini-indentscope'] = false,
    ['mini-statusline'] = true,
    ['render-markdown'] = true,
    ['todo-comments'] = true,
  },

  -- lua/plugins/utils/
  utils = {
    ['guess-indent'] = true,
    lazydev = true,
  },
}

M.omakub = {
  -- colorscheme = 'catppuccin',
  -- font = 'JetBrainsMono Nerd Font',
}

function M.is_enabled(category, plugin_name)
  if M.plugins[category] and M.plugins[category][plugin_name] ~= nil then
    return M.plugins[category][plugin_name]
  end
  return false -- Default to disabled if not in settings
end

return M
