return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			columns = { "icon" },
			view_options = {
				show_hidden = true,
			},
			keymaps = {
				["<C-h>"] = false,
				["<C-l>"] = false, -- leave it to tmux-navigator
				["<leader>e"] = "actions.refresh",
				["<M-h>"] = "actions.select_split",
			},
		})

		vim.keymap.set("n", "-", "<CMD>Oil<CR>", {
			desc = "Open parent directory",
		})
	end,
}
