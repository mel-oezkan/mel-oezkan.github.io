function read_file(file_path)
    -- return the content of the file as list of lines
    local file = io.open(file_path, "r")
    if not file then
        error("Could not open file: " .. file_path)
    end
    local content = {}
    for line in file:lines() do
        table.insert(content, line)
    end
    
    file:close()
    return content
end