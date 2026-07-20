local lu = require("luaunit")
local parser = require("parser.parser")

function testParseFileKeepsDepthTwoNestingAndMultipleRules()
	local input = {
		".outer {",
		"  .middle {",
		"    div {",
		"      color: red;",
		"      background: blue;",
		"      margin: 0;",
		"    }",
		"  }",
		"}"
	}

	local style_nodes = parser.parse_file(input)

	lu.assertEquals(#style_nodes, 1)
	lu.assertEquals(#style_nodes[1].children, 1)
	lu.assertEquals(#style_nodes[1].children[1].children, 1)

	local inner_node = style_nodes[1].children[1].children[1]
	lu.assertEquals(inner_node.properties.color, "red")
	lu.assertEquals(inner_node.properties.background, "blue")
	lu.assertEquals(inner_node.properties.margin, "0")
end