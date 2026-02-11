return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = { theme = 'tokyonight' },
    sections = {
      lualine_c = { { 'filename', file_status = false, full_path = true, shorten = false, path = 4 } },
      lualine_z = {
        'location',
        {
          'lsp_status',
          icon = '', -- f013
          symbols = {
            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
            done = '✓',
            separator = ' ',
          },
          ignore_lsp = { 'stylua' },
          show_name = true,
        },
      },
    },
  },
}
