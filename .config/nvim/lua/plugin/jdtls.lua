local M = {}

local function get_pkg_path(pkg)
  return vim.fn.stdpath('data') .. '/mason/packages/' .. pkg
end

function M:setup()
  vim.opt.expandtab = false
  vim.opt.shiftwidth = 4
  vim.opt.tabstop = 4
  vim.opt.softtabstop = 4
  vim.cmd.set('list')
  vim.api.nvim_command('filetype indent off')
  vim.api.smartindent = false

  -- attach lsp keymaps for nvim-jdtls
  local opts = { noremap = true, silent = true }
  local keymap = vim.keymap.set
  keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  keymap('n', 'gI', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

  -- disable semantic token highlights as most colorschemes drown out anything useful
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end,
  })

  local SYSTEM
  if vim.fn.has('mac') then
    SYSTEM = 'mac'
  else
    SYSTEM = 'linux'
  end

  local function get_jdtls()
    local jdtls_path = get_pkg_path('jdtls')
    -- local lombok_path = get_pkg_path('lombok-nightly')

    local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

    -- Obtain the path to configuration files for your specific operating system
    local config = jdtls_path .. '/config_' .. SYSTEM
    -- Obtain the path to the Lomboc jar
    local lombok_config = jdtls_path .. '/lombok.jar'

    return launcher, config, lombok_config
  end

  local function get_bundles()
    local java_debug = get_pkg_path('java-debug-adapter')

    local bundles = {
      vim.fn.glob(java_debug .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true),
    }
    local java_test = get_pkg_path('java-test')
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test .. '/extension/server/*.jar', true), '\n'))

    return bundles
  end

  local function get_workspace()
    -- Get the home directory of your operating system
    local home = os.getenv('HOME')
    -- Declare a directory where you would like to store project information
    local workspace_path = home .. 'repo'
    -- Determine the project name
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    -- Create the workspace directory by concatenating the designated workspace path and the project name
    local workspace_dir = workspace_path .. project_name
    return workspace_dir
  end

  -- Get access to the jdtls plugin and all of its functionality
  local jdtls = require('jdtls')

  -- Get the paths to the jdtls jar, operating specific configuration directory, and lombok jar
  local launcher, os_config, lombok = get_jdtls()

  -- Get the path you specified to hold project information
  local workspace_dir = get_workspace()

  -- Get the bundles list with the jars to the debug adapter, and testing adapters
  local bundles = get_bundles()

  -- Determine the root directory of the project by looking for these specific markers
  local root_dir = vim.fs.root(0, { 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' })

  -- Tell our JDTLS language features it is capable of
  local capabilities = {
    workspace = {
      configuration = true,
    },
    textDocument = {
      completion = {
        snippetSupport = false,
      },
    },
  }

  -- Get the default extended client capablities of the JDTLS language server
  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  -- Modify one property called resolveAdditionalTextEditsSupport and set it to true
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  -- Set the command that starts the JDTLS language server jar
  local cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:' .. lombok,
    '-jar',
    launcher,
    '-configuration',
    os_config,
    '-data',
    workspace_dir,
  }

  -- Configure settings in the JDTLS server
  local settings = {
    java = {
      -- Enable code formatting
      format = {
        enabled = true,
        -- source = "absolute/path/to/formatter.xml"
        settings = {
          url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
        },
      },
      -- Enable downloading archives from eclipse automatically
      eclipse = {
        downloadSource = true,
      },
      -- Enable downloading archives from maven automatically
      maven = {
        downloadSources = true,
      },
      -- Enable method signature help
      signatureHelp = {
        enabled = true,
      },
      -- Use the fernflower decompiler when using the javap command to decompile byte code back to java code
      contentProvider = {
        preferred = 'fernflower',
      },
      -- Setup automatical package import oranization on file save
      saveActions = {
        organizeImports = true,
      },
      -- Customize completion options
      completion = {
        -- When using an unimported static method, how should the LSP rank possible places to import the static method from
        favoriteStaticMembers = {
          'org.junit.jupiter.api.Assertions.*',
          'org.mockito.Mockito.*',
        },
        -- Try not to suggest imports from these packages in the code action window
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
        -- Set the order in which the language server should organize imports
        -- "" is all others, "#" is static imports
        importOrder = {
          'com',
          'lombok',
          'org',
          'jakarta',
          'javax',
          'java',
          '',
          '#',
        },
      },
      sources = {
        -- How many classes from a specific package should be imported before automatic imports combine them all into a single import
        organizeImports = {
          starThreshold = 9999,
          staticThreshold = 9999,
        },
      },
      -- How should different pieces of code be generated?
      codeGeneration = {
        -- When generating toString use a json format
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        -- When generating hashCode and equals methods use the java 7 objects method
        hashCodeEquals = {
          useJava7Objects = true,
        },
        -- When generating code use code blocks
        useBlocks = true,
      },
      -- If changes to the project will require the developer to update the projects configuration advise the developer before accepting the change
      configuration = {
        runtimes = {
          -- will most likely have a different path on other systems
          {
            name = 'Java',
            path = os.getenv('JAVA_HOME'),
          },
        },
        updateBuildConfiguration = 'interactive',
      },
      -- enable code lens in the lsp
      referencesCodeLens = {
        enabled = true,
      },
      -- enable inlay hints for parameter names,
      inlayHints = {
        parameterNames = {
          enabled = 'all',
        },
      },
    },
  }

  -- Create a table called init_options to pass the bundles with debug and testing jar, along with the extended client capablies to the start or attach function of JDTLS
  local init_options = {
    bundles = bundles, -- NOTE(xylonx): dap seems have some problem
    extendedClientCapabilities = extendedClientCapabilities,
  }

  -- Function that will be ran once the language server is attached
  local on_attach = function(_, bufnr)
    -- Let jdtls handle indentation instead of treesitter.
    local ok, ts_indent = pcall(require, 'nvim-treesitter.indent')
    if ok and ts_indent.detach then
      ts_indent.detach(bufnr) -- nvim-treesitter master branch API
    else
      vim.bo[bufnr].indentexpr = '' -- nvim-treesitter main branch: clear ts indentexpr
    end
    -- Enable jdtls commands to be used in Neovim
    vim.lsp.codelens.refresh()

    -- Setup a function that automatically runs every time a java file is saved to refresh the code lens
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = { '*.java' },
      callback = function()
        local _, _ = pcall(vim.lsp.codelens.refresh)
      end,
    })
  end

  -- Create the configuration table for the start or attach function
  local config = {
    name = 'jdtls',
    cmd = cmd,
    root_dir = root_dir,
    settings = settings,
    capabilities = capabilities,
    init_options = init_options,
    on_attach = on_attach,
  }

  local wk = require('which-key')

  wk.add({
    { '<leader>j', group = 'Java', nowait = true, remap = false },
    {
      '<leader>jb',
      ":TermExec cmd='mvn clean install -U -X -DskipTests'<CR>",
      desc = 'Clean Install - no tests',
      nowait = true,
      remap = false,
    },
    {
      '<leader>ji',
      ":TermExec cmd='mvn clean install -U -X'<CR>",
      desc = 'Clean Install',
      nowait = true,
      remap = false,
    },
    {
      '<leader>jo',
      ":lua require('jdtls').organize_imports()<CR>",
      desc = 'Organize Imports',
    },
    { '<leader>jt', group = 'Test', nowait = true, remap = false },
    { '<leader>jtc', ":lua require('jdtls').test_class()<CR>", desc = 'Class' },
    { '<leader>jtm', ":lua require('jdtls').test_nearest_method()<CR>", desc = 'Nearest Method' },
    { '<leader>jd', group = 'Debug', nowait = true, remap = false },
    { '<leader>jr', group = 'Run', nowait = true, remap = false },
    {
      '<leader>jrd',
      ":TermExec cmd='mvn spring-boot:run -Pdev'",
      desc = 'Run Dev Profile',
      nowait = true,
      remap = false,
    },
    { '<leader>jg', group = 'Generate', nowait = true, remap = false },
  })

  -- require('nvim-tree').setup({
  --   view = {
  --     width = 50,
  --     centralize_selection = true,
  --   },
  --   update_cwd = true,
  --   update_focused_file = {
  --     update_root = true,
  --   },
  -- })
  --
  require('jdtls').start_or_attach(config)
