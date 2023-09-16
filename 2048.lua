Values = {}
Texts = {}
Buttons = {}

local basalt = require("basalt")
local monitor = basalt.addMonitor()
    :setMonitor("left")
    :setBackground(colors.black)
    :setBorder(colors.blue)


local pad = 3

local padX = pad * 2
local padY = pad

local x, y = monitor:getSize()

x = x - (padX * 2)
y = y - (padY * 2)

for row = 1, 4 do
    Values[row] = {}
    Texts[row] = {}
    for col = 1, 4 do
        Values[row][col] = 0
        Texts[row][col] = monitor:addTextfield()
            :setForeground(colors.white)
            :setSize(1, 1)
            :setPosition(row + padX, y - col + padY + 1) -- negation on y axis to make origin bottom left
            :addLine("0", 1)
    end
end

-- "text", x offset, y offset
local button_init = {
    {"up", 0, -1},
    {"right", 1, 0},
    {"down", 0, 1},
    {"left", -1, 0},
}

local button_x = 20
local button_y = 10

for i = 1, 4 do
    local text = button_init[i][1]
    local x_offset = button_init[i][2]
    local y_offset = button_init[i][3]

    Buttons.text = monitor:addButton()
        :setText(text)
        :setSize(3,3)
        :setPosition(button_x + x_offset, button_y + y_offset)
end

function Run()
    while true do
        
        os.sleep(1)
    end
end



basalt.autoUpdate()