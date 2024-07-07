local M = {}

---find out if table has the provided value
---@param tab table?
---@param val string
---@return string?
function M.get_value_fuzzy(tab, val)
	if tab == nil then
		return nil
	end

	for _, value in ipairs(tab) do
		-- if the value is contained in the string, return the string
		if string.match(value, val) then
			return value
		end
	end

	return nil
end

return M
