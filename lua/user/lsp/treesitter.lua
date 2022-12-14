local status_ok, treesitter = pcall(require, "nvim-treesitter")
if not status_ok then
	return
end

local status_config_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_config_ok then
	return
end

local disable = function(lang, buf)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	end
end

configs.setup({
	-- ensure_installed = { "lua", "markdown", "markdown_inline", "bash", "python" }, -- put the language you want in this array
	ensure_installed = "all",
	-- ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "javascript" }, -- List of parsers to ignore installing
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	highlight = {
		enable = true, -- false will disable the whole extension
		-- disable = { "javascript" }, -- list of language that will be disabled
		disable = disable,
		-- additional_vim_regex_highlighting = false,
	},
	autopairs = {
		enable = true,
		disable = disable,
	},
	illuminate = {
		disable = disable,
		enable = true,
		loaded = true,
		module_path = "illuminate.providers.treesitter",
	},
	incremental_selection = {
		disable = disable,
		enable = false,
		keymaps = {
			init_selection = "gnn",
			node_decremental = "grm",
			node_incremental = "grn",
			scope_incremental = "grc",
		},
		module_path = "nvim-treesitter.incremental_selection",
	},
	indent = {
		enable = true,
		disable = disable,
	},
	context_commentstring = {
		enable = true,
		disable = disable,
		enable_autocmd = false,
	},
	rainbow = {
		enable = true,
		disable = disable,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	autotag = {
		enable = true,
		disable = disable,
	},
})

local function nvim_hl()
	-- -- temp highlighting fix
	local hl = function(group, opts)
		opts.default = true
		vim.api.nvim_set_hl(0, group, opts)
	end
	-- Misc {{{
	hl("@comment", { link = "Comment" })
	-- hl('@error', {link = 'Error'})
	hl("@none", { bg = "NONE", fg = "NONE" })
	hl("@preproc", { link = "PreProc" })
	hl("@define", { link = "Define" })
	hl("@operator", { link = "Operator" })
	-- }}}

	-- Punctuation {{{
	hl("@punctuation.delimiter", { link = "Delimiter" })
	hl("@punctuation.bracket", { link = "Delimiter" })
	hl("@punctuation.special", { link = "Delimiter" })
	-- }}}

	-- Literals {{{
	hl("@string", { link = "String" })
	hl("@string.regex", { link = "String" })
	hl("@string.escape", { link = "SpecialChar" })
	hl("@string.special", { link = "SpecialChar" })

	hl("@character", { link = "Character" })
	hl("@character.special", { link = "SpecialChar" })

	hl("@boolean", { link = "Boolean" })
	hl("@number", { link = "Number" })
	hl("@float", { link = "Float" })
	-- }}}

	-- Functions {{{
	hl("@function", { link = "Function" })
	hl("@function.call", { link = "Function" })
	hl("@function.builtin", { link = "Type" })
	hl("@function.macro", { link = "Macro" })

	hl("@method", { link = "Function" })
	hl("@method.call", { link = "Function" })

	hl("@constructor", { link = "Special" })
	hl("@parameter", { link = "Identifier" })
	-- }}}

	-- Keywords {{{
	hl("@keyword", { link = "Keyword" })
	hl("@keyword.function", { link = "Keyword" })
	hl("@keyword.operator", { link = "Keyword" })
	hl("@keyword.return", { link = "Keyword" })

	hl("@conditional", { link = "Conditional" })
	hl("@repeat", { link = "Repeat" })
	hl("@debug", { link = "Debug" })
	hl("@label", { link = "Label" })
	hl("@include", { link = "Include" })
	hl("@exception", { link = "Exception" })
	-- }}}

	-- Types {{{
	hl("@type", { link = "Type" })
	hl("@type.builtin", { link = "Type" })
	hl("@type.qualifier", { link = "Type" })
	hl("@type.definition", { link = "Typedef" })

	hl("@storageclass", { link = "StorageClass" })
	hl("@attribute", { link = "PreProc" })
	hl("@field", { link = "Identifier" })
	hl("@property", { link = "Identifier" })
	-- }}}

	-- Identifiers {{{
	hl("@variable", { link = "Normal" })
	hl("@variable.builtin", { link = "Special" })

	hl("@constant", { link = "Constant" })
	hl("@constant.builtin", { link = "Special" })
	hl("@constant.macro", { link = "Define" })

	hl("@namespace", { link = "Include" })
	hl("@symbol", { link = "Identifier" })
	-- }}}

	-- Text {{{
	hl("@text", { link = "Normal" })
	hl("@text.strong", { bold = true })
	hl("@text.emphasis", { italic = true })
	hl("@text.underline", { underline = true })
	hl("@text.strike", { strikethrough = true })
	hl("@text.title", { link = "Title" })
	hl("@text.literal", { link = "String" })
	hl("@text.uri", { link = "Underlined" })
	hl("@text.math", { link = "Special" })
	hl("@text.environment", { link = "Macro" })
	hl("@text.environment.name", { link = "Type" })
	hl("@text.reference", { link = "Constant" })

	hl("@text.todo", { link = "Todo" })
	hl("@text.note", { link = "SpecialComment" })
	hl("@text.warning", { link = "WarningMsg" })
	hl("@text.danger", { link = "ErrorMsg" })
	-- }}}

	-- Tags {{{
	hl("@tag", { link = "Tag" })
	hl("@tag.attribute", { link = "Identifier" })
	hl("@tag.delimiter", { link = "Delimiter" })
	-- }}}
end

nvim_hl()
