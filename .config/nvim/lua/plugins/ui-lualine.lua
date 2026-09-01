return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = { theme = 'tokyonight' },
    sections = {
      lualine_b = {
        {
          function()
            return vim.g.remote_neovim_host and ('Remote: %s'):format(vim.uv.os_gethostname()) or ''
          end,
          padding = { right = 1, left = 1 },
          separator = { left = '', right = '' },
        },
      },
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
