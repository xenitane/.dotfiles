return {
    "laytan/cloak.nvim",
    config = function()
        require("cloak").setup({
            enabled = true,
            cloak_character = "#",
            cloak_telescope = true,
            highlight_group = "Comment",
            patterns = {
                {
                    file_pattern = { ".env*", "wrangler.toml", ".dev.vars" },
                    cloak_pattern = "=.+",
                },
            },
        })
    end,
}
