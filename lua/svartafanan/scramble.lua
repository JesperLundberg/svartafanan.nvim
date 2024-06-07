local M = {}

function M.scramble(cube_size)
	-- Set the seed for the random number generator
	math.randomseed(os.time())

	-- Read the scramble file based on the cube size

	-- Generate a scramble for the cube size
	vim.notify("math random: " .. math.random(1, 69), vim.log.levels.INFO)
end

return M
