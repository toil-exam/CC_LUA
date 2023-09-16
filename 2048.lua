Values = {}
Texts = {}
Buttons = {}

Basalt = require("basalt")
Monitor = Basalt.addMonitor()
    :setMonitor("left")
    :setBackground(colors.black)
    :setBorder(colors.blue)


local padding = 3

local padX = padding * 2
local padY = padding

X, Y = Monitor:getSize()

X = X - (padX * 2)
Y = Y - (padY * 2)

for row = 1, 4 do
    Values[row] = {}
    Texts[row] = {}
    for col = 1, 4 do
        Values[row][col] = 0
        Texts[row][col] = Monitor:addTextfield()
            :setForeground(colors.white)
            :setSize(1, 1)
            :setPosition((row * 5) + padX, Y - (col * 2) + padY + 1) -- negation on y axis to make origin bottom left
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
    local x_offset = button_init[i][2] * 5
    local y_offset = button_init[i][3] * 3

    Buttons.text = Monitor:addButton()
        :setText(text)
        :setSize(7,1)
        :setPosition(button_x + x_offset, button_y + y_offset)
        :onClick(
            function(self, event, button, x, y)
                if (event == "mouse_click") and (button == 1) then
                    self:setText("!")
                end
            end
        )
end

function Run()
    while true do
        
        os.sleep(1)
    end
end



Basalt.autoUpdate()