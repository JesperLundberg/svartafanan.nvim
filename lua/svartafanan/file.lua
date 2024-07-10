---@class CubeScrambleRawData
---@field numberOfMoves integer
---@field availableMoves string

---@class CubeScrambleData
---@field numberOfMoves integer
---@field availableMoves string[]

local utils = require("svartafanan.utils")
local M = {}

---Read the scramble file for the cube size
---@param cube_size string
---@return CubeScrambleData
function M.read(cube_size)
	-- Get the path to the plugin directory
	local plugin_path = utils.get_value_fuzzy(vim.api.nvim_list_runtime_paths(), "svartafanan.nvim")
	if not plugin_path then
		vim.notify("Plugin path not found", vim.log.levels.ERROR)
		return {}
	end

	-- Read the scramble file based on the cube size
	local filepath = plugin_path .. "/assets/cube_scramble_data/" .. cube_size .. ".json"

	local file = io.open(filepath, "r")

	if not file then
		vim.notify("File for " .. cube_size .. " not found", vim.log.levels.ERROR)
		return {}
	end

	-- read the entire file to get the full notion of the availble movements on the cube
	local file_content = file:read("*a")

	-- decode the json from the file
	---@type CubeScrambleRawData
	local json = vim.json.decode(file_content)

	file:close()

	return {
		numberOfMoves = json.numberOfMoves,
		availableMoves = vim.split(json.availableMoves, " "),
	}
end

return M
