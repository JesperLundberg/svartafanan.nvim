local file = require("svartafanan.file")

local M = {}

--- Get a random move from the available movements
-- @param full_scramble_notation table
-- @param previous_move string
-- @return string
local function get_random_move(full_scramble_notation, previous_move)
	local random_number
	local random_move

	repeat
		-- Generate a random number between 1 and the length of the full scramble notation
		random_number = math.random(1, #full_scramble_notation)

		-- Get the random move
		random_move = full_scramble_notation[random_number]

	-- The move should not be the same as the previous move, the opposite move or a double of those two
	until string.sub(random_move, 1, 1) ~= string.sub(previous_move, 1, 1)

	-- Return the random move
	return random_move
end

--- Generate a scramble for the cube
-- @param cube_size number
-- @return table
function M.scramble(cube_size)
	-- Read the scramble file based on the cube size
	local file_contents = file.read(cube_size)

	-- Set the seed for the random number generator
	math.randomseed(os.time())

	-- The first move is always added as it's always valid
	local scramble = { get_random_move(file_contents.availableMoves, "num1") }

	-- Start at 2 since the first move is already added
	for i = 2, file_contents.numberOfMoves do
		local previous_move = scramble[i - 1]

		-- Get a random move and add it to the scramble
		table.insert(scramble, get_random_move(file_contents.availableMoves, previous_move))
	end

	return scramble
end

return M
