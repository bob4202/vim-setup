return { -- Highlight and resolve git merge conflict markers
	"akinsho/git-conflict.nvim",
	version = "*",
	event = "VeryLazy",
	opts = {
		default_mappings = true, -- co: choose ours, ct: choose theirs, cb: choose both, c0: choose none
		default_commands = true, -- :GitConflictChooseOurs / Theirs / Both / None / ListQf
		disable_diagnostics = false,
	},
}
