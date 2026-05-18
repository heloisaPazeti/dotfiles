return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		--require('transparent').clear_prefix('lualine')
		require("lualine").setup({
			options = {
				theme = "horizon",
				section_separators = { left = "", right = "" },
				component_separators = { left = "", right = "" },
				icons_enabled = true,
				disabled_filetypes = {},
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = { "filename" },
				lualine_x = { "diagnostics", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			extensions = {},
		})
		local transparent = require("transparent")
		local prefixes = { "lualine_b", "lualine_c", "lualine_x", "lualine_y" }
		local function apply_prefixes()
			for _, p in ipairs(prefixes) do
				transparent.clear_prefix(p)
			end
		end
		apply_prefixes()
		vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_prefixes })
	end,
}
