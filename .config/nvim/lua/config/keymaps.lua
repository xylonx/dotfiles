-- Use <Esc> to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- Change below keymaps to use which-key instead for better config

-- Map <A-j>, <A-k>, <A-h>, <A-l> to navigate between windows in any modes
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l')
vim.keymap.set({ 'n' }, '<A-h>', '<C-w>h')
vim.keymap.set({ 'n' }, '<A-j>', '<C-w>j')
vim.keymap.set({ 'n' }, '<A-k>', '<C-w>k')
vim.keymap.set({ 'n' }, '<A-l>', '<C-w>l')

-- fugitive keymaps
-- TODO(xylonx): config fugitive later
--

-- Map keys to toggle fzf-lua files
vim.keymap.set('n', '<D-f>', function()
  require('fzf-lua').global()
end, { desc = 'FzfLua: global' })
vim.keymap.set('n', '<D-b>', function()
  require('fzf-lua').buffers()
end, { desc = 'FzfLua: buffers' })

vim.keymap.set({ 'n', 'v', 'i' }, '<C-x><C-f>', function()
  require('fzf-lua').complete_path()
end, { silent = true, desc = 'Fuzzy complete path' })

-- enable map
vim.keymap.set('n', '<leader>rn', function()
  return ':IncRename ' .. vim.fn.expand('<cword>')
end, { expr = true })
