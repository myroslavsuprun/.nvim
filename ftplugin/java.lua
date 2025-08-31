-- JDTLS (Java LSP) configuration
local home = vim.env.HOME -- Get the home directory

local jdtls = require 'jdtls'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/jdtls-workspace/' .. project_name

-- Needed for debugging
local bundles = {
  vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
}

local java_test_bundles = vim.split(vim.fn.glob(home .. '/.local/share/nvim/mason/share/java-test/*.jar', true), '\n')
local excluded = {
  'com.microsoft.java.test.runner-jar-with-dependencies.jar',
  'jacocoagent.jar',
}
for _, java_test_jar in ipairs(java_test_bundles) do
  local fname = vim.fn.fnamemodify(java_test_jar, ':t')
  if not vim.tbl_contains(excluded, fname) then
    table.insert(bundles, java_test_jar)
  end
end

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
    home .. '/.local/share/nvim/mason/packages/jdtls/config_mac',
    '-data',
    workspace_dir,
  },

  root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'pom.xml', 'build.gradle', 'gradlew' },

  settings = {
    java = {
      home = '/opt/homebrew/Cellar/openjdk/24.0.2/libexec/openjdk.jdk/Contents/Home',

      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = 'JavaSE-17',
            path = '/opt/homebrew/Cellar/openjdk@17/17.0.16/libexec/openjdk.jdk/Contents/Home',
          },
          {
            name = 'JavaSE-21',
            path = '/opt/homebrew/Cellar/openjdk@21/21.0.8/libexec/openjdk.jdk/Contents/Home',
          },
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
  },
}

config['on_attach'] = function(client, bufnr)
  jdtls.setup_dap { hotcodereplace = 'auto' }
  require('jdtls.dap').setup_dap_main_class_configs()
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)

local map = function(keys, func, desc, mode)
  mode = mode or 'n'
  vim.keymap.set(mode, keys, func, { desc = desc })
end

map('<leader>jc', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').test_class()
  end
end, 'Test [J]ava [C]lass')

map('<leader>jm', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').test_nearest_method()
  end
end, 'Test [J]ava [M]ethod')

map('<leader>ji', function()
  if vim.bo.filetype == 'java' then
    require('jdtls').organize_imports()
  end
end, 'Organize [J]ava [I]mports')
