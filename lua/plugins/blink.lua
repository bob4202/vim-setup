return { -- Autocompletion
	"saghen/blink.cmp",
	event = "VimEnter",
	version = "1.*",
	dependencies = {
		-- Snippet Engine
		{
			"L3MON4D3/LuaSnip",
			version = "2.*",
			build = (function()
				if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
					return
				end
				return "make install_jsregexp"
			end)(),
			opts = {},
		},
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			-- See :h blink-cmp-config-keymap for defining your own keymap
			preset = "enter",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = {
			list = {
				-- Don't preselect an item, so <CR> stays a plain newline unless
				-- you've explicitly navigated to a suggestion first.
				selection = { preselect = false },
			},
			menu = {
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "source_name" },
					},
				},
			},
			documentation = { auto_show = false, auto_show_delay_ms = 500 },
		},

		sources = {
			default = { "lsp", "path", "snippets" },
		},

		snippets = { preset = "luasnip" },

		fuzzy = { implementation = "lua" },

		signature = { enabled = true },
	},
}
