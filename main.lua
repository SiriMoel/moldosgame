dofile("utils.lua")

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    fontsize20 = love.graphics.newFont(20)

    keystring = ""

    soul_tiers = {
        {
            id = "desecrated",
            name = "Desecrated",
            border = "sprites/souls/border_desecrated.png",
        },
        {
            id = "shattered",
            name = "Shattered",
            border = "sprites/souls/border_shattered.png",
        },
        {
            id = "intact",
            name = "Intact",
            border = "sprites/souls/border_intact.png",
        },
        {
            id = "flawless",
            name = "Flawless",
            border = "sprites/souls/border_flawless.png",
        },
        {
            id = "gilded",
            name = "Gilded",
            border = "sprites/souls/border_gilded.png",
        },
    }

    local soul_types_tocreate = {
        {
            id = "beast",
            name = "Beast",
            sprite = "sprites/souls/soul_beast.png",
        },
        {
            id = "plant",
            name = "Plant",
            sprite = "sprites/souls/soul_plant.png",
        },
        {
            id = "fungus",
            name = "Fungus",
            sprite = "sprites/souls/soul_fungus.png",
        },
        {
            id = "construct",
            name = "Construct",
            sprite = "sprites/souls/soul_construct.png",
        },
    }

    soul_types = {}

    for i,tier in ipairs(soul_tiers) do
        for i2,soul in ipairs(soul_types_tocreate) do
            table.insert(soul_types, {
                id = tier.id .. "_" .. soul.id,
                name = tier.name .. " " .. soul.name .. " Soul",
                soul = soul.id,
                tier = tier.id,
                tier_number = i,
                sprite = soul.sprite,
                border = tier.border,
                count = 0,
            })
        end
    end
end

function love.update(dt)
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontsize20)
    
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
    love.graphics.setFont(fontsize20)

    local centre_x, centre_y = (screen_width / 7) * 5, (screen_height / 6) * 4
    local inc = (math.pi * 2) / #soul_types
    local soul_x = 0
    local soul_y = 0
    local soul_types_todraw = {}
    for i,soul in ipairs(soul_types) do
---@diagnostic disable-next-line: undefined-field
        if soul.count > 0 then
            table.insert(soul_types_todraw, soul)
        end
    end
    for i,soul in ipairs(soul_types_todraw) do
        soul_x = centre_x + math.cos(inc * i) * 120
        soul_y = centre_y + math.sin(inc * i) * 120
        local sprite = love.graphics.newImage(soul.sprite)
        local border = love.graphics.newImage(soul.border)
        love.graphics.draw(border, soul_x, soul_y, 0, 2, 2)
        love.graphics.draw(sprite, soul_x, soul_y, 0, 2, 2)
        love.graphics.print(soul.count, soul_x + 20, soul_y)
    end
end