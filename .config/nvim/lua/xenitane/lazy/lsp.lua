return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "mattn/emmet-vim",
        "onsails/lspkind.nvim",
        "mhartington/formatter.nvim",
        "mfussenegger/nvim-lint",
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
    },

    config = function()
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        vim.filetype.add({ extension = { templ = "templ" } })

        local lspconfig = require("lspconfig")

        local on_attach = function(e)
            vim.bo[e.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
            local opts = { buffer = e.buf, noremap = true, silent = true }
            vim.keymap.set("n", "gd", function()
                vim.lsp.buf.definition()
            end, opts)
            vim.keymap.set("n", "gD", function()
                vim.lsp.buf.declaration()
            end, opts)
            vim.keymap.set("n", "gi", function()
                vim.lsp.buf.implementation()
            end, opts)
            vim.keymap.set("n", "go", function()
                vim.lsp.buf.type_definition()
            end, opts)
            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover()
            end, opts)
            vim.keymap.set("n", "<leader>vws", function()
                vim.lsp.buf.workspace_symbol()
            end, opts)
            vim.keymap.set("n", "<leader>vd", function()
                vim.diagnostic.open_float()
            end, opts)
            vim.keymap.set({ "n", "v" }, "<leader>vca", function()
                vim.lsp.buf.code_action()
            end, opts)
            vim.keymap.set("n", "<leader>vrr", function()
                vim.lsp.buf.references()
            end, opts)
            vim.keymap.set("n", "<leader>vrn", function()
                vim.lsp.buf.rename()
            end, opts)
            vim.keymap.set("i", "<C-h>", function()
                vim.lsp.buf.signature_help()
            end, opts)
            vim.keymap.set("n", "[d", function()
                vim.diagnostic.goto_prev()
            end, opts)
            vim.keymap.set("n", "d]", function()
                vim.diagnostic.goto_next()
            end, opts)
            vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
            vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
            vim.keymap.set("n", "<leader>wl", function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "tsserver",
                "eslint",
                "gopls",
                "templ",
                "htmx",
                "tailwindcss",
                "html",
                "zls",
            },
            automatic_install = true,
            handlers = {
                function(server_name) -- default handler (optional)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach,
                    })
                end,

                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                },
                                workspace = {
                                    library = {
                                        [vim.fn.expand("$VIRTRUNTIME/lua")] = true,
                                        [vim.fn.stdpath("config") .. "/lua"] = true,
                                    },
                                },
                            },
                        },
                    })
                end,
            },
        })

        require("lspconfig.configs").templ = {
            default_config = {
                cmd = { "templ", "lsp", "-http=localhost:7474", "-log=~/templ.log" },
                filetype = { "templ" },
                root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
                settings = {},
            },
        }

        vim.api.nvim_create_autocmd("LspAttach", { callback = on_attach })

        lspconfig.tailwindcss.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
                "html",
                "javascript",
                "typescript",
                "javascriptreact",
                "typescriptreact",
                "css",
                "vue",
                "svelte",
                "rescript",
                "templ",
                "astro",
                "react",
            },
            init_options = { userLanguages = { templ = "html" } },
        })

        lspconfig.unocss.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = {
                "html",
                "templ",
                "javascript",
                "typescript",
                "react",
                "astro",
                "javascriptreact",
                "typescriptreact",
                "vue",
                "svelte",
                "rescript",
            },
            init_options = { userLanguages = { templ = "html" } },
            root_dir = require("lspconfig.util").root_pattern(
                "unocss.config.js",
                "unocss.config.ts",
                "uno.config.js",
                "uno.config.ts"
            ),
        })

        lspconfig.html.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "html", "templ" },
        })

        lspconfig.htmx.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            filetypes = { "html", "templ" },
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-o>"] = cmp.mapping.complete(),
                ["<Tab>"] = nil,
                ["<S-Tab>"] = nil,
                ["<C-P>"] = cmp.mapping.scroll_docs(-4),
                ["<C-N>"] = cmp.mapping.scroll_docs(4),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer" },
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "abbr", "kind", "menu" },
                format = require("lspkind").cmp_format({
                    mode = "symbol",
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })

        cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
            matching = { disallow_symbol_nonprefix_matching = false },
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
            virtual_text = true,
            sign = {
                text = {
                    [vim.diagnostic.severity.E] = "",
                    [vim.diagnostic.severity.W] = "",
                    [vim.diagnostic.severity.N] = "",
                    [vim.diagnostic.severity.I] = "",
                },
            },
        })

        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = { require("formatter.filetypes.lua").stylua },
                html = { require("formatter.filetypes.html").prettier },
                javascript = { require("formatter.filetypes.javascript").prettier },
                javascriptreact = { require("formatter.filetypes.javascriptreact").prettier },
                typescript = { require("formatter.filetypes.typescript").prettier },
                typescriptreact = { require("formatter.filetypes.typescriptreact").prettier },
                css = { require("formatter.filetypes.css").prettier },
                yaml = { require("formatter.filetypes.yaml").prettier },
                json = { require("formatter.filetypes.json").prettier },
                markdown = { require("formatter.filetypes.markdown").prettier },
                rust = { require("formatter.filetypes.rust").rustfmt },
                c = { require("formatter.filetypes.c").clangformat },
                cpp = { require("formatter.filetypes.c").clangformat },
                zig = { require("formatter.filetypes.zig").zigfmt },
                go = require("formatter.filetypes.go"),
                haskell = require("formatter.filetypes.haskell"),
                latex = require("formatter.filetypes.latex"),
                ocaml = require("formatter.filetypes.ocaml"),
                python = require("formatter.filetypes.python"),
                sh = require("formatter.filetypes.sh"),
                zsh = require("formatter.filetypes.zsh"),
                svelte = { require("formatter.filetypes.svelte").prettier },
                vue = { require("formatter.filetypes.vue").prettier },
                tex = require("formatter.filetypes.latex"),
                toml = require("formatter.filetypes.toml"),
                ["*"] = {
                    require("formatter.filetypes.any").remove_trailing_whitespace,
                    function()
                        local defined_types = require("formatter.config").values.filetype
                        if defined_types[vim.bo.filetype] ~= nil then
                            vim.lsp.buf.format({ async = true })
                        end
                    end,
                },
            },
        })
    end,
}
