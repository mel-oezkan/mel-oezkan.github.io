local lu = require("luaunit")
local Cleanup = require("cleanup")

function testCleanupRemovesWhitespace()
    local input = "a  b"
    local output = Cleanup.clean_content(input)
    lu.assertEquals(output, "a b")
end