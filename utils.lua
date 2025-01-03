function DistanceBetween(x1, y1, x2, y2)
    return math.sqrt(((x2 - x1)^2) + ((y2 - y1)^2))
end

function IsCoordsOnScreen(x, y)
    local screen_left = 0
    local screen_top = 0
    local screen_bottom = screen_top + love.graphics.getHeight()
    local screen_right = screen_left + love.graphics.getWidth()
    if x > screen_left and x < screen_right and y > screen_top and y < screen_bottom then
        return true
    end
    return false
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
    end
end
    return false
end

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and x2 < x1+w1 and y1 < y2+h2 and y2 < y1+h1
end

function EntityLoad(id, x, y) -- hehe nolla games
    local entity = {}
    for i,v in ipairs(entities) do
        if v.id == id then
            entity = v
            break
        end
    end
    entity.eid = eid_upto
    eid_upto = eid_upto + 1
    entity.pos.x = x
    entity.pos.y = y
    table.insert(entities_loaded, entity)
    return entity
end

function EntityGet(eid)
    for i,entity in ipairs(entities_loaded) do
        if entity.eid == eid then
            return entity
        end
    end
end

function EntityKill(eid)
    for i,entity in ipairs(entities_loaded) do
        if entity.eid == eid then
            entity.remove = true
            entities_loaded[i] = nil
            entity = nil
            table.remove(entities_loaded, i)
            break
        end
    end
end

function EntityHasTag(eid, tag)
    if table.contains(EntityGet(eid).tags, tag) then
        return true
    else
        return false
    end
end

function EntityGetAllWithTag(tag)
    local targets = {}
    for i,entity in ipairs(entities_loaded) do
        if table.contains(entity.tags, tag) then
            table.insert(targets, entity)
        end
    end
    return targets
end

function UpdateGameState(state)
    for i,entity in ipairs(entities_loaded) do
        EntityKill(entity.eid)
    end
    game_state = state
    if game_state == "main_menu" then
        entity_start_game_text = EntityLoad("gui_text_begin", screen_width / 2, (screen_height / 8) * 5)
    end

    if game_state == "main" then
        entity_start_round_text = EntityLoad("gui_text_battle", 0, 0)
    end

    if game_state == "in_round" then
        
    end
end

function BeginRound()
    player_soul = EntityLoad("player_soul", screen_width / 2, (screen_height / 7) * 5)
    enemy_soul = EntityLoad("enemy_soul", screen_width / 2, (screen_height / 9))
end

function ShootProjectile(projectile_entity, eid_who_shot, x, y, vel_x_mult, vel_y_mult, shoot_location)
    local proj = EntityLoad(projectile_entity, x, y)
    proj.proj.entity_who_shot = eid_who_shot
    proj.velocity.x = proj.velocity.x * vel_x_mult
    proj.velocity.y = proj.velocity.y * vel_y_mult
    if shoot_location == "bottom" then
        proj.velocity.y = math.abs(proj.velocity.y) * -1
    end
    if shoot_location == "top" then
        proj.velocity.y = math.abs(proj.velocity.y)
    end
end

function GetSoulsCount(type, tier_number) -- is this even necessary
    for i,soul in ipairs(soul_types) do
        if soul.soul == type and soul.tier_number == tier_number then
            return soul.count
        end
    end
end

function AddSouls(type, tier_number, amount)
    for i,soul in ipairs(soul_types) do
        if soul.soul == type and soul.tier_number == tier_number then
            soul.count = soul.count + amount
            if soul.count < 0 then soul.count = 0 end
        end
    end
end