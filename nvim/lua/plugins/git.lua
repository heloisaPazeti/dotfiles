return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame = true,
		},
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff view" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git file history" },
			{ "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Fechar diffview" },
		},
	},
}
