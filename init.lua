-- Neovim config entrypoint
-- Structure:
--   lua/config/options.lua  - vim.o/vim.opt settings
--   lua/config/keymaps.lua  - global keymaps (non-plugin)
--   lua/config/autocmds.lua - autocommands
--   lua/config/lazy.lua     - lazy.nvim bootstrap, loads lua/plugins/*.lua
--   lua/plugins/*.lua       - one file per plugin spec

-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")

-- vim: ts=2 sts=2 sw=2 et
