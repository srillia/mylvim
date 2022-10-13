local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = "", modified = "", removed = "" }, -- changes diff symbols
	cond = hide_in_width,
}

local filetype = {
	"filetype",
	icons_enabled = true,
}

local location = {
	"location",
	padding = 0,
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local lsp = function()
	local buf_clients = vim.lsp.buf_get_clients()
	if next(buf_clients) ~= nil then
		for _, client in pairs(buf_clients) do
			if client.name ~= "null-ls" then
				return client.name
			end
		end
	end
  return ""
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { diagnostics },
		lualine_x = { diff, spaces, "encoding", lsp, filetype },
		lualine_y = { location },
		lualine_z = { "progress" },
	},
})
