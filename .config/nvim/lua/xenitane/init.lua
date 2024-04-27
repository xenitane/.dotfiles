require("xenitane.options")
require("xenitane.remap")
require("xenitane.lazy-conf")

local augrp = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd

local XenitaneGroup = augrp("Xenitane", {})
local YankGroup = augrp("HighlightYank", {})

function R(name)
    require("plenary.reload").reload_module(name)
end

aucmd("TextYankPost", {
    group = YankGroup,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})

aucmd("BufWritePre", {
    pattern = "*.templ",
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local cmd = "templ fmt " .. vim.fn.shellescape(filename)

        vim.fn.jobstart(cmd, {
            on_exit = function()
                -- Reload the buffer only if it's still the current buffer
                if vim.api.nvim_get_current_buf() == bufnr then
                    vim.cmd("e!")
                end
            end,
        })
    end,
})

aucmd("BufWritePre", {
    group = XenitaneGroup,
    pattern = "*",
    callback = function()
        vim.cmd("Format")
    end,
})

aucmd("BufWritePost", {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
