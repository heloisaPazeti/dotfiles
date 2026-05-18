return {
	{
		"zapling/mason-conform.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
		},
		config = function()
			require("mason-conform").setup({
				ensure_installed = {
					"stylua",
					"black",
					"shfmt",
					"gofumpt",
					"goimports",
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		lazy = false,
		config = function()
			local conform = require("conform")

			conform.setup({
				-- ────────────────────────────────────────
				-- Formatadores por linguagem
				-- ────────────────────────────────────────
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					sh = { "shfmt" },
					bash = { "shfmt" },
					go = { "goimports", "gofumpt" }, -- roda em sequência
				},

				-- ────────────────────────────────────────
				-- Configuração específica do clang-format
				-- ────────────────────────────────────────
				formatters = {
					clang_format = {
						prepend_args = {
							"--style=file",
							"--fallback-style=LLVM",
							"--assume-filename",
							vim.fn.expand("~/.config/nvim/clang-format"),
						},
					},
				},

				-- ────────────────────────────────────────
				-- Formatar ao salvar
				-- ────────────────────────────────────────
				format_on_save = {
					timeout_ms = 2000,
					lsp_fallback = true, -- usa o LSP se não houver formatador configurado
				},
			})

			-- ────────────────────────────────────────
			-- Keymap manual
			-- ────────────────────────────────────────
			vim.keymap.set({ "n", "v" }, "<leader>gf", function()
				conform.format({
					timeout_ms = 2000,
					lsp_fallback = true,
				})
			end, { desc = "Formatar arquivo/seleção" })
		end,
	},
}
