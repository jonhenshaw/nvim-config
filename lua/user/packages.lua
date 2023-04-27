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

-- Autocommand that reloads neovim whenever you save the packages.lua file
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost packages.lua source <afile> | PackerSync
    augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({ display = { open_fn = function() return require("packer.util").float({ border = "rounded" }) end } })

-- Install your plugins here
return packer.startup(function(use)

	-- Base
	use { "wbthomason/packer.nvim" } -- Have packer manage itself
	use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
	use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
	use { "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" }

	-- DAP
	use { "mfussenegger/nvim-dap" }
	use { "mfussenegger/nvim-dap-python" }
	use { "rcarriga/nvim-dap-ui" }
	use { "ldelossa/nvim-dap-projects" }

	-- LSP
	use { "neovim/nvim-lspconfig" }
	use { "williamboman/mason.nvim" }
	use { "williamboman/mason-lspconfig.nvim" }
	use { "jose-elias-alvarez/null-ls.nvim" }
	use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
	use { "lukas-reineke/indent-blankline.nvim" }
	use { "RRethy/vim-illuminate" }
	use { "folke/trouble.nvim" }

	-- Navigation
	use { "goolord/alpha-nvim" }
	use { "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" }, commit = "9c97e6449b0b0269bd44e1fd4857184dfa57bb4c" }
	use { "ahmedkhalf/project.nvim" }
	use { "akinsho/toggleterm.nvim" }
	use { "moll/vim-bbye" }

	-- Search
	use { "nvim-telescope/telescope.nvim", requires = {'nvim-lua/plenary.nvim'}}
	use { "nvim-telescope/telescope-file-browser.nvim", requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }}

	-- Colorschemes
    use { "folke/tokyonight.nvim" }
    use { "lunarvim/darkplus.nvim" }
    use { "EdenEast/nightfox.nvim"}

	-- Autocomplete Plugins
    use { "github/copilot.vim" } -- Github Copilot

	-- Orgmode
	use { "nvim-orgmode/orgmode" }

	-- Shortcuts
	use {"folke/which-key.nvim" } -- Whichkey allows for leaderkey shortcuts

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end

end)