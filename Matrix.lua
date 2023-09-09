Matrix = {}
Drips = {}

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
    Matrix[a] = {}
    Drips[a] = 0
    for b = 1, y do
        Matrix[a][b] = monitor:addTextfield()
            :setForeground(colors.green)
            :setSize(1, 1)
            :setPosition(a + padX, y - b + padY + 1) -- negation on y axis to make origin bottom left
            :addLine(" ", 1)
    end
end

function Run()
    while true do
        -- spawn new drip
        Drips[math.random(x)] = 1

        -- iterate through drips
        for d = 1, x do
            if Drips[d] > 0 then
                Drips[d] = Drips[d] + 1
            end

            if Drips[d] > y then
                Drips[d] = 0
            elseif Drips[d] > 0 then
                Matrix[d][Drips[d]]:editLine(1, string.char(math.random(0,128)))
            end
        end

        --Matrix[math.random(x)][math.random(y)]:editLine(1, string.char(math.random(128)))
        
        os.sleep(1)
    end
end

local thread = monitor:addThread()
    :start(Run)

basalt.autoUpdate()