return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		local function save_harpoon(list)
			if list.save then
				list:save()
			end
		end

		local function swap_harpoon(a, b)
			local list = harpoon:list()

			if not list.items[a] or not list.items[b] then
				vim.notify("Cannot swap empty Harpoon slots", vim.log.levels.WARN)
				return
			end

			list.items[a], list.items[b] = list.items[b], list.items[a]
			save_harpoon(list)

			vim.notify("Swapped Harpoon " .. a .. " and " .. b)
		end

		local function replace_slot(idx)
			local list = harpoon:list()
			local file = vim.fn.expand("%:p")

			if file == "" then
				vim.notify("No file opened", vim.log.levels.WARN)
				return
			end

			list.items[idx] = {
				value = file,
				context = {
					row = vim.fn.line("."),
					col = vim.fn.col("."),
				},
			}

			save_harpoon(list)

			vim.notify("Replaced Harpoon slot " .. idx .. " with " .. vim.fn.expand("%:t"))
		end

		-- Add current file
		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Harpoon Add File" })

		-- Open Harpoon menu
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon Menu" })

		-- Jump to slots: <leader> + h/j/k/l -> slots 1-4 (home row)
		local slot_keys = { "<leader>h", "<leader>j", "<leader>k", "<leader>l" }
		for i, key in ipairs(slot_keys) do
			vim.keymap.set("n", key, function()
				harpoon:list():select(i)
			end, { desc = "Harpoon " .. i })
		end

		-- Swap slots
		vim.keymap.set("n", "<leader>r12", function()
			swap_harpoon(1, 2)
		end, { desc = "Swap Harpoon 1 and 2" })

		vim.keymap.set("n", "<leader>r13", function()
			swap_harpoon(1, 3)
		end, { desc = "Swap Harpoon 1 and 3" })

		vim.keymap.set("n", "<leader>r14", function()
			swap_harpoon(1, 4)
		end, { desc = "Swap Harpoon 1 and 4" })

		vim.keymap.set("n", "<leader>r23", function()
			swap_harpoon(2, 3)
		end, { desc = "Swap Harpoon 2 and 3" })

		vim.keymap.set("n", "<leader>r24", function()
			swap_harpoon(2, 4)
		end, { desc = "Swap Harpoon 2 and 4" })

		vim.keymap.set("n", "<leader>r34", function()
			swap_harpoon(3, 4)
		end, { desc = "Swap Harpoon 3 and 4" })

		-- Replace slot with current file
		vim.keymap.set("n", "<leader>ra1", function()
			replace_slot(1)
		end, { desc = "Replace Harpoon 1" })

		vim.keymap.set("n", "<leader>ra2", function()
			replace_slot(2)
		end, { desc = "Replace Harpoon 2" })

		vim.keymap.set("n", "<leader>ra3", function()
			replace_slot(3)
		end, { desc = "Replace Harpoon 3" })

		vim.keymap.set("n", "<leader>ra4", function()
			replace_slot(4)
		end, { desc = "Replace Harpoon 4" })
	end,
}
