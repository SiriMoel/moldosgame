dofile("utils.lua")
dofile("cards.lua")
dofile("entities.lua")
function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)

    fontsize20 = love.graphics.newFont(20)

    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()

    keystring = ""

    paused = false

    eid_upto = 1

    entities_loaded = {}

    game_state = "start" -- "main_menu", "main", "in_round"

    soul_tiers = {
        {
            id = "desecrated",
            name = "Desecrated",
            border = "gfx/souls/border_desecrated.png",
        },
        {
            id = "shattered",
            name = "Shattered",
            border = "gfx/souls/border_shattered.png",
        },
        {
            id = "intact",
            name = "Intact",
            border = "gfx/souls/border_intact.png",
        },
        {
            id = "flawless",
            name = "Flawless",
            border = "gfx/souls/border_flawless.png",
        },
        {
            id = "gilded",
            name = "Gilded",
            border = "gfx/souls/border_gilded.png",
        },
    }

    local soul_types_tocreate = {
        {
            id = "beast",
            name = "Beast",
            sprite = "gfx/souls/soul_beast.png",
        },
        {
            id = "plant",
            name = "Plant",
            sprite = "gfx/souls/soul_plant.png",
        },
        {
            id = "fungus",
            name = "Fungus",
            sprite = "gfx/souls/soul_fungus.png",
        },
        {
            id = "construct",
            name = "Construct",
            sprite = "gfx/souls/soul_construct.png",
        },
    }

    soul_types = {}

    for i,soul in ipairs(soul_types_tocreate) do
        for i2,tier in ipairs(soul_tiers) do
            table.insert(soul_types, {
                id = tier.id .. "_" .. soul.id,
                name = tier.name .. " " .. soul.name .. " Soul",
                soul = soul.id,
                tier = tier.id,
                tier_number = i2,
                sprite = soul.sprite,
                border = tier.border,
                count = 0,
            })
        end
    end

    AddSouls("beast", 1, 25)
    AddSouls("plant", 1, 25)
    --AddSouls("fungus", 1, 25)
    --AddSouls("construct", 1, 25)

    --entity_player_soul = EntityLoad("player_soul", 150, 150)
    image_exit_button = love.graphics.newImage("gfx/gui/text_exit_to_main.png")
end

