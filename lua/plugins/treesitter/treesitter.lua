-- Highlight, edit, and navigate code
local settings = require 'config.settings'

local install_dir = vim.fn.stdpath 'data' .. '/site'
local missing_parser_notified = {}
local ignored_filetypes = {
  oil = true,
}

local function maybe_notify_missing_parser(ft, lang)
  if ft == '' or missing_parser_notified[lang] then
    return
  end

  missing_parser_notified[lang] = true

  vim.schedule(function()
    vim.notify(
      string.format(
        "No Tree-sitter parser for '%s' (filetype '%s'). Run :TSInstall! %s. Use :TSLang to show filetype and Tree-sitter language again.",
        lang,
        ft,
        lang
      ),
      vim.log.levels.INFO,
      { title = 'treesitter' }
    )
  end)
end

local function maybe_set_indentexpr(buf, lang)
  local ok, query = pcall(vim.treesitter.query.get, lang, 'indents')
  if ok and query then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

return {
  'nvim-treesitter/nvim-treesitter',
  enabled = settings.is_enabled('treesitter', 'treesitter'),
  lazy = false,
  build = ':TSUpdate',
  opts = {
    install_dir = install_dir,
  },
  config = function(_, opts)
    local ts = require('nvim-treesitter')

    ts.setup(opts)

    vim.api.nvim_create_user_command('TSLang', function()
      local ft = vim.bo.filetype
      local lang = vim.treesitter.language.get_lang(ft) or ft

      vim.notify(string.format("filetype=%s treesitter=%s", ft, lang), vim.log.levels.INFO, {
        title = 'treesitter',
      })
    end, {
      desc = 'Show current buffer filetype and Tree-sitter language',
    })

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-setup', { clear = true }),
      pattern = '*',
      callback = function(args)
        local buf = args.buf

        if vim.bo[buf].buftype ~= '' then
          return
        end

        local ft = vim.bo[buf].filetype
        if ft == '' or ignored_filetypes[ft] then
          return
        end

        local lang = vim.treesitter.language.get_lang(ft) or ft
        local has_parser = vim.treesitter.language.add(lang)

        if not has_parser then
          maybe_notify_missing_parser(ft, lang)
          return
        end

        local ok = pcall(vim.treesitter.start, buf, lang)
        if ok then
          maybe_set_indentexpr(buf, lang)
        end
      end,
    })
  end,
}
