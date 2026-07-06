return {
  'nvim-treesitter/nvim-treesitter',
  -- branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')

    -- -- `main` branch API: require('nvim-treesitter').install(...)
    -- if type(ts.install) == 'function' then
    --   ts.install(ensure_installed)
    --

    --   -- Enable treesitter highlighting + indentation on supported filetypes.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
          return
        end

        local max_filesize = 3 * 1024 * 1024 -- 3 MB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return
        end

        if not vim.treesitter.language.add(lang) then
          return
        end

        pcall(vim.treesitter.start, buf, lang)
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        vim.treesitter.start()
      end,
    })

    --   -- Enable treesitter highlighting + indentation on supported filetypes.
    --   vim.api.nvim_create_autocmd('FileType', {
    --     callback = function(args)
    --       local buf = args.buf
    --       local ft = vim.bo[buf].filetype
    --       local lang = vim.treesitter.language.get_lang(ft)
    --       if not lang then
    --         return
    --       end
    --
    --       local max_filesize = 3 * 1024 * 1024 -- 3 MB
    --       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --       if ok and stats and stats.size > max_filesize then
    --         return
    --       end
    --
    --       if not vim.treesitter.language.add(lang) then
    --         return
    --       end
    --
    --       pcall(vim.treesitter.start, buf, lang)
    --       vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    --     end,
    --   })
    --   return
    -- end

    -- Fallback: old `master` branch API (require('nvim-treesitter.configs').setup)
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = ensure_installed,
    --   sync_install = false,
    --   auto_install = true,
    --   highlight = {
    --     enable = true,
    --     disable = function(_, buf)
    --       local max_filesize = 3 * 1024 * 1024 -- 3 MB
    --       local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --       if ok and stats and stats.size > max_filesize then
    --         return true
    --       end
    --     end,
    --     additional_vim_regex_highlighting = false,
    --   },
    -- })
  end,
}
