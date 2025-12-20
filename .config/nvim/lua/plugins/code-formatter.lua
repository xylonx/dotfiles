-- Format code on save

M = require('config.custom')

local function format_hunks()
  local ignore_filetypes = { "lua" }
  if vim.tbl_contains(ignore_filetypes, vim.bo.filetype) then
    vim.notify("range formatting for " .. vim.bo.filetype .. " not working properly.")
    return
  end

  local hunks = require("gitsigns").get_hunks()
  if hunks == nil then
    return
  end

  local format = require("conform").format

  local function format_range()
    if next(hunks) == nil then
      vim.notify("done formatting git hunks", "info", { title = "formatting" })
      return
    end
    local hunk = nil
    while next(hunks) ~= nil and (hunk == nil or hunk.type == "delete") do
      hunk = table.remove(hunks)
    end

    if hunk ~= nil and hunk.type ~= "delete" then
      local start = hunk.added.start
      local last = start + hunk.added.count
      -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
      local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
      local range = { start = { start, 0 }, ["end"] = { last - 1, last_hunk_line:len() } }
      format({ range = range, async = true, lsp_fallback = true }, function()
        vim.defer_fn(function()
          format_range()
        end, 1)
      end)
    end
  end

  format_range()
end

-- local function format_hunks()
--   local hunks = gitsigns.get_hunks()
--
--   if hunks == nil then
--     hunks = {}
--     local buf_status = vim.b.gitsigns_status_dict
--     -- if file is untracked format it whole
--     if buf_status.added == nil then
--       hunks[1] = {
--         type = 'untracked', -- custom type, for later processing
--         added = { start = 0, count = vim.api.nvim_buf_line_count(0) },
--       }
--     end
--   end
--
--   for i = #hunks, 1, -1 do
--     local hunk = hunks[i]
--     if hunk ~= nil and hunk.type ~= 'delete' then
--       local start = math.max(1, hunk.added.start) -- on untracked files, start is 0
--       local last = start + hunk.added.count
--       -- nvim_buf_get_lines uses zero-based indexing -> subtract from last
--       local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
--       local range = { start = { start, 0 }, ['end'] = { last - 1, last_hunk_line:len() } }
--       conform.format({ async = false, range = range })
--     end
--   end
-- end

return {
  'stevearc/conform.nvim',
  dependencies = {'lewis6991/gitsigns.nvim'},
  opts = {
    -- Conform will run multiple formatters sequentially
    formatters_by_ft = M.ensure_installed_formatters,
    -- Default format on save is not enough. Configure it manually
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      if vim.g.format_modifications_only then
        -- Prefer to format Git hunks over entire file
        format_hunks()
      else
        -- Format entire file
        return { timeout_ms = 2000, async = false, lsp_format = 'fallback' }
      end
    end,
    formatters = {
      clang_format = {
        command = 'clang-format',
        args = { '--style=file' }, -- uses .clang-format
        env = {},
      },
    },
  },
}
