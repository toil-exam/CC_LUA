-- basalt st00f
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

-- game st00f
function EmptyBoard()
    return {
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0}
    }
end

Values = EmptyBoard()
Texts = {}
Buttons = {}

Dir = {
    -- "dir", "char", x offset, y offset
    {"up", "^", 0, -1},
    {"right", ">", 1, 0},
    {"down", "v", 0, 1},
    {"left", "<", -1, 0},
}


for row = 1, 4 do
    Texts[row] = {}
    for col = 1, 4 do
        local x = ((row - 1) * 5) + padX
        local y = Y - ((col - 1) * 2) + padY + 1 -- negation on y axis to make origin bottom left

        Texts[row][col] = Monitor:addTextfield()
            :setForeground(colors.white)
            :setSize(1, 1)
            :setPosition(x, y)
            :addLine(x .. ", " .. y, 1)
    end
end

function Get(x, y)
    return Values[x][y]
end

function Set(x, y, value)
    Values[x][y] = value
    Texts[x][y]:editLine(1, value)
end

function RandomFill()
    local empties = {}

    for row = 1, 4 do
        for col = 1, 4 do
            if Get(row, col) == 0 then
                empties[#empties+1] = {row, col}
            end
        end
    end

    local count = #empties

    if count == 0 then
        return false
    end

    local rando = math.random(count)

    local x, y = empties[rando][1], empties[rando][2]

    -- 1 in 8 chance of being a 4, otherwise a 2
    local value = math.random(8)

    if value == 1 then
        value = 4
    else
        value = 2
    end

    Set(x, y, value)
end

-- init with one rando
RandomFill()


function Move(dir)
    local axis = "x"
    local bias = true
    local start, finish = 1, 4
    local temp = EmptyBoard()

    if dir == "up" or dir == "down" then
        axis = "y"
    end

    if dir == "down" or dir == "right" then
        bias = false
        start, finish = 4, 1
    end

    

    RandomFill()
end









local button_x = 25
local button_y = 5

for i = 1, 4 do
    local dir = Dir[i][1]
    local char = Dir[i][2]
    local x_offset = Dir[i][3] * 5
    local y_offset = Dir[i][4] * 3

    Buttons.text = Monitor:addButton()
        :setText(char)
        :setSize(3,3)
        :setPosition(button_x + x_offset, button_y + y_offset)
        :onClick(
            function(self, event, button, x, y)
                if (event == "mouse_click") and (button == 1) then
                    self:setText("!")
                    --Move(dir)
                    Move("left") -- ONLY LEFT
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