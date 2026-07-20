local lu = require("luaunit")
local rule = require("parser.rules")

function testValidStart()
    local lines = {
        ".some-class {",
        "  color: red;",
        "}"
    }

    for line in ipairs(lines) do
        print("line: " .. line)
        lu.assertEquals(ruleStartWith(lines[line]), true)
    end
end

function testValidEnd()
    local lines = {
        ".some-class {",
        "  color: red;",
        "}"
    }
    for line in ipairs(lines) do
        print("line: " .. line)
        lu.assertEquals(ruleEndWith(lines[line]), true)
    end
end

function testFullRules()
    local lines = {
        ".some-class {",
        "  color: red;",
        "}"
    }
    for line in ipairs(lines) do
        print("line: " .. line)
        lu.assertEquals(checkRules(lines, line), true)
    end
end