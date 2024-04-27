return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        local Xenitane_Fugitive = vim.api.nvim_create_augroup("Xenitane_Fugitive", {})

        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = Xenitane_Fugitive,
            pattern = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = { buffer = bufnr, remap = false }
                vim.keymap.set("n", "<leader>gp", function()
                    vim.cmd.Git("push")
                end, opts)

                vim.keymap.set("n", "<leader>gF", function()
                    vim.cmd.Git({ "fetch", "--all" })
                end, opts)

                vim.keymap.set("n", "<leader>gP", ":Git push -u origin", opts)
            end,
        })

        vim.keymap.set("n", "gf", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end,
}
