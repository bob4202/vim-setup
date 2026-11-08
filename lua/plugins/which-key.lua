return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter",
	---@module 'which-key'
	---@type wk.Opts
	---@diagnostic disable-next-line: missing-fields
	opts = {
		delay = 0,
		icons = { mappings = vim.g.have_nerd_font },

		spec = {
			{ "<leader>s", group = "[S]earch", mode = { "n", "v" } },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>o", group = "[O]rganize" },
			{ "<leader>g", group = "[G]it Hunk", mode = { "n", "v" } },
			{ "gr", group = "LSP Actions", mode = { "n" } },
		},
	},
}
