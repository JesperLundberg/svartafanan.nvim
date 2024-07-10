local api = vim.api

local M = {}

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
---@return number, number
function M.open()
	-- Create buffers for both windows
	local buf = api.nvim_create_buf(false, true)
	local border_buf = api.nvim_create_buf(false, true)

	-- Set the buffer to be a temporary buffer that will be deleted when it is no longer in use
	api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	api.nvim_set_option_value("filetype", "SvartaFanan", { buf = buf })

	-- Get dimensions of neovim editor
	local width = api.nvim_get_option_value("columns", { scope = "global" })
	local height = api.nvim_get_option_value("lines", { scope = "global" })

	-- Calculate our floating window size so its 80% of the editor size
	local win_height = math.ceil(height * 0.8 - 4)
	local win_width = math.ceil(width * 0.8)
	local row = math.ceil((height - win_height) / 2 - 1)
	local col = math.ceil((width - win_width) / 2)

	local border_opts = {
		style = "minimal",
		relative = "editor",
		width = win_width + 2,
		height = win_height + 2,
		row = row - 1,
		col = col - 1,
	}

	local opts = {
		style = "minimal",
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
	}

	-- Set border buffer lines
	local border_lines = { "╔" .. string.rep("═", win_width) .. "╗" }
	local middle_line = "║" .. string.rep(" ", win_width) .. "║"
	for _ = 1, win_height do
		table.insert(border_lines, middle_line)
	end
	table.insert(border_lines, "╚" .. string.rep("═", win_width) .. "╝")
	api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)

	-- Open the border window first then the actual window
	api.nvim_open_win(border_buf, true, border_opts)
	local win = api.nvim_open_win(buf, true, opts)

	-- If the window is closed, close the border window as well
	api.nvim_command('au BufWipeout <buffer> exe "silent bwipeout! "' .. border_buf)

	-- we can add title already here, because first line will never change
	api.nvim_buf_set_lines(buf, 0, -1, false, { center("SvartaFanan"), "", "" })

	return win, buf -- Return window and buffer handles
end

---Method to set the content of the window
---@param win integer window handle
---@param buf integer buffer handle
---@param text_to_print string
function M.update(win, buf, text_to_print)
	-- Make the buffer modifiable
	api.nvim_set_option_value("modifiable", true, { buf = buf })

	-- Get the current lines in the buffer
	local current_lines = api.nvim_buf_get_lines(buf, 0, -1, false)

	-- Add the new lines to the current lines
	local lines_to_write = vim.list_extend(current_lines, { center(text_to_print) })

	-- Set the updated lines
	api.nvim_buf_set_lines(buf, 0, -1, false, lines_to_write)

	-- Make the buffer unmodifiable
	api.nvim_set_option_value("modifiable", false, { buf = buf })

	-- Set the cursor to the last line
	api.nvim_win_set_cursor(win, { #lines_to_write, 0 })
end

return M
