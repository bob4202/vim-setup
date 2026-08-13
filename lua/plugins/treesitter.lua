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

		-- Use treesitter for indentation on JS/TS/JSX/TSX, where the built-in
		-- indent script doesn't understand nested JSX and drifts badly.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact", "tsx", "jsdoc" },
			callback = function(args)
				vim.bo[args.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
			end,
		})
	end,
}
