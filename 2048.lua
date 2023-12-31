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
        local x = ((col - 1) * 5) + padX
        local y = ((row - 1) * 2) + padY

        Texts[row][col] = Monitor:addTextfield()
            :setForeground(colors.white)
            :setSize(5, 1)
            :setPosition(x, y)
            :addLine(col .. ", " .. row, 1)
    end
end

function Get(col, row)
    if (col < 1 or col > 4) or (row < 1 or row > 4) then
        return 0
    else
        return Values[row][col]
    end
end

function Set(col, row, value)
    Values[row][col] = value
    Texts[row][col]:editLine(1, value)
end

function RandomFill()
    local empties = {}

    for row = 1, 4 do
        for col = 1, 4 do
            if Get(col, row) == 0 then
                empties[#empties+1] = {col, row}
            end
        end
    end

    local count = #empties

    if count == 0 then
        return false
    end

    local rando = math.random(count)

    local col, row = empties[rando][1], empties[rando][2]

    -- 1 in 8 chance of being a 4, otherwise a 2
    local value = math.random(8)

    if value == 1 then
        value = 4
    else
        value = 2
    end

    Set(col, row, value)
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

    for row = 1, 4 do
        temp[row] = {}
        local counter = 1
        while counter < 5 do
            local value = Get(counter, row)
            local next = 0

            -- iterate to the next while also checking for zeros
            while next == 0 and counter < 5 do
                counter = counter + 1
                next = Get(counter, row)
            end

            if value == 0 then
                -- do nothing ?? don't append the 0 !!
            elseif value == next then
                temp[row][#temp[row]+1] = value * 2
                counter = counter + 1 -- iterate past the duplicate
            else
                temp[row][#temp[row]+1] = value -- append the non zero value
            end
        end

        while #temp[row] < 4 do
            temp[row][#temp[row]+1] = 0 -- fill with zeros
        end
    end

    for row = 1, 4 do
        for col = 1, 4 do
            Set(col, row, temp[row][col])
        end
    end

    RandomFill()
end









local button_x = 31
local button_y = 12

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