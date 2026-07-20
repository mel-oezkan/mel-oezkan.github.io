lu = require('luaunit')

require("test/test_style-nodes")
require("test/test_cleanup")
require("test/test_parsing")

os.exit( lu.LuaUnit.run() )