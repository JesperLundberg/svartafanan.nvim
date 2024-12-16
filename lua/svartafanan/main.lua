local scrambler = require("svartafanan.scramble")
local window = require("svartafanan.window")
local timer = require("svartafanan.timer")

local M = {}

---Main function to generate a scramble and display it in a floating window
---@param cube_size string
function M.main(cube_size)
	-- Open new temporary buffer
	window.open()

	-- Get the scramble from svartafanan.scramble
	local scramble = scrambler.scramble(cube_size)

	-- Make a long string out of the scramble
	local scramble_string = table.concat(scramble, " ")

	-- Print the scramble to the buffer
	window.update(scramble_string, 3)

	-- Print instructions to the buffer
	window.update("Press <space> to start/stop the timer", 5)
	window.update("Press q to close the window", 6)

	window.update_timer(0)

	vim.keymap.set("n", "<space>", function()
		if timer.active then
			timer.stop_timer()
		else
			timer.start_timer()
		end
	end, { buffer = window.buf, desc = "svartafanan: start/stop timer", nowait = true })

	vim.keymap.set("n", "q", function()
		vim.api.nvim_win_close(window.win, true)
	end, { buffer = window.buf, desc = "svartafanan: close window" })
end

return M
