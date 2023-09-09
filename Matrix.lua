Matrix = {}

local basalt = require("basalt")
local monitor = basalt.addMonitor()
    :setMonitor("left")
    :setBackground(colors.black)
    :setBorder(colors.green)

function Matrix.__init__()
    local self = {}

    -- idk maybe pass this somewhere
    self.pad = 3

    -- derive x and y padding
    self.padX = self.pad * 2
    self.padY = self.pad

    -- pull monitor size and adjust per padding
    self.x, self.y = monitor:getSize()

    self.x = self.x - (self.padX * 2)
    self.y = self.y - (self.padY * 2)


    self.text = {}

    for x = 1, self.x do
        self.text[x] = {}
        for y = 1, self.y do
            self.text[x][y] = monitor:addTextfield()
                :setForeground(colors.green)
                :setSize(1, 1)
                :setPosition(x + self.padX, y + self.padY)
                :addLine("?", 1)
        end
    end

    self.run()

    --self.text = self.monitor:addTextField()
    --    :setForeground(colors.green)
    --    :setSize(self.x, self.y)
    --    :setPosition(self.padX + 1, self.padY + 1)

    --self.thread = self.monitor:addThread()
    --    :start(self.run)

    --self.basalt.autoUpdate()


    setmetatable(self, {__index = Matrix})
    return self
end

--function Matrix.autoUpdate()
--    Matrix.basalt.autoUpdate()
--end

function Matrix.run(self)
    -- do nothing idk
    --return
    while true do
        self.set(self, math.random(self.x), math.random(self.y), string.char(math.random(0,128)))
        os.sleep(1)
    end
end

function Matrix.set(self, x, y, value)
    self.text[x][y]:editLine(1, value)
end

--setmetatable(Matrix, {__call = Matrix.__init__})

--local matrix = Matrix()

local thread = monitor:addThread()
    :start(Matrix.__init__)

basalt.autoUpdate()