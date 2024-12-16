local M = {}

---timer object (see `:h uv.new_timer()`)
---@type uv_timer_t
M.timer = nil

---total time in seconds
---@type number
M.time = 0

---is the timer active?
---@type boolean
M.active = false

---function that initializes and starts the timer
function M.start_timer()
	-- if the timer is already active, stop it
	if M.timer then
		M.stop_timer()
	end
	-- initialize the timer
	M.active = true
	-- vim.loop is for older versions, vim.uv is for the newer ones, this way we don't have to check the version
	M.timer = (vim.loop or vim.uv).new_timer()

	-- see `:h uv.timer_start()`
	M.timer:start(
		0,
		10, -- update the time every 1/100 of a second
		vim.schedule_wrap(function()
			-- if the timer gets stopped (e.g. via WinClosed autocmd from window.lua),
			-- and this scheduled callback is not yet triggered, we should stop it
			if not M.active then
				return
			end
			M.time = M.time + 0.01
			require("svartafanan.window").update_timer(M.time)
		end)
	)
end

---function that stops the timer and destroys the timer object
function M.stop_timer()
	M.active = false
	if M.timer then
		-- see `:h uv.timer_stop()` and `:h uv.close()`
		M.timer:stop()
		M.timer:close()
		M.timer = nil
	end
	M.time = 0
end

return M
