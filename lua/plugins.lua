return require('packer').startup({
    function()
        -- This file can be loaded by calling `lua require('plugins')` from your init.vim
        -- Packer can manage itself
        use 'wbthomason/packer.nvim'
        -- Simple plugins can be specified as strings
        -- use '9mm/vim-closer'
        -- Lazy loading:
        -- Load on specific commands
        -- use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
        -- Load on an autocommand event
        -- use {'andymass/vim-matchup', event = 'VimEnter'}

        -- https://github.com/wbthomason/packer.nvim#quickstart
        use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'}}
        use {'neovim/nvim-lspconfig'}
        use {'williamboman/nvim-lsp-installer'}
        use {'glepnir/dashboard-nvim'}
        use {'nvim-lua/plenary.nvim'} -- fzf helper
        use {'nvim-telescope/telescope.nvim'} -- fzf
        use {'nvim-treesitter/nvim-treesitter'}
        use {'ryanoasis/vim-devicons'}
        use {'preservim/nerdtree'} -- filetree explorer
        use {'David-Kunz/jester'} -- React Jest testing
        use {'sbdchd/neoformat'} -- prettier
        use {'tpope/vim-fugitive'} -- git
        use {'terrortylor/nvim-comment'} -- commenting
        use {'folke/zen-mode.nvim'}
        use {'folke/tokyonight.nvim'} -- colorscheme
        use {'wakatime/vim-wakatime'} -- fitbit
        use {'windwp/nvim-autopairs'}
        -- golang
        use {'ray-x/go.nvim'}
        use {'fatih/vim-go'}
        -- helper
        use {'folke/which-key.nvim'}
        -- nvim cmp
        use {'hrsh7th/cmp-nvim-lsp'}
        use {'hrsh7th/cmp-buffer'}
        use {'hrsh7th/cmp-path'}
        use {'hrsh7th/cmp-cmdline'}
        use {'hrsh7th/nvim-cmp'}
        -- snippet helpers
        use {'L3MON4D3/LuaSnip'}
        use {'saadparwaiz1/cmp_luasnip'}

        -- use {'neoclide/coc.nvim', {'branch': 'release'}
        --
        
        use {"jose-elias-alvarez/nvim-lsp-ts-utils"}
        use {"jose-elias-alvarez/null-ls.nvim"}
    end,
    config = {display = {open_fn = require('packer.util').float}}
})
