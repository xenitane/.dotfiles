local plugins = {
    "folke/lazy.nvim",
    { "catppuccin/nvim",                  name = "catppuccin",                         priority = 1000 },
    "tpope/vim-commentary",
    "mattn/emmet-vim",
    "nvim-tree/nvim-tree.lua",
    "nvim-tree/nvim-web-devicons",
    "nvim-lualine/lualine.nvim",
    "nvim-treesitter/nvim-treesitter",
    "vim-test/vim-test",
    "lewis6991/gitsigns.nvim",
    "preservim/vimux",
    "christoomey/vim-tmux-navigator",
    "tpope/vim-fugitive",
    "tpope/vim-surround",
    "stevearc/oil.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    {
        "iamcco/markdown-preview.nvim",
        build = "cd app && npm install",
        ft = { "markdown" },
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    },
    { "vinnymeller/swagger-preview.nvim", build = "npm install -g swagger-ui-watcher", },
    { "nvim-telescope/telescope.nvim",    branch = '0.1.x',                            dependencies = { "nvim-lua/plenary.nvim" } },
}

local opts = {}

require("lazy").setup(plugins, opts)
