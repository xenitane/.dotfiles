function SetColorScheme(color)
    color = color or "catppuccin"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
                styles = {
                    commnets = { italic = false },
                },
                diable_background = true,
                integrations = {
                    fidget = true,
                    harpoon = true,
                    mason = true,
                    noice = true,
                    notify = true,
                    lsp_trouble = true,
                },
            })
            SetColorScheme()
        end
    }
}
