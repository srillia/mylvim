local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

-- dap config

-- debug java
-- USE nvim-jdtls

-- debug python
dap.adapters.python = {
	type = "executable",
	command = require("user.utils").mason_home() .. "/packages/debugpy/venv/bin/python3",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = require("user.utils").python_path(),
	},
}

-- debug go
dap.adapters.go = {
  type = 'executable';
  command = 'node';
  args = {require("user.utils").mason_home() .. '/packages/go-debug-adapter/extension/dist/debugAdapter.js'};
}
dap.configurations.go = {
  {
    type = 'go';
    name = 'Debug';
    request = 'launch';
    showLog = false;
    program = "${file}";
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
  {
    type = 'go';
		name = "Debug Package",
    request = 'launch';
    showLog = false;
		program = "${fileDirname}",
    dlvToolPath = vim.fn.exepath('dlv')  -- Adjust to where delve is installed
  },
}

