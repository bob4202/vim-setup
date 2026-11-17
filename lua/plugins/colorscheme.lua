return {
	"rose-pine/neovim",
	name = "rose-pine",
	priority = 1000,
	config = function()
		require("rose-pine").setup({
			variant = "main",
			styles = {
				transparency = true,
				italic = false,
			},
			highlight_groups = {
				Comment = { italic = true },
				-- Current line: lighter neutral grey (no purple tint)
				CursorLine = { bg = "#34343a" },
				CursorLineNr = { fg = "gold", bold = true },
				-- Visual selection: muted teal, text keeps its colors
				Visual = { bg = "#2e5f6b", inherit = false },
			},
		})
		vim.cmd.colorscheme("rose-pine")
	end,
}
