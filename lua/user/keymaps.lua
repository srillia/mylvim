-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<S-Up>", ":resize -2<CR>", opts)
keymap("n", "<S-Down>", ":resize +2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fp", ":Telescope projects<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- DAP
keymap("n", "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<F7>", "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap("n", "<F11>", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap("n", "<F10>", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap("n", "<F12>", "<cmd>lua require'dap'.step_out()<cr>", opts)
keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
keymap("n", "<leader>de", "<Cmd>lua require'dapui'.eval()<CR>", opts)
keymap("v", "<leader>de", "<Cmd>lua require'dapui'.eval()<CR>", opts)
keymap("n", "<leader>dE", "<Cmd>lua require'user.dap.dap-config'.eval()<CR>", opts)
keymap("v", "<leader>dE", "<Cmd>lua require'user.dap.dap-config'.eval()<CR>", opts)


-- Buffer Lines
keymap("n", "<leader>bf", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", opts)
keymap("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", opts)
keymap("n", "<leader>be", "<cmd>BufferLinePickClose<cr>", opts)
keymap("n", "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", opts)
keymap("n", "<leader>bj", "<cmd>BufferLinePick<cr>", opts)
keymap("n", "<leader>bl", "<cmd>BufferLineCloseRight<cr>", opts)
keymap("n", "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>", opts)
keymap("n", "<leader>bL", "<cmd>BufferLineSortByExtension<cr>", opts)

-- rnvimr
keymap("t", "<leader>rr", "<cmd>RnvimrResize<cr>", opts)
keymap("n", "<leader>rg", "<cmd>RnvimrToggle<cr>", opts)
keymap("t", "<leader>rg", "<cmd>RnvimrToggle<cr>", opts)

-- hop
keymap("n", "<leader><leader>w", "<cmd>HopWord<cr>", opts)

-- nvim spectre
keymap("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", opts)

-- alpha
keymap("n", "<leader>;", "<cmd>Alpha<CR>", opts)

-- auto-save
keymap("n", "<leader>at", "<cmd>ASToggle<CR>", opts)

-- persistence
keymap("n", "<leader>pl", "<cmd>lua require('persistence').load()<cr>", opts)

-- persistence
keymap("n", "<leader>so", "<cmd>SymbolsOutline<cr>", opts)

-- glow
keymap("n", "<leader>gl", "<cmd>Glow<cr>", opts)
-- markdown-preview
keymap("n", "<leader>mp", "<cmd>MarkdownPreview<cr>", opts)

-- trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)

-- diffview
keymap("n", "<leader>dv", "<cmd>DiffviewOpen<cr>", opts)
keymap("n", "<leader>dc", "<cmd>DiffviewClose<cr>", opts)

-- todo-comments
keymap("n", "<leader>td", "<cmd>TodoTrouble<cr>", opts)
