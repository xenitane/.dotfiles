return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        -- local icons = require("nvim-nonicons")
        require("telescope").setup({
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--hidden",
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '-u',
                    "-g",
                    "!{**/.git/*,**/node_modules/*,**/vendor/*}"
                },
                -- prompt_prefix = "  " .. icons.get("telescope") .. "  ",
                -- selection_caret = " ❯ ",
                -- entry_prefix = "   ",
            }
        })
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', function()
            builtin.find_files({
                find_command = { "rg", "--hidden", "--files", '-g', "!{**/.git,**/node_modules,**/vendor}", }
            })
        end, {})

        vim.keymap.set('n', '<leader>pG', builtin.git_files, {})

        vim.keymap.set('n', '<leader>po', builtin.oldfiles, {})

        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)

        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({
                search = vim.fn.input("Grep > "),
            })
        end)

        vim.keymap.set('n', '<leader>pg', function()
            builtin.live_grep({ glob_pattern = { "*", "!**/.git/", "!**/node_modules" } })
        end, {})
        vim.keymap.set('n', '<leader>pht', builtin.help_tags, {})
    end,
}
