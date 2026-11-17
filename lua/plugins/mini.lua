return { -- Collection of various small independent plugins/modules
	"nvim-mini/mini.nvim",
	config = function()
		-- Better Around/Inside textobjects
		--  - va)  - [V]isually select [A]round [)]paren
		--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
		--  - ci'  - [C]hange [I]nside [']quote
		require("mini.ai").setup({ n_lines = 500 })

		-- Add/delete/replace surroundings (brackets, quotes, etc.)
		--  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
		--  - sd'   - [S]urround [D]elete [']quotes
		--  - sr)'  - [S]urround [R]eplace [)] [']
		require("mini.surround").setup()

		-- Split/join arguments and struct fields: put the cursor inside (), {} or []
		-- and press gS to toggle between one line and one item per line.
		-- Adds/removes the trailing comma Go requires on multi-line lists.
		local splitjoin = require("mini.splitjoin")
		splitjoin.setup({
			split = { hooks_post = { splitjoin.gen_hook.add_trailing_separator() } },
			join = { hooks_post = { splitjoin.gen_hook.del_trailing_separator() } },
		})

		-- Simple and easy statusline.
		local statusline = require("mini.statusline")
		statusline.setup({ use_icons = vim.g.have_nerd_font })

		-- Cursor location shown as LINE:COLUMN
		---@diagnostic disable-next-line: duplicate-set-field
		statusline.section_location = function()
			return "%2l:%-2v"
		end
	end,
}
