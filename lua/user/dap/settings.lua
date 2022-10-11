local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

-- dap config

-- debug python
local mason_install_home = vim.fn.stdpath "data" .. "/mason"

dap.adapters.python = {
  type = 'executable';
  command = mason_install_home .. '/packages/debugpy/venv/bin/python3';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python3'
      end
    end;
  },
}

local util = require('jdtls.util')

dap.adapters.java = function(callback)
  util.execute_command({command = 'vscode.java.startDebugSession'}, function(err0, port)
    assert(not err0, vim.inspect(err0))
    -- print("puerto:", port)
    callback({
      type = 'server';
      host = '127.0.0.1';
      port = port;
    })
  end)
end

local projectName = os.getenv('PROJECT_NAME')
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    projectName = projectName or nil,
    name = "Java attach",
    hostName = "127.0.0.1",
    port = 5005
  },
}


