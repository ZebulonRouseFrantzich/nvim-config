-- Highlight, edit, and navigate code
local settings = require 'config.settings'

return {
  'nvim-treesitter/nvim-treesitter',
  enabled = settings.is_enabled('treesitter', 'treesitter'),
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')

    ts.install({
      'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
      'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc'
    }):wait(30000)

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-setup', { clear = true }),
      callback = function(args)
        local ft = vim.bo[args.buf].filetype

        pcall(vim.treesitter.start, args.buf)

        if ft == 'ruby' then
          vim.bo[args.buf].syntax = 'on'
        end

        if ft ~= 'ruby' then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
