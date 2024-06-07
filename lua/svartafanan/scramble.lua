local file = require("svartafanan.file")

local M = {}

local function get_random_move(full_scramble_notation, previous_move)
	-- Set the seed for the random number generator
	math.randomseed(os.time())

	-- Generate a random number between 1 and the length of the full scramble notation
	local random_number = math.random(1, #full_scramble_notation)
	local random_move

	-- Get the random move and make sure it's not the same as the previous move
	-- FIXME: This creates an infinite loop if the previous move is the same as the random move or if the previous move is nil
	while previous_move == nil or string.sub(random_move, 1, 1) == string.sub(previous_move, 1, 1) do
		-- Generate a new random number
		random_move = full_scramble_notation[random_number]
	end

	-- Return the random move
	return random_move
end

function M.scramble(cube_size)
	-- Read the scramble file based on the cube size
	local file_contents = file.read(cube_size)

	-- The first move is always added as it's always valid
	local scramble = { get_random_move(file_contents.availableMoves) }

	print(vim.inspect(scramble))

	-- Start at 2 since the first move is already added
	for i = 2, file_contents.numberOfMoves do
		print("i: " .. i)
		table.insert(scramble, get_random_move(file_contents.availableMoves, scramble[i - 1]))
	end

	return scramble
end

return M
