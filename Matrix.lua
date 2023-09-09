Matrix = {}

local basalt = require("basalt")
local monitor = basalt.addMonitor()
    :setMonitor("left")
    :setBackground(colors.black)
    :setBorder(colors.green)

local pad = 3

local padX = pad * 2
local padY = pad

local x, y = monitor:getSize()

x = x - (padX * 2)
y = y - (padY * 2)

for a = 1, x do
    Matrix[x] = {}
    for b = 1, y do
        Matrix[x][y] = monitor:addTextfield()
            :setForeground(colors.green)
            :setSize(1, 1)
            :setPosition(x + padX, y + padY)

        Matrix[x][y]:addLine("?", 1)
    end
end


function Run()
    while true do
        Matrix[math.random(x)][math.random(y)]
            :editLine(1, string.char(math.random(128)))
        os.sleep(1)
    end
end

local thread = monitor:addThread()
    :start(Run)

basalt.autoUpdate()