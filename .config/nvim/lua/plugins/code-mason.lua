-- Package manager for LSP servers, linters and formatters
M = require('config.custom')

return {
  'mason-org/mason-lspconfig.nvim',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'neovim/nvim-lspconfig',
  },
  opts = {
    ensure_installed = M.ensure_installed_lsps,
    automatic_enable = {
      exclude = {
        'jdtls',
      },
    },
  },
}
-- return {
--   {
--     'mason-org/mason.nvim',
--     dependencies = {
--       { 'mason-org/mason-lspconfig.nvim' },
--     },
--     opts = {},
--     -- config = function()
--     --   require('mason').setup()
--     --   require('mason-lspconfig').setup() -- Automatically configures LSP servers
--     -- end,
--   },
-- }

-- return {
--   {
--     "mason-org/mason.nvim",
--     opts = {
--       pip = {
--         upgrade_pip = false, -- upgrade pip to the latest in the virtual env
--       }
--     }
--   },
--   {
--     "mason-org/mason-lspconfig.nvim",
--     dependencies = {
--       "mason-org/mason.nvim",
--       "neovim/nvim-lspconfig",
--     },
--     opts = {
--       automatic_enable = true,
--     },
--   }
-- }
