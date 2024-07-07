local scrambler = require("svartafanan.scramble")
local window = require("svartafanan.window")

local M = {}

---Main function to generate a scramble and display it in a floating window
---@param cube_size string
function M.main(cube_size)
	-- Open new temporary buffer
	local win, buf = window.open()

	-- Get the scramble from svartafanan.scramble
	local scramble = scrambler.scramble(cube_size)

	-- Make a long string out of the scramble
	local scramble_string = table.concat(scramble, " ")

	-- Print the scramble to the buffer
	window.update(win, buf, scramble_string)
end

return M