end

return M
--
--
-- local java_cmds = vim.api.nvim_create_augroup('java_cmds', { clear = true })
-- local cache_vars = {}
--
-- -- Here you can add files/folders that you use at
-- -- the root of your project. `nvim-jdtls` will use
-- -- these to find the path to your project source code.
-- local root_files = {
--   '.git',
--
--   --- here are more examples files that may or
--   --- may not work as root files, according to some guy on the internet
--   'mvnw',
--   'gradlew',
--   'pom.xml',
--   'build.gradle',
-- }
--
-- local features = {
--   -- change this to `true` to enable codelens
--   codelens = false,
--
--   -- change this to `true` if you have `nvim-dap`,
--   -- `java-test` and `java-debug-adapter` installed
--   debugger = false,
-- }
--
-- local function get_jdtls_paths()
--   if cache_vars.paths then
--     return cache_vars.paths
--   end
--
--   local path = {}
--
--   path.data_dir = vim.fn.stdpath('cache') .. '/nvim-jdtls'
--
--   local jdtls_install = require('mason-registry').get_package('jdtls'):get_install_path()
--
--   path.java_agent = jdtls_install .. '/lombok.jar'
--   path.launcher_jar = vim.fn.glob(jdtls_install .. '/plugins/org.eclipse.equinox.launcher_*.jar')
--
--   if vim.fn.has('mac') == 1 then
--     path.platform_config = jdtls_install .. '/config_mac'
--   elseif vim.fn.has('unix') == 1 then
--     path.platform_config = jdtls_install .. '/config_linux'
--   elseif vim.fn.has('win32') == 1 then
--     path.platform_config = jdtls_install .. '/config_win'
--   end
--
--   path.bundles = {}
--
--   ---
--   -- Include java-test bundle if present
--   ---
--   local java_test_path = require('mason-registry').get_package('java-test'):get_install_path()
--
--   local java_test_bundle = vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar'), '\n')
--
--   if java_test_bundle[1] ~= '' then
--     vim.list_extend(path.bundles, java_test_bundle)
--   end
--
--   ---
--   -- Include java-debug-adapter bundle if present
--   ---
--   local java_debug_path = require('mason-registry').get_package('java-debug-adapter'):get_install_path()
--
--   local java_debug_bundle =
--     vim.split(vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'), '\n')
--
--   if java_debug_bundle[1] ~= '' then
--     vim.list_extend(path.bundles, java_debug_bundle)
--   end
--
--   ---
--   -- Useful if you're starting jdtls with a Java version that's
--   -- different from the one the project uses.
--   ---
--   path.runtimes = {
--     -- Note: the field `name` must be a valid `ExecutionEnvironment`,
--     -- you can find the list here:
--     -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--     --
--     -- This example assume you are using sdkman: https://sdkman.io
--     {
--       name = 'openjdk-21.0.2',
--       path = vim.fn.expand('~/.local/share/mise/installs/java/openjdk-21.0.2/'),
--     },
--     -- {
--     --   name = 'JavaSE-17',
--     --   path = vim.fn.expand('~/.sdkman/candidates/java/17.0.6-tem'),
--     -- },
--     -- {
--     --   name = 'JavaSE-18',
--     --   path = vim.fn.expand('~/.sdkman/candidates/java/18.0.2-amzn'),
--     -- },
--   }
--
--   cache_vars.paths = path
--
--   return path
-- end
--
-- local function enable_codelens(bufnr)
--   pcall(vim.lsp.codelens.refresh)
--
--   vim.api.nvim_create_autocmd('BufWritePost', {
--     buffer = bufnr,
--     group = java_cmds,
--     desc = 'refresh codelens',
--     callback = function()
--       pcall(vim.lsp.codelens.refresh)
--     end,
--   })
-- end
--
-- local function enable_debugger(bufnr)
--   require('jdtls').setup_dap({ hotcodereplace = 'auto' })
--   require('jdtls.dap').setup_dap_main_class_configs()
--
--   local opts = { buffer = bufnr }
--   vim.keymap.set('n', '<leader>df', "<cmd>lua require('jdtls').test_class()<cr>", opts)
--   vim.keymap.set('n', '<leader>dn', "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)
-- end
--
-- local function jdtls_on_attach(client, bufnr)
--   if features.debugger then
--     enable_debugger(bufnr)
--   end
--
--   if features.codelens then
--     enable_codelens(bufnr)
--   end
--
--   -- The following mappings are based on the suggested usage of nvim-jdtls
--   -- https://github.com/mfussenegger/nvim-jdtls#usage
--
--   local opts = { buffer = bufnr }
--   vim.keymap.set('n', '<A-o>', "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
--   vim.keymap.set('n', 'crv', "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
--   vim.keymap.set('x', 'crv', "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
--   vim.keymap.set('n', 'crc', "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
--   vim.keymap.set('x', 'crc', "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
--   vim.keymap.set('x', 'crm', "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", opts)
-- end
--
-- local function jdtls_setup(event)
--   local jdtls = require('jdtls')
--
--   local path = get_jdtls_paths()
--   local data_dir = path.data_dir .. '/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
--
--   if cache_vars.capabilities == nil then
--     jdtls.extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
--
--     local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
--     cache_vars.capabilities = vim.tbl_deep_extend(
--       'force',
--       vim.lsp.protocol.make_client_capabilities(),
--       ok_cmp and cmp_lsp.default_capabilities() or {}
--     )
--   end
--
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   local cmd = {
--     -- 💀
--     'java',
--
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-javaagent:' .. path.java_agent,
--     '-Xms1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens',
--     'java.base/java.util=ALL-UNNAMED',
--     '--add-opens',
--     'java.base/java.lang=ALL-UNNAMED',
--
--     -- 💀
--     '-jar',
--     path.launcher_jar,
--
--     -- 💀
--     '-configuration',
--     path.platform_config,
--
--     -- 💀
--     '-data',
--     data_dir,
--   }
--
--   local lsp_settings = {
--     java = {
--       -- jdt = {
--       --   ls = {
--       --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
--       --   }
--       -- },
--       eclipse = {
--         downloadSources = true,
--       },
--       configuration = {
--         updateBuildConfiguration = 'interactive',
--         runtimes = path.runtimes,
--       },
--       maven = {
--         downloadSources = true,
--       },
--       implementationsCodeLens = {
--         enabled = true,
--       },
--       referencesCodeLens = {
--         enabled = true,
--       },
--       -- inlayHints = {
--       --   parameterNames = {
--       --     enabled = 'all' -- literals, all, none
--       --   }
--       -- },
--       format = {
--         enabled = true,
--         -- settings = {
--         --   profile = 'asdf'
--         -- },
--       },
--     },
--     signatureHelp = {
--       enabled = true,
--     },
--     completion = {
--       favoriteStaticMembers = {
--         'org.hamcrest.MatcherAssert.assertThat',
--         'org.hamcrest.Matchers.*',
--         'org.hamcrest.CoreMatchers.*',
--         'org.junit.jupiter.api.Assertions.*',
--         'java.util.Objects.requireNonNull',
--         'java.util.Objects.requireNonNullElse',
--         'org.mockito.Mockito.*',
--       },
--     },
--     contentProvider = {
--       preferred = 'fernflower',
--     },
--     extendedClientCapabilities = jdtls.extendedClientCapabilities,
--     sources = {
--       organizeImports = {
--         starThreshold = 9999,
--         staticStarThreshold = 9999,
--       },
--     },
--     codeGeneration = {
--       toString = {
--         template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
--       },
--       useBlocks = true,
--     },
--   }
--
--   -- This starts a new client & server,
--   -- or attaches to an existing client & server depending on the `root_dir`.
--   jdtls.start_or_attach({
--     cmd = cmd,
--     settings = lsp_settings,
--     on_attach = jdtls_on_attach,
--     capabilities = cache_vars.capabilities,
--     root_dir = jdtls.setup.find_root(root_files),
--     flags = {
--       allow_incremental_sync = true,
--     },
--     init_options = {
--       bundles = path.bundles,
--     },
--   })
-- end
--
-- vim.api.nvim_create_autocmd('FileType', {
--   group = java_cmds,
--   pattern = { 'java' },
--   desc = 'Setup jdtls',
--   callback = jdtls_setup,
-- })
