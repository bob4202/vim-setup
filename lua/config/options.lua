-- [[ Setting options ]]
-- See `:help vim.o`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Background and stuffs
vim.api.nvim_set_hl(0, "Normal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#000000" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "#000000" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#000000" })
vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "#000000" })
vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "#000000" })

-- Enable break indent
vim.o.breakindent = true

-- Enable undo/redo changes even after closing and reopening a file
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.o.expandtab = true
vim.opt.guicursor = "n-v-c:block-blinkwait700-blinkoff400-blinkon250,i-ci-ve:block-blinkon0"

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Confirm instead of failing operations that would lose unsaved changes
vim.o.confirm = true
