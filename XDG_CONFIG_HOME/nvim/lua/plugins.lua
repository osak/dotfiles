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

  -- Auto completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'

  -- Color scheme
  use 'folke/tokyonight.nvim'

  -- Haskell
  use {
    'mrcjkb/haskell-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
    },
    branch = '1.x.x', -- recommended
  }
end)
