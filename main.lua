local Cleanup = require("cleanup")
local utils = require("utils")
local parser = require("parser")

local input_path = "./style.scss"
local output_path = "./style.css"

local source_file = io.open(input_path, "r")
local target_file = io.open(output_path, "w")


-- read and clen file
source_content = utils.read_file(input_path)
local cleaned_content = Cleanup.clean_content(table.concat(source_content, "\n"))

-- parse content into style nodes
local style_nodes = parser.parse_file(cleaned_content)
