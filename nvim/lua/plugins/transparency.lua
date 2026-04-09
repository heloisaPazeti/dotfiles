return {
	"xiyaowong/transparent.nvim",
	lazy = false, -- carrega no start
	opts = {
		extra_groups = {
			-- núcleo/janela
			-- "NormalFloat",
			-- "FloatBorder",
			-- "FloatTitle",
			"SignColumn",
			"LineNr",
			"FoldColumn",
			"EndOfBuffer",
			"WinSeparator",
			"VertSplit",
			-- menus
			"Pmenu",
			"PmenuSbar",
			"PmenuThumb",

			-- telescope
			"TelescopeNormal",
			"TelescopeBorder",
			"TelescopePromptNormal",
			"TelescopePromptBorder",
			"TelescopeResultsNormal",
			"TelescopeResultsBorder",
			"TelescopePreviewNormal",
			"TelescopePreviewBorder",

			-- neo-tree
			"NeoTreeNormal",
			"NeoTreeNormalNC",
			"NeoTreeEndOfBuffer",
			"NeoTreeWinSeparator",
			"NeoTreeFloatNormal",
			"NeoTreeFloatBorder",

			"MsgArea", -- área de mensagens/comandos
			"CmdLine", -- linha de comando
			"CmdlineNormal", -- comando normal
			"ModeMsg",
		},
		exclude_groups = { "CursorLine", "CursorLineNr", "PmenuSel", "Search", "IncSearch" },
	},
	config = function(_, opts)
		require("transparent").setup(opts)
		local function apply()
			vim.cmd("TransparentEnable")
		end

		-- aplica no startup e após trocar de tema
		vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, { callback = apply })
	end,
}
