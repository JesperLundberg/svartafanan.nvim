local api = vim.api

local M = {}

---svartafanan buffer
---@type integer
M.buf = nil

---svartafanan window
---@type integer
M.win = nil

---Method to center a string in a window
---@param str string
---@return string
local function center(str)
	-- Get the width of the current window
	local width = api.nvim_win_get_width(0)
	-- Calculate the shift needed to center the string
	local shift = math.floor(width / 2) - math.floor(string.len(str) / 2)
	return string.rep(" ", shift) .. str
end

---Floating result window
function M.open()
	M.buf = api.nvim_create_buf(false, true)

	-- Set the buffer to be a temporary buffer that will be deleted when it is no longer in use
	api.nvim_set_option_value("bufhidden", "wipe", { buf = M.buf })
	api.nvim_set_option_value("filetype", "SvartaFanan", { buf = M.buf })

	-- Get dimensions of neovim editor
	local width = api.nvim_get_option_value("columns", { scope = "global" })
	local height = api.nvim_get_option_value("lines", { scope = "global" })

	-- Calculate our floating window size so its 80% of the editor size
	local win_height = math.ceil(height * 0.8 - 4)
	local win_width = math.ceil(width * 0.8)
	local row = math.ceil((height - win_height) / 2 - 1)
	local col = math.ceil((width - win_width) / 2)

	M.win = api.nvim_open_win(M.buf, true, {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "double",
	})

	-- fill the buffer with empty lines
	local empty_lines = {}
	for _ = 1, win_height do
		table.insert(empty_lines, "")
	end
	api.nvim_buf_set_lines(M.buf, 0, -1, false, empty_lines)

	-- set the title
	M.update("SvartaFanan", 1)

	-- if the svartafanan window gets closed, delete the buffer and stop the timer
	api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(M.win),
		group = api.nvim_create_augroup("SvartaFanan", {}),
		callback = function()
			api.nvim_buf_delete(M.buf, { force = true })
			M.buf = nil
			M.win = nil
			require("svartafanan.timer").stop_timer()
		end,
	})
end

---Method to set the content of the window
---@param text_to_print string
---@param line integer index of a line to update (1-indexed)
function M.update(text_to_print, line)
	if not M.buf then
		return
	end

	api.nvim_buf_set_lines(M.buf, line - 1, line, false, { center(text_to_print) })

	local height = api.nvim_win_get_height(M.win)
	api.nvim_win_set_cursor(M.win, { height, 0 })
end

---Update last line of the window
---@param time number
function M.update_timer(time)
	if not M.buf then
		return
	end

	local height = api.nvim_win_get_height(M.win)

	api.nvim_buf_set_lines(M.buf, height - 1, height, false, { center(string.format("Time: %.2f", time)) })
end

return M
