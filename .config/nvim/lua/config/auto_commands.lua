-- Sync clipboard between OS and Neovim. Schedule the setting after `UiEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.opt.clipboard = 'unnamedplus'
  end,
})

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Treat .jsonl files as JSON
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.jsonl',
  command = 'setfiletype json',
})

-- Reduce the tab to 2
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('xylonx-filetype-indent', { clear = true }),
  pattern = require('config.custom').reduced_tabstop,
  callback = function()
    vim.bo.tabstop = 2
  end,
  desc = 'Decrease tabstop for certain filetypes.',
})

-- Disable line wrapping in quickfix and location lists
-- vim.api.nvim_create_autocmd('FileType', {
--  pattern = { 'qf', 'loclist' },
--  callback = function()
--    vim.bo.wrap = false
--  end,
--})

-- Disable search Highlight
vim.api.nvim_create_autocmd('CursorMoved', {
  group = vim.api.nvim_create_augroup('auto-hlsearch', { clear = true }),
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function()
        vim.cmd.nohlsearch()
      end)
    end
  end,
})

-- Enable inlay_hint
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf ---@type number
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      vim.keymap.set('n', '<leader>i', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
      end, { buffer = bufnr })
    end
  end,
})
