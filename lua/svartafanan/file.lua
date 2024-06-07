local M = {}

local function get_plugin_path()
	-- This assumes your plugin name is 'myplugin' and it's located in the standard Neovim runtime path
	local runtime_path = vim.fn.stdpath("data") .. "/lazy/svartafanan.nvim"
	return runtime_path
end

function M.read(cube_size)
	local plugin_path = get_plugin_path()

	-- Read the scramble file based on the cube size
	local filepath = plugin_path .. "/assets/cube_scramble_data/" .. cube_size

	print("filepath: ", filepath)

	local file = io.open(filepath, "r")

	print("file: ", file)

	if not file then
		return "File for " .. cube_size .. " not found"
	end

	-- read the entire file to get the full notion of the availble movements on the cube
	local full_scramble_notation = file:read("*a")

	file:close()

	-- split the notation into a table
	full_scramble_notation = vim.split(full_scramble_notation, " ")

	vim.notify("full_scramble_notation: " .. vim.inspect(full_scramble_notation), vim.log.levels.INFO)

	return full_scramble_notation
end

return M
