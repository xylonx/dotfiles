-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Set global options
require('config.opts')

-- Load plugin manager
require('config.lazy')

-- Set custom keymaps
require('config.keymaps')

-- Set auto commands
require('config.auto_commands')

-- Set user commands
require('config.user_commands')

-- Set user commands
require('config.diagnostic')

-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
-- vim.cmd('packadd! nohlsearch')
