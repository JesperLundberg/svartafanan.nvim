local assert = require("luassert")

local sut = require("svartafanan.utils")

describe("utils", function()
	describe("get_value_fuzzy", function()
		local tab = { "value_with_text", "cheese_is_nice", "I_like_grapes" }

		it("should return the full value if it is in table as the start of the word", function()
			assert.is_equal("cheese_is_nice", sut.get_value_fuzzy(tab, "cheese"))
		end)

		it("should return the full value if it is in table as the end of the word", function()
			assert.is_equal("cheese_is_nice", sut.get_value_fuzzy(tab, "nice"))
		end)

		it("should return the full value if it is in table as the middle of the word", function()
			assert.is_equal("cheese_is_nice", sut.get_value_fuzzy(tab, "is"))
		end)

		it("should return false if the value is not in table", function()
			assert.is_false(sut.get_value_fuzzy(tab, "not_in_table"))
		end)

		it("should return false if the table is nil", function()
			assert.is_false(sut.get_value_fuzzy(nil, "not_in_table"))
		end)
	end)
end)
