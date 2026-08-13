return {
	"supermaven-inc/supermaven-nvim",
	config = function()
		require("supermaven-nvim").setup({
			keymap = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
			color = {
				suggestion_color = "#ffffff",
				cterm = 244,
			},
			log_level = "info",
			disable_inline_completion = false,
			condition = function()
				return false
			end,
		})
	end,
}
