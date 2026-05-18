return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local parsers = {
			"markdown",
			"markdown_inline",
			"lua",
			"bash",
			"fish",
			"python",
			"go",
			"json",
			"yaml",
			"toml",
			"vim",
			"vimdoc",
			"query",
			"c",
			"cpp",
		}

		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = parsers,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
