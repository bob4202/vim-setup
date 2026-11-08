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
			},
		})
		vim.cmd.colorscheme("rose-pine")
	end,
}
