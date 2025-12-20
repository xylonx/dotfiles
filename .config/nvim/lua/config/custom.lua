local M = {}

--- The Treesitter languages to be installed.
M.ensure_installed_treesitter = {
  'vim',
  'regex',
  'lua',
  'bash',
  'markdown',
  'markdown_inline',
  'comment',
  'python',
  'c',
  'cpp',
}

--- The LSPs to be installed by Mason.
M.ensure_installed_lsps = {
  'rust_analyzer',
  'stylua',
  'lua_ls',
  'clangd',
  'basedpyright',
  'jdtls',
  'bashls',
  'tinymist',
  'ts_ls',
  'neocmake',
}

--- The Linters to be installed by Mason.
M.ensure_installed_linters = {
  javascript = { 'oxlint' },
  typescript = { 'oxlint' },
}

--- The Formatters to be installed by Mason.
M.ensure_installed_formatters = {
  lua = { 'stylua' },
  -- python = { 'isort', 'black' },
  python = { 'ruff' },
  sh = { 'beautysh' },
  bash = { 'beautysh' },
  zsh = { 'beautysh' },
  -- sh = { 'shfmt' },
  -- bash = { 'shfmt' },
  -- zsh = { 'shfmt' },
  c = { 'clang-format' },
  cpp = { 'clang-format' },
  java = { 'google-java-format' },
  typst = { 'typstyle' },
  go = { 'goimports' },
  rust = { 'rustfmt', lsp_format = 'fallback' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  javascriptreact = { 'prettier' },
  typescriptreact = { 'prettier' },
  --  javascript = { 'deno_fmt', 'prettierd', 'prettier', stop_after_first = true },
  --  typescript = { 'deno_fmt', 'prettierd', 'prettier', stop_after_first = true },
  svelte = { 'prettier' },
  tex = { 'latexindent' },
  css = { 'prettier' },
  html = { 'prettier' },
  json = { 'prettier' },
  jsonc = { 'prettier' },
  yaml = { 'prettier' },
  toml = { 'taplo' },
  xml = { 'xmlformatter' },
  markdown = { 'prettier' },
  graphql = { 'prettier' },
  sql = { 'sql_formatter' },
}

--- The DAPs to be installed by Mason.
M.ensure_installed_daps = { 'codelldb', 'cpptools', 'debugpy' }

--- Decrease tabstop for certain filetypes
M.reduced_tabstop = {
  'fpp',
  'javascript',
  'javascriptreact',
  'json',
  'jsonc',
  'lua',
  'markdown',
  'plantuml',
  'sh',
  'typescriptreact',
  'typst',
}

return M
