Matrix = {}

function Matrix.__init__()
    local self = {}

    self.basalt = require("basalt")
    self.monitor = self.basalt.addMonitor()
        :setMonitor("left")
        :setBackground(colors.black)
        :setBorder(colors.green)

    -- idk maybe pass this somewhere
    self.pad = 3

    -- derive x and y padding
    self.padX = self.pad * 2
    self.padY = self.pad

    -- pull monitor size and adjust per padding
    self.x, self.y = self.monitor:getSize()

    self.x = self.x - (self.padX * 2)
    self.y = self.y - (self.padY * 2)


    self.text = {}

    for x = 1, self.x do
        self.text[x] = {}
        for y = 1, self.y do
            self.text[x][y] = self.monitor:addTextField()
                :setForeground(colors.green)
                :setSize(1, 1)
                :setPosition()
                :addLine("x")
        end
    end


    --self.text = self.monitor:addTextField()
    --    :setForeground(colors.green)
    --    :setSize(self.x, self.y)
    --    :setPosition(self.padX + 1, self.padY + 1)

    self.thread = self.monitor:addThread()
        :start(Matrix.autoUpdate(self))


    setmetatable(self, {__index = Matrix})
    return self
end

function Matrix.autoUpdate(self)
    self.basalt.autoUpdate()
end

setmetatable(Matrix, {__call = Matrix.__init__})

local matrix = Matrix()

