-- Example user override file
-- Copy this file to lua/plugins/user.lua to customize your plugin configuration
-- lua/plugins/user.lua is git-ignored, so it won't be tracked in version control
--
-- This file provides machine-specific overrides that take priority over
-- the settings in lua/config/settings.lua

return {
  -- Example: Disable a plugin that's enabled in settings.lua
  -- { 'github/copilot.vim', enabled = false },

  -- Example: Enable a plugin that's disabled in settings.lua
  -- { 'folke/tokyonight.nvim', enabled = true },

  -- Example: Override plugin options while keeping it enabled
  -- {
  --   'folke/tokyonight.nvim',
  --   opts = {
  --     style = 'storm', -- Change colorscheme variant
  --   },
  -- },

  -- Example: Disable multiple plugins
  -- { 'windwp/nvim-autopairs', enabled = false },
  -- { 'ThePrimeagen/harpoon', enabled = false },
  -- { 'kdheepak/lazygit.nvim', enabled = false },

  -- Example: Add a completely new plugin not in the main config
  -- {
  --   'tpope/vim-fugitive',
  --   cmd = { 'Git', 'G' },
  --   keys = {
  --     { '<leader>gs', '<cmd>Git<cr>', desc = 'Git status' },
  --   },
  -- },

  -- OMAKUB INTEGRATION EXAMPLES:

  -- Example: Override Omakub colorscheme detection
  -- Add to lua/config/settings.lua instead:
  -- M.omakub = { colorscheme = 'catppuccin' }

  -- Example: Override Omakub font detection
  -- Add to lua/config/settings.lua instead:
  -- M.omakub = { font = 'JetBrainsMono Nerd Font' }

  -- Example: Customize an Omakub theme plugin
  -- {
  --   'folke/tokyonight.nvim',
  --   opts = {
  --     style = 'storm',
  --     transparent = true,
  --   },
  -- },
}
