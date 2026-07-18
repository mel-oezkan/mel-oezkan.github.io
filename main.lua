local Cleanup = require("cleanup")

StyleNodes = {}
StyleNodes.__index = StyleNodes

function StyleNodes:new(elementName, properties)
    local self = setmetatable({}, StyleNodes)
    self.key = elementName
    self.properties = properties
    self.children = {}
    return self
end

function StyleNodes:add_child(value)
    local child = StyleNodes:new(value)
    table.insert(self.children, child)
    return child
end

local input_path = "./style.scss"
local output_path = "./style.css"

local source_file = io.open(input_path, "r")
local target_file = io.open(output_path, "w")

-- store the css rules as a list and for each nested rule add one tree
css_list = {}
if source_file and target_file then
    local content = source_file:read("*a")
    source_file:close()

    local cleaned_content = Cleanup.clean_content(content)
    print("Cleaning completed")
    for line in cleaned_content:gmatch("[^\r\n]+") do
        print(line)
    end
    target_file:write(cleaned_content)
    target_file:close()
else
    print("Unable to open input or output file")
end