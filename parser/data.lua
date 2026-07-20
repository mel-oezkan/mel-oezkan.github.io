
StyleNodes = {}
StyleNodes.__index = StyleNodes

function StyleNodes:new(elementName, properties)
    local self = setmetatable({}, StyleNodes)
    self.key = elementName
    self.properties = properties
    self.children = {}
    return self
end

function StyleNodes:add_child(value, properties)
    local child = StyleNodes:new(value, properties)
    table.insert(self.children, child)
    return child
end

function write_style_nodes_to_file(style_nodes, file_path)
    local file = io.open(file_path, "w")
    
    for _, node in ipairs(style_nodes) do
        write_node_to_file(node, file, 0)
    end

    file:close()
end

return StyleNodes