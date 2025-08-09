-- local config = {
--   cmd = { vim.fn.expand '~/.local/share/nvim/mason/bin/jdtls' },
--   root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
--   settings = {
--     java = {
--       home = '/opt/homebrew/opt/openjdk/libexec/openjdk.jdk/Contents/Home',
--
--       runtimes = {
--         {
--           name = 'JavaSE-17',
--           path = '/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home/',
--         },
--       },
--     },
--
--     maven = {
--       downloadSources = true,
--     },
--     eclipse = {
--       downloadSources = true,
--     },
--   },
-- }
-- require('jdtls').start_or_attach(config)

-- JDTLS (Java LSP) configuration
local home = vim.env.HOME -- Get the home directory

local jdtls = require 'jdtls'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/jdtls-workspace/' .. project_name

local system_os = 'mac'

-- Needed for debugging
local bundles = {
  vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
}

-- Needed for running/debugging unit tests
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-test/*.jar', 1), '\n'))

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. home .. '/.local/share/nvim/mason/share/jdtls/lombok.jar',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    -- Eclipse jdtls location
    '-jar',
    home .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration',
    home .. '/.local/share/nvim/mason/packages/jdtls/config_' .. system_os,
    '-data',
    workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'pom.xml', 'build.gradle' },

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  settings = {
    java = {
      home = '/opt/homebrew/Cellar/openjdk/24.0.2/libexec/openjdk.jdk/Contents/Home',

      configuration = {
        updateBuildConfiguration = 'interactive',
        -- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
        runtimes = {
          {
            name = 'JavaSE-17',
            path = '/opt/homebrew/Cellar/openjdk@17/17.0.16/libexec/openjdk.jdk/Contents/Home',
          },
        },
      },
    },
  },
}

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)
