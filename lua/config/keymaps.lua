-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic Config & Keymaps
-- See :help vim.diagnostic.Opts
vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	virtual_text = true,
	virtual_lines = false,

	jump = { float = true },
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- to discover than <C-\><C-n>
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- CTRL+<hjkl> moves between splits and tmux panes: see plugins/tmux-navigator.lua

-- Move selected line(s) down/up in visual mode, re-indenting and re-selecting after
-- `silent` matters with cmdheight=0: otherwise the "N lines moved" message
-- triggers a hit-enter prompt that swallows the trailing `gv=gv`
vim.keymap.set("v", "J", ":<C-u>silent '<,'>m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "K", ":<C-u>silent '<,'>m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Move by display line (not logical line) with plain j/k, so cursor movement
-- follows wrapped lines naturally -- but a count prefix (e.g. 5j) still moves
-- by logical line, so macros/relative-numbers-based jumps still work
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Keep cursor centered when scrolling half a page or jumping between search results
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result, centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result, centered" })

-- Toggle back and forth between your current line and wherever you last jumped from
vim.keymap.set("n", "<leader>mm", "``", { desc = "Toggle last jump position" })

-- Paste over a visual selection without clobbering the unnamed register with
-- the replaced (deleted) text -- the deleted text goes to the black hole register instead
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selection, keep yanked text" })

-- Marks: m+key saves a spot, Option+key jumps back, across files
-- m reads the next key itself, so a pause between the two keys can't drop to
-- the built-in per-file mark. Other letters behave as usual.
-- Uses j/k/l/; (home row); Option+u/i/o/p belong to tmux window switching.
-- Stored as U/I/O/P so marks saved under the old u/i/o/p keys carry over.
local global_marks = { j = "U", k = "I", l = "O", [";"] = "P" }
vim.keymap.set("n", "m", function()
	local key = vim.fn.getcharstr()
	if key == "\27" then
		return
	end
	pcall(vim.cmd, "normal! m" .. (global_marks[key] or key))
end, { desc = "Set mark (j/k/l/; work across files)" })
for key, mark in pairs(global_marks) do
	vim.keymap.set("n", "<M-" .. key .. ">", "`" .. mark, { desc = "Jump to mark " .. mark })
end
