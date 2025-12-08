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
  'stylua',
  'clangd',
  'basedpyright',
  'bashls',
  'tinymist',
  'ts_ls',
  --  'neocmake',
}

--- The Linters to be installed by Mason.
M.ensure_installed_linters = {
  javascript = { 'oxlint' },
  typescript = { 'oxlint' },
}

--- The Formatters to be installed by Mason.
M.ensure_installed_formatters = {
  lua = { 'stylua' },
  python = { 'isort', 'black' },
  sh = { 'shfmt' },
  bash = { 'shfmt' },
  zsh = { 'shfmt' },
  c = { 'clang-format' },
  cpp = { 'clang-format' },
  java = { 'google-java-format' },
  typst = { 'typstyle' },
  javascript = { 'prettier' },
  typescript = { 'prettier' },
  javascriptreact = { 'prettier' },
  typescriptreact = { 'prettier' },
  --  svelte = { "prettier" },
  --  tex = { "latexindent" },
  css = { 'prettier' },
  html = { 'prettier' },
  json = { 'prettier' },
  jsonc = { 'prettier' },
  yaml = { 'prettier' },
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
