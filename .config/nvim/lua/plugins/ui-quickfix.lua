return {
  {
    'kevinhwang91/nvim-bqf',
    opts = {
      -- make `drop` and `tab drop` to become preferred
      func_map = {
        drop = 'o',
        openc = 'O',
        split = '<C-s>',
        tabdrop = '<C-t>',
        -- set to empty string to disable
        tabc = '',
        ptogglemode = 'z,',
      },
      filter = {
        fzf = {
          action_for = { ['ctrl-s'] = 'split', ['ctrl-t'] = 'tab drop' },
          extra_opts = { '--bind', 'ctrl-o:toggle-all', '--prompt', '> ' },
        },
      },
    },
  },
  {
    'stevearc/quicker.nvim',
    ft = 'qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
  },
}
