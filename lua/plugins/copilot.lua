return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	init = function()
		-- Hide Copilot ghost text while blink.cmp's menu is open, so LSP completions
		-- take priority; it comes back once the menu closes.
		vim.api.nvim_create_autocmd("User", {
			pattern = "BlinkCmpMenuOpen",
			callback = function()
				vim.b.copilot_suggestion_hidden = true
				local ok, suggestion = pcall(require, "copilot.suggestion")
				if ok then
					suggestion.dismiss()
				end
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "BlinkCmpMenuClose",
			callback = function()
				vim.b.copilot_suggestion_hidden = false
			end,
		})
	end,
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true, -- show ghost text as you type
			keymap = {
				accept = "<C-l>", -- <Tab> stays with blink.cmp
				accept_word = "<C-j>",
				accept_line = false,
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = false,
			gitcommit = true,
		},
	},
}
