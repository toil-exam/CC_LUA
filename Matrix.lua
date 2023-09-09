Matrix = {}



function Matrix.__init__()
    local self = {}

    self.basalt = require("basalt")
    self.monitor = basalt.addMonitor()
        :setMonitor("left")
        :setBackground(colors.black)
        :setBorder(colors.green)

    self.pad = 3

    self.padX = self.pad * 2
    self.padY = self.pad

    self.thread = self.monitor:addThread()
        :start()


    setmetatable(self, {__index = Matrix})
    return self
end

function Matrix.autoUpdate(self)
    self.basalt.autoUpdate()
end

local matrix = Matrix.__init__()

matrix.autoUpdate(matrix)