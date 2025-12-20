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

-- Toggle format on modifications mode
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat-on-save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Re-enable autoformat-on-save',
})

-- vim.keymap.set("n", "your_keymap", function()
--   if vim.g.disable_autoformat then
--     vim.cmd("FormatEnable")
--     vim.notify("Formatting enabled", "info", { title = "Conform" })
--   else
--     vim.cmd("FormatDisable")
--     vim.notify("Formatting disabled", "info", { title = "Conform" })
--   end
-- end, { desc = "Toggle Formatting" })
