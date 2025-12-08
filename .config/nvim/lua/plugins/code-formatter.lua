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
      typescript = { 'deno_fmt', 'prettierd', 'prettier', stop_after_first = true },
      go = { 'goimports' },
      python = { 'isort', 'black' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      h = { 'clang_format' },
      hpp = { 'clang_format' },

      -- File
      toml = { 'taplo' },
      json = { 'deno_fmt', 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'deno_fmt' },
      -- yaml = { 'deno_fmt', 'prettierd', 'prettier', stop_after_first = true },
    },
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    formatters = {
      clang_format = {
        command = 'clang-format',
        args = { '--style=file' }, -- uses .clang-format
        env = {},
        -- If the formatter supports range formatting, create the range arguments here
        --         range_args = function(self, ctx)
        --           return { '--line-start', ctx.range.start[1], '--line-end', ctx.range['end'][1] }
        --         end,
        --         -- Send file contents to stdin, read new contents from stdout (default true)
        --         -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
        --         -- file is assumed to be modified in-place by the format command.
        --         stdin = true,
        --         -- A function that calculates the directory to run the command in
        --         cwd = require('conform.util').root_file({ '.editorconfig', 'package.json' }),
        --         -- When cwd is not found, don't run the formatter (default false)
        --         require_cwd = true,
        --         -- When stdin=false, use this template to generate the temporary file that gets formatted
        --         tmpfile_format = '.conform.$RANDOM.$FILENAME',
        --         -- When returns false, the formatter will not be used
        --         condition = function(self, ctx)
        --           return vim.fs.basename(ctx.filename) ~= 'README.md'
        --         end,
        --         -- Exit codes that indicate success (default { 0 })
        --         exit_codes = { 0, 1 },
        --         -- Environment variables. This can also be a function that returns a table.
        --         env = {
        --           VAR = 'value',
        --         },
        --         -- Set to false to disable merging the config with the base definition.
        --         -- Can also be set to the name of the formatter to merge with (e.g. inherit = "black")
        --         inherit = true,
        --         -- When inherit = true, add these additional arguments to the beginning of the command.
        --         -- This can also be a function, like args
        --         prepend_args = { '--use-tabs' },
        --         -- When inherit = true, add these additional arguments to the end of the command.
        --         -- This can also be a function, like args
        --         append_args = { '--trailing-comma' },
      },
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