function love.update(dt)
    mouse_x, mouse_y = love.mouse.getPosition()
    screen_width = love.graphics.getWidth()
    screen_height = love.graphics.getHeight()
    for i,entity in ipairs(entities_loaded) do
        local continue = true
        if paused and not EntityHasTag(entity.eid, "pause_exempt") then
            continue = false
        end
        if continue then
            if entity.func_every_frame ~= nil then
                entity.func_every_frame(entity)
            end
            local sprite_width = entity.sprite.width * entity.pos.scale_x
            local sprite_height = entity.sprite.height * entity.pos.scale_y
            if entity.hp ~= nil then
                if entity.hp < 0 then
                    if entity.func_on_death ~= nil then
                        entity.func_on_death(entity)
                    end
                    EntityKill(entity.eid)
                end
            end
            if entity.hitbox_radius ~= nil then
                if DistanceBetween(mouse_x, mouse_y, entity.pos.x + (sprite_width / 2), entity.pos.y + (sprite_height / 2)) <= (entity.hitbox_radius * entity.pos.scale) then
                    entity.func_on_hover(entity)
                    entity.colliding_with_mouse = true
                else
                    entity.colliding_with_mouse = false
                end
            else
                if CheckCollision(mouse_x, mouse_y, 0.1, 0.1, entity.pos.x, entity.pos.y, entity.hitbox.w * entity.pos.scale_x * 2, entity.hitbox.h * entity.pos.scale_y * 2) then
                    entity.func_on_hover(entity)
                    entity.colliding_with_mouse = true
                else
                    entity.colliding_with_mouse = false
                end
            end
            if entity.velocity.x ~= 0 then
                entity.pos.x = entity.pos.x + entity.velocity.x
            end
            if entity.velocity.y ~= 0 then
                entity.pos.y = entity.pos.y + entity.velocity.y
            end
        end
    end

    if not paused then

        if game_state == "start" then
            UpdateGameState("main_menu")
        end
        
        if game_state == "main_menu" then
        
        end
    
        if game_state == "main" then
    
        end
    
        if game_state == "in_round" then
            
        end
    else

    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fontsize20)

    if game_state == "main_menu" then
        local background = love.graphics.newImage("gfx/gui/background_main_menu.png")
        for i=0, screen_width / background:getWidth() do
            for j=0, screen_height / background:getHeight() do
                love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
            end
        end
        local title = love.graphics.newImage("gfx/gui/title.png")
        love.graphics.draw(title, screen_width / 3, screen_height / 8, 0, 4, 4)
    end

    if game_state == "main" then
        local background = love.graphics.newImage("gfx/gui/background.png")
        for i=0, screen_width / background:getWidth() do
            for j=0, screen_height / background:getHeight() do
                love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
            end
        end

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

    if game_state == "in_round" then
        
    end

    for i,entity in ipairs(entities_loaded) do
        local sprite = love.graphics.newImage(entity.sprite.file)
        local sprite_width = entity.sprite.width * entity.pos.scale_x
        local sprite_height = entity.sprite.height * entity.pos.scale_y
        love.graphics.draw(sprite, entity.pos.x, entity.pos.y, entity.pos.r, entity.pos.scale_x, entity.pos.scale_y)
        if entity.hitbox_radius ~= nil then
            if EntityHasTag(entity.eid, "render_shape_on_hover") and entity.colliding_with_mouse then
                love.graphics.circle("fill", entity.pos.x + (sprite_width / 2), entity.pos.y + (sprite_height / 2), entity.hitbox_radius * entity.pos.scale)
            end
        else
            if EntityHasTag(entity.eid, "render_shape_on_hover") and entity.colliding_with_mouse then
                love.graphics.rectangle("fill", entity.pos.x, entity.pos.y, entity.hitbox.w * entity.pos.scale_x * 2, entity.hitbox.h * entity.pos.scale_y * 2)
            end
        end
    end

    if paused then
        local overlay = love.graphics.newImage("gfx/gui/overlay_paused.png")
        for i=0, screen_width / overlay:getWidth() do
            for j=0, screen_height / overlay:getHeight() do
                love.graphics.draw(overlay, i * overlay:getWidth(), j * overlay:getHeight())
            end
        end
        love.graphics.print("Paused!", screen_width / 2, screen_height / 3)
        love.graphics.draw(image_exit_button, screen_width / 2, (screen_height / 3) * 2)
    end

    love.graphics.setColor(0, 1, 0)
    love.graphics.print("Current FPS: " .. tostring(love.timer.getFPS()) .. ". Game state: " .. game_state .. ". Number of entities loaded: " .. tostring(#entities_loaded) .. ".", 10, 10)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(keystring, 200, 100)
end

function love.mousepressed(x, y, button, istouch, presses)
    if CheckCollision(mouse_x, mouse_y, 0.1, 0.1, screen_width / 2, (screen_height / 3) * 2, image_exit_button:getWidth(), image_exit_button:getHeight()) then
        UpdateGameState("main_menu")
    end
    for i,entity in ipairs(entities_loaded) do
        if paused and not EntityHasTag(entity.eid, "pause_exempt") then return end
        local sprite_width = entity.sprite.width * entity.pos.scale_x
        local sprite_height = entity.sprite.height * entity.pos.scale_y
        if entity.hitbox_radius ~= nil then
            if DistanceBetween(mouse_x, mouse_y, entity.pos.x + (sprite_width / 2), entity.pos.y + (sprite_height / 2)) <= (entity.hitbox_radius * entity.pos.scale) then
                entity.func_on_click(entity, button)
            end
        else
            if CheckCollision(mouse_x, mouse_y, 0.1, 0.1, entity.pos.x + (sprite_width / 2), entity.pos.y + (sprite_height / 2), entity.hitbox.w, entity.hitbox.h) then
                entity.func_on_click(entity, button)
            end
        end
    end
end

function love.mousereleased(x, y, button, istouch, presses)
    if button == 1 then

    end
end

function love.keypressed(key, scancode, isrepeat)
    keystring = key
    if key == "escape" then
        paused = not paused
    end
    if key == "w" then
        local proj = EntityLoad("projectile_bullet", screen_width / 2, (screen_height / 8) * 7)
---@diagnostic disable-next-line: undefined-field
        proj.velocity.y = math.abs(proj.velocity.y) * -1
    end
end