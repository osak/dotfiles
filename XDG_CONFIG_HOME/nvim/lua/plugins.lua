local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer itself
  use 'wbthomason/packer.nvim'

  -- File tree viewer
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons'
    }
  }

  -- Diagnostic window
  use 'folke/trouble.nvim'

  -- Auto completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-buffer'

  -- Color scheme
  -- use 'folke/tokyonight.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Haskell
  use {
    'mrcjkb/haskell-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
    },
    branch = '1.x.x', -- recommended
  }

  -- TypeScript
  use {
    "pmizio/typescript-tools.nvim",
    requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
	    require("typescript-tools").setup {}
    end,
  }

  -- Rust
  use {
    "mrcjkb/rustaceanvim",
    tag = "4.0.3",
    ft = { "rust" },
  }

  use {
    "lvimuser/lsp-inlayhints.nvim"
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
