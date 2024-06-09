local assert = require("luassert")
local stub = require("luassert.stub")

local sut = require("svartafanan.scramble")

describe("scramble", function()
	local file_read_stub

	before_each(function()
		file_read_stub = stub(require("svartafanan.file"), "read")
	end)

	after_each(function()
		if file_read_stub then
			file_read_stub:revert()
		end
	end)

	describe("get_scramble", function()
		local file_contents = {
			numberOfMoves = 5,
			availableMoves = { "U", "D", "R", "L", "F", "B" },
		}

		it("should return a scramble of the provided size", function()
			file_read_stub.returns(file_contents)

			local scramble = sut.scramble(5)

			assert.is_equal(5, #scramble)
		end)

		it("should return a scramble containing only the available moves", function()
			file_read_stub.returns(file_contents)

			local scramble = sut.scramble(5)

			for _, move in ipairs(scramble) do
				assert.is_true(vim.tbl_contains(file_contents.availableMoves, move))
			end
		end)
	end)
end)
