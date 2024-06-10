local M = {}

-- Available commands for SvartaFanan
local commands = {
	["2x2"] = function()
		require("svartafanan.main").main("two_by_two")
	end,
	["3x3"] = function()
		require("svartafanan.main").main("three_by_three")
	end,
}

local function tab_completion(_, _, _)
	-- Tab completion for SvartaFanan
	local tab_commands = {}

	-- Loop through the commands and add the key value to the tab completion
	for k, _ in pairs(commands) do
		table.insert(tab_commands, k)
	end

	return tab_commands
end

vim.api.nvim_create_user_command("SvartaFanan", function(opts)
	-- If the command exists then run the corresponding function
	commands[opts.args]()
end, { nargs = "*", complete = tab_completion, desc = "SvartaFanan plugin" })

return M
