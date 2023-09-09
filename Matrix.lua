Matrix = {}

local basalt = require("basalt")
local monitor = basalt.addMonitor():setMonitor("left")


function Matrix.__init__()
    local self = {}
    setmetatable(self, {__index = Matrix})
    return self
end

local aThred = monitor:addThread():start(Matrix.__init__)

basalt.autoUpdate()