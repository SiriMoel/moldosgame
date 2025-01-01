dofile("utils.lua")

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    gamefont = love.graphics.newFont(20)

    keystring = ""

    soultypes = {
        {
            id = "bat",
            sprite = "sprites/souls/soul_bat.png",
            count = 0,
        },
        {
            id = "fly",
            sprite = "sprites/souls/soul_fly.png",
            count = 0,
        },
        {
            id = "mage",
            sprite = "sprites/souls/soul_mage.png",
            count = 0,
        },
        {
            id = "slimes",
            sprite = "sprites/souls/soul_slimes.png",
            count = 0,
        },
        {
            id = "void",
            sprite = "sprites/souls/soul_souls_void.png",
            count = 0,
        },
    }
end

function love.update(dt)
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gamefont)
    
    love.graphics.print(keystring, 200, 100)

    DrawGui()
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then

    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then

    end
end

function love.keypressed(key, scancode, isrepeat)
    keystring = key
end

function DrawWorld()

end

function DrawGui()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(gamefont)

    local centre_x, centre_y = (screen_width / 7) * 5, (screen_height / 6) * 4
    local inc = (math.pi * 2) / #soultypes
    local soul_x = 0
    local soul_y = 0
    local soultypes_todraw = {}
    for i,soul in ipairs(soultypes) do
        if soul.count > 0 then
            table.insert(soultypes_todraw, soul)
        end
    end
    for i,soul in ipairs(soultypes_todraw) do
        soul_x = centre_x + math.cos(inc * i) * 80
        soul_y = centre_y + math.sin(inc * i) * 80
        local sprite = love.graphics.newImage(soul.sprite)
        love.graphics.draw(sprite, soul_x, soul_y, 0, 2, 2)
        love.graphics.print(soul.count, soul_x + 20, soul_y)
    end
end