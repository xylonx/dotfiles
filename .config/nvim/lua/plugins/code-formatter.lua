-- Format code on save
-- use conform instead as it is better
return {
  'stevearc/conform.nvim',
  opts = {
    -- Conform will run multiple formatters sequentially
    formatters_by_ft = {
      -- Program language
      lua = { 'stylua' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      javascript = { 'deno_fmt', 'prettierd', 'prettier', stop_after_first = true },
      go = { 'goimports' },
      python = { 'isort', 'black' },

      -- File
      toml = { 'taplo' },
      json = { 'deno_fmt', 'prettierd', 'prettier', stop_after_first = true },
      -- yaml = { 'deno_fmt', 'prettierd', 'prettier', stop_after_first = true },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
  },
}
-- return {
--   'mhartington/formatter.nvim',
--   config = function()
--     -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
--     require('formatter').setup({
--       logging = true,
--       log_level = vim.log.levels.WARN,
--       -- All formatter configurations are opt-in
--       filetype = {
--         html = { require('formatter.filetypes.javascript').prettier },
--         javascript = { require('formatter.filetypes.javascript').prettier },
--         javascriptreact = { require('formatter.filetypes.javascript').prettier },
--         lua = { require('formatter.filetypes.lua').stylua },
--         go = { require('formatter.filetypes.go').goimports },
--         python = {
--           require('formatter.filetypes.python').isort,
--           require('formatter.filetypes.python').black,
--         },
--         rust = {
--           require('formatter.filetypes.rust').rustfmt,
--         },
--       },
--     })
--
--     vim.api.nvim_create_augroup('__formatter__', { clear = true })
--     vim.api.nvim_create_autocmd('BufWritePost', {
--       group = '__formatter__',
--       command = ':FormatWrite',
--     })
--   end,
-- }
