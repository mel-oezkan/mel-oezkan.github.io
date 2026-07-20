local StyleNodes = require("parser.data")

local parser = {}

function ruleStartWith(text_line)
    if not text_line:match("^[.#%a \t]") then
        return false
    end
    return true
end

function ruleEndWith(text_line)
    if not text_line:match("[;{}]$") then
        return false
    end
    return true
end


function checkRules(text_lines, index)
    -- Rule 1 only can start with these 4 options
    for _, line in ipairs(text_lines) do
        if line ~= "}" then
            assert(ruleStartWith(line), "Line " .. index .. " does not start with a valid character: " .. line)
        end
        assert(ruleEndWith(line), "Line " .. index .. " does not end with a valid character: " .. line)
    end
    return true
end 
    

-- Read the full text
-- Keep track of the depth and store the styles 
-- Unwind the depths by adding the names of the parents to the children
function parser.parse_file(clean_content)
    local style_nodes = {}
    local active_node_list = {}

    -- create the style node list from the content 
    for index, line in ipairs(clean_content) do
        -- valid file 
        if not checkRules(clean_content, index) then
            error("Invalid rule found at line " .. index .. ": " .. line)
        end

        -- when we have newline with a rule check if there is a current style node to add the rule to
        
        -- there are 2 options either there is a new style node or we are adding a rule to the current style node
        if line:match("{") then
            local new_node = StyleNodes:new(line, {})

            -- we are currently in a nested node
            if #active_node_list > 0 then
                -- add the new node as a child of the last active node
                local parent_node = active_node_list[#active_node_list]
                local child_node = parent_node:add_child(new_node.key, new_node.properties)
                table.insert(active_node_list, child_node)
            else
                table.insert(style_nodes, new_node)
                table.insert(active_node_list, new_node)
            end

        -- if we close the current style node we need to pop the last active node from the list
        elseif line:match("}") then
            table.remove(active_node_list)
        else 
            -- we are adding a rule to the current active node
            if #active_node_list > 0 then
                local current_node = active_node_list[#active_node_list]
                -- parse the rule and add it to the current node's properties
                local property, value = line:match("(%S+)%s*:%s*(%S+);")
                if property and value then
                    current_node.properties[property] = value
                else
                    error("Invalid property format at line " .. index .. ": " .. line)
                end
            else
                error("Rule found outside of any style node at line " .. index .. ": " .. line)
            end
        end
    end
    return style_nodes
end

return parser
