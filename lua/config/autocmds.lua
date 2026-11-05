-- [[ Basic Autocommands ]]
-- See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Create missing parent directories before writing a new file
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function(args)
		-- Skip oil:// and other name:// buffers, which aren't real file paths
		if args.match:match("^%w[%w+.-]*://") then
			return
		end
		local dir = vim.fn.fnamemodify(args.match, ":p:h")
		if vim.fn.isdirectory(dir) == 0 then
			vim.fn.mkdir(dir, "p")
		end
	end,
})

-- Check if the current file changed on disk (e.g. `git pull` or Claude Code
-- editing it from another tmux pane) and reload it, since `autoread` alone
-- only checks on a few events
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	desc = "Reload buffer if it changed on disk",
	group = vim.api.nvim_create_augroup("checktime", { clear = true }),
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd("checktime")
		end
	end,
})

-- Watch every open file on disk and reload it the instant it changes
-- externally (e.g. Claude Code editing it in another pane), instead of
-- waiting for the next FocusGained/CursorHold poll above
local filewatch_group = vim.api.nvim_create_augroup("filewatch", { clear = true })
local watchers = {}

local function unwatch(bufnr)
	local handle = watchers[bufnr]
	if handle then
		handle:stop()
		if not handle:is_closing() then
			handle:close()
		end
		watchers[bufnr] = nil
	end
end

local function watch(bufnr)
	if watchers[bufnr] or vim.bo[bufnr].buftype ~= "" then
		return
	end
	local file = vim.api.nvim_buf_get_name(bufnr)
	if file == "" or vim.fn.filereadable(file) == 0 then
		return
	end

	local handle = vim.uv.new_fs_event()
	watchers[bufnr] = handle
	-- Watching the file's directory (not the file itself) survives editors
	-- that write via replace-and-rename instead of in-place writes
	handle:start(vim.fn.fnamemodify(file, ":h"), {}, function(err, filename)
		if err or filename ~= vim.fn.fnamemodify(file, ":t") then
			return
		end
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(bufnr) then
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("checktime")
				end)
			end
		end)
	end)
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	desc = "Start watching a file for external changes",
	group = filewatch_group,
	callback = function(args)
		watch(args.buf)
	end,
})

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout", "VimLeavePre" }, {
	desc = "Stop watching a file for external changes",
	group = filewatch_group,
	callback = function(args)
		unwatch(args.buf)
	end,
})
