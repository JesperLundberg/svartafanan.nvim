local utils = require("svartafanan.utils")

local M = {}

local function decode_json(json)
	return vim.fn.json_decode(json)
end

function M.read(cube_size)
	-- Get the path to the plugin directory
	local plugin_path = utils.get_value_fuzzy(vim.api.nvim_list_runtime_paths(), "svartafanan.nvim")

	-- Read the scramble file based on the cube size
	local filepath = plugin_path .. "/assets/cube_scramble_data/" .. cube_size .. ".json"

	local file = io.open(filepath, "r")

	if not file then
		vim.notify("File for " .. cube_size .. " not found", vim.log.levels.ERROR)
	end

	-- read the entire file to get the full notion of the availble movements on the cube
	local file_content = file:read("*a")

	-- decode the json from the file
	local json = decode_json(file_content)

	file:close()

	local return_table = {
		numberOfMoves = json.numberOfMoves,
		availableMoves = vim.split(json.availableMoves, " "),
	}

	-- split the notation into a table and return the table
	return return_table
end

return M
