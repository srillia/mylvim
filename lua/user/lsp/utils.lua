--[[ ~/.config/nvim/lua/config/lsp/custom.lua ]]

local M = {}

---@param server_name string
---@param settings_patcher fun(settings: table): table
M.patch_lsp_settings = function(server_name, settings_patcher)
	local function patch_settings(client)
		client.config.settings = settings_patcher(client.config.settings)
		client.notify("workspace/didChangeConfiguration", {
			settings = client.config.settings,
		})
	end

	local clients = vim.lsp.get_active_clients({ name = server_name })
	if #clients > 0 then
		patch_settings(clients[1])
		return
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if client.name == server_name then
				patch_settings(client)
				return true
			end
		end,
	})
end

M.python_path = function()
	-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
	-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
	-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
	local cwd = vim.fn.getcwd()
	if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		return cwd .. "/venv/bin/python"
	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	else
		return "/usr/bin/python3"
	end
end

M.mason_home = function()
	return  os.getenv("HOME").. "/.local/share/nvim/mason"
end

return M
