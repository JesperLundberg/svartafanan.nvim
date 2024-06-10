local M = {}

-- find out if table has the provided value
-- @param tab table
-- @param val string
-- @return string
function M.get_value_fuzzy(tab, val)
	if tab == nil then
		return false
	end

	for _, value in ipairs(tab) do
		-- if the value is contained in the string, return the string
		if string.match(value, val) then
			return value
		end
	end

	return false
end

return M
