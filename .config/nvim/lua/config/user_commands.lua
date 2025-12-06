-- vim:foldmethod=marker:foldlevel=0
--
-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`
  local filename = vim.api.nvim_buf_get_name(0)
  print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })

-- Convert tabs to spaces
vim.api.nvim_create_user_command('Tab2Space', function(opts)
    local ts = vim.opt.tabstop:get()
    local range = opts.range
    vim.cmd(string.format('%d,%ds#^\\t\\+#\\=repeat(" ", len(submatch(0))*%d)', range[1], range[2], ts))
end, { range = '%' })
