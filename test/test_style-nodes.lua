local lu = require("luaunit")
local StyleNodes = require("parser.data")

function testStyleNodesStoresClassRule()
	local node = StyleNodes:new(".some-class", { color = "red" })

	lu.assertEquals(node.key, ".some-class")
	lu.assertEquals(node.properties.color, "red")
end

function testStyleNodesCanAddChild()
    local parent = StyleNodes:new(".parent", { color = "blue" })
    local child = parent:add_child(".child", { color = "green" })

    print("number of children: " .. #parent.children)
    lu.assertEquals(#parent.children, 1)
    lu.assertEquals(parent.children[1], child)
    
    lu.assertEquals(child.key, ".child")
    lu.assertEquals(child.properties.color, "green")
end

