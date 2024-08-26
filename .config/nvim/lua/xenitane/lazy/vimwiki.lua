return {
    "vimwiki/vimwiki",
    config = function()
        vim.cmd [[let g:vimwiki_table_mappings = 0]]
        vim.cmd [[let g:vimwiki_listsyms = "✗○◐●✓"]]
        vim.cmd [[
            let wiki_1 = {}
            let wiki_1.path = "~/vim_wiki/personal"
            let wiki_2 = {}
            let wiki_2.path = "~/vim_wiki/coding"
            let wiki_2.nested_syntaxes = {"python":"python", "c++":"cpp", "c":"c", "go":"go", "rust":"rust", "zig":"zig", "javascript":"javascript"}
            let wiki_3 = {}
            let wiki_3.path = "~/vim_wiki/misc"
            let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]
        ]]
    end
}
