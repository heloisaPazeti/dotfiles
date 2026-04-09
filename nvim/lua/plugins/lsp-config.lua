return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
					"clangd",
				},
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			-- ────────────────────────────────────────
			-- Diagnósticos
			-- ────────────────────────────────────────
			vim.diagnostic.config({
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅙 ",
						[vim.diagnostic.severity.WARN] = "󰀨 ",
						[vim.diagnostic.severity.HINT] = "󰠠 ",
						[vim.diagnostic.severity.INFO] = " ",
					},
				},
				underline = true,
				update_in_insert = false,
				float = {
					border = "rounded",
				},
			})

			-- ────────────────────────────────────────
			-- LSP configs
			-- ────────────────────────────────────────
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
					},
				},
			})
			vim.lsp.config("gopls", { capabilities = capabilities })
			vim.lsp.config("clangd", { capabilities = capabilities })
			vim.lsp.enable({ "lua_ls", "gopls", "clangd" })

			-- ────────────────────────────────────────
			-- Keymaps ao anexar o LSP
			-- ────────────────────────────────────────
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

					-- substitui [d / ]d depreciados
					vim.keymap.set("n", "[d", function()
						vim.diagnostic.jump({ count = -1, float = true })
					end, vim.tbl_extend("force", opts, { desc = "Diagnóstico anterior" }))

					vim.keymap.set("n", "]d", function()
						vim.diagnostic.jump({ count = 1, float = true })
					end, vim.tbl_extend("force", opts, { desc = "Próximo diagnóstico" }))
				end,
			})
		end,
	},
}
