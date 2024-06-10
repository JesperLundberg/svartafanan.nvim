local scrambler = require("svartafanan.scramble")

local M = {}

function M.main(cube_size)
	-- Open new temporary buffer

	-- Get the scramble from svartafanan.scramble
	local scramble = scrambler.scramble(cube_size)

	print(vim.inspect(scramble))
end

return M
