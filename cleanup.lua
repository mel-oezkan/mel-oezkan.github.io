local Cleanup = {}

function Cleanup.clean_content(content)
    -- Remove block comments like /* ... */
    content = content:gsub("/%*.-%*/", "")

    -- Remove line comments like // ...
    content = content:gsub("//.-\n", "\n")

    -- Collapse extra blank lines while preserving structure
    content = content:gsub("\n%s*\n", "\n")

    return content
end

function Cleanup.clean_file(input_path, output_path)
    local input = assert(io.open(input_path, "r"), "Unable to read input file: " .. input_path)
    local content = input:read("*a")
    input:close()

    local cleaned = Cleanup.clean_content(content)

    local output = assert(io.open(output_path, "w"), "Unable to write output file: " .. output_path)
    output:write(cleaned)
    output:close()

    return cleaned
end

return Cleanup
