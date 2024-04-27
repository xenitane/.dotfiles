return {
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "catppuccin",
            },
            sections = {
                lualine_c = {
                    {
                        "filename",
                        path = 1,
                    },
                },
            },
        })
    end,
}
