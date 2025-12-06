return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  ---@module "fzf-lua"
  ---@type fzf-lua.Config|{}
  ---@diagnostics disable: missing-fields
  opts = {
    file_ignore_patterns = {
      'node_modules',
      'dist',
      '.next',
      '.git',
      '.gitlab',
      'build',
      'target',
      'package-lock.json',
      'pnpm-lock.yaml',
      'yarn.lock',
    },
  },
  ---@diagnostics enable: missing-fields
}
