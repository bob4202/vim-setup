return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup()

		require("nvim-treesitter").install({
			"go",
			"gomod",
			"gowork",
			"gosum",
			"javascript",
			"typescript",
			"tsx",
			"jsdoc",
			"json",
			"css",
			"python",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"bash",
			"html",
			"markdown",
			"markdown_inline",
		})

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"go",
				"gomod",
				"gowork",
				"gosum",
				"javascript",
				"typescript",
				"typescriptreact",
				"javascriptreact",
				"tsx",
				"jsdoc",
				"json",
				"css",
				"python",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"bash",
				"html",
				"markdown",
			},
			callback = function(args)
				if vim.bo[args.buf].filetype ~= "TelescopePrompt" then
					pcall(vim.treesitter.start, args.buf)
				end
			end,
		})

		-- Use treesitter for indentation only where JSX nesting actually needs
		-- it; the built-in indent script handles plain object/call nesting
		-- (e.g. zod schemas) better than treesitter's indent queries do.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "typescriptreact", "javascriptreact", "tsx" },
			callback = function(args)
				vim.bo[args.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
			end,
		})
	end,
}
