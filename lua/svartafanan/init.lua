local M = {}

-- Available commands for SvartaFanan
---@type table<string, function>
local sub_cmds = {
	["2x2"] = function()
		require("svartafanan.main").main("two_by_two")
	end,
	["3x3"] = function()
		require("svartafanan.main").main("three_by_three")
	end,
}

local function command(opts)
	if #opts.fargs ~= 1 then
		vim.notify("SvartaFanan: command expects only one argument", vim.log.levels.ERROR)
		return
	end

	local subcmd = opts.fargs[1]
	if sub_cmds[subcmd] then
		sub_cmds[subcmd]()
	else
		vim.notify(("SvartaFanan: unknown command '%s'"):format(subcmd), vim.log.levels.ERROR)
	end
end

local function tab_completion(arg_lead, cmdline, _)
	if cmdline:match("^SvartaFanan%s+%w*$") then
		local subcmd_keys = vim.tbl_keys(sub_cmds)
		return vim.iter(subcmd_keys)
			:filter(function(key)
				return key:find(arg_lead) ~= nil
			end)
			:totable()
	end
end

vim.api.nvim_create_user_command(
	"SvartaFanan",
	command,
	{ nargs = "*", complete = tab_completion, desc = "SvartaFanan plugin" }
)

return M
