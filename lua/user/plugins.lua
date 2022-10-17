local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	git = {
		clone_timeout = 300, -- Timeout, in seconds, for git clones
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "lewis6991/impatient.nvim" })

	-- CMP
	use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })
	use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
	-- snippets
	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	-- LSP
	-- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/mason.nvim" })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" })
	use({ "ahmedkhalf/project.nvim" })
	use({
		"mfussenegger/nvim-jdtls",
		ft = "java",
	})
	use("b0o/schemastore.nvim")
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				floating_window = false,
			})
		end,
	})

	-- DAP
	use({ "mfussenegger/nvim-dap" })
	use({ "rcarriga/nvim-dap-ui" })

	-- UI
	use({ "lukas-reineke/indent-blankline.nvim" })
	use({ "akinsho/bufferline.nvim" })
	use({ "famiu/bufdelete.nvim" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "akinsho/toggleterm.nvim" })
	use({ "nvim-tree/nvim-web-devicons" })
	use({ "nvim-tree/nvim-tree.lua" })
	-- colorschemes
	use({ "folke/tokyonight.nvim" })
	use({ "lunarvim/darkplus.nvim" })
	-- Telescope
	use({ "nvim-telescope/telescope.nvim" })
	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", commit = "4cccb6f494eb255b32a290d37c35ca12584c74d0" })
	use({
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup()
		end,
	})
	-- notify
	use({ "rcarriga/nvim-notify" })
	use({
		"simrat39/symbols-outline.nvim",
		config = function()
			require("symbols-outline").setup()
		end,
	})
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup()
		end,
	})
	use("stevearc/dressing.nvim")
	use({
		"SmiteshP/nvim-navic",
		requires = "neovim/nvim-lspconfig",
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- EXT
	use({ "goolord/alpha-nvim" })
	use({ "numToStr/Comment.nvim" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring" })
	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	-- which-key
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	})
	use({
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	})
	use({
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require("hop").setup()
		end,
	})
	use({
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	})
	use({
		"sindrets/diffview.nvim",
		event = "BufRead",
	})
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	use({ "kevinhwang91/rnvimr" })
	use({
		"MunifTanjim/exrc.nvim",
		config = function()
			require("exrc").setup({
				files = {
					".nvimrc.lua",
					".nvimrc",
					".exrc.lua",
					".exrc",
				},
			})
		end,
	})
	--  Distraction-free coding
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup()
		end,
	})
	use({
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup()
		end,
	})
	use({ "kevinhwang91/nvim-bqf", ft = "qf" })
	use({
		"abecodes/tabout.nvim",
		wants = { "nvim-treesitter" }, -- or require if not used so far
		after = { "nvim-cmp" }, -- if a completion plugin is using tabs load it before
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
