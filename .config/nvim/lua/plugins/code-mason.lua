-- Package manager for LSP servers, linters and formatters
return {
    {
        'mason-org/mason.nvim',
        dependencies = {
            { 'mason-org/mason-lspconfig.nvim' },
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup() -- Automatically configures LSP servers
        end,
    },
}

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
