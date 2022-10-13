local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end
M = {}

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7"),
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "right",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  }
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })


-- M.eval = function()
--   local expr = ""
-- 	if vim.fn.mode() == "v" then
-- 		local start = vim.fn.getpos("v")
-- 		local finish = vim.fn.getpos(".")
-- 		local lines = require("dapui.util").get_selection(start, finish)
-- 		expr = table.concat(lines, "\n")
-- 	elseif vim.fn.mode() == "n" then
-- 	  vim.ui.input({ prompt = "> " }, function(express)
--       expr = express or vim.fn.expand("<cexpr>")
--     end)
-- 	end
--   dapui.eval("call " .. expr)
-- end

-- set tap open dap-ui

local debug_win = nil
local debug_tab = nil
local debug_tabnr = nil

local function open_in_tab()
	if debug_win and vim.api.nvim_win_is_valid(debug_win) then
		vim.api.nvim_set_current_win(debug_win)
		return
	end

	vim.cmd("tabedit %")
	debug_win = vim.fn.win_getid()
	debug_tab = vim.api.nvim_win_get_tabpage(debug_win)
	debug_tabnr = vim.api.nvim_tabpage_get_number(debug_tab)

	dapui.open()
end

local function close_tab()
	dapui.close()

	if debug_tab and vim.api.nvim_tabpage_is_valid(debug_tab) then
		vim.api.nvim_exec("tabclose " .. debug_tabnr, false)
	end

	debug_win = nil
	debug_tab = nil
	debug_tabnr = nil
end

-- Attach DAP UI to DAP events
dap.listeners.after.event_initialized["dapui_config"] = function()
	open_in_tab()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	close_tab()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	close_tab()
end

return M
