dofile("utils.lua")

--[[

game_target entities & projectiles must use circular hitbox

]]

entities = {
    {
        eid = nil,
        id = "gui_text_begin",
        name = "",
        hp = nil,
        tags = { "gui", "render_shape_on_hover", },
        sprite = {
            file = "gfx/gui/text_begin.png",
            width = 24,
            height = 24,
        },
        hitbox_radius = 11,
        --[[hitbox = {
            w = 10,
            h = 10,
        },]]
        pos = {
            x = nil,
            y = nil,
            r = 0,
            scale = 4,
            scale_x = 4,
            scale_y = 4,
        },
        velocity = {
            x = 0,
            y = 0,
        },
        colliding_with_mouse = false,
        func_on_hover = function(entity)
            
        end,
        func_on_click = function(entity, button)
            if button == 1 then
                UpdateGameState("main")
            end
        end,
        func_every_frame = function(entity) 
            entity.pos.x = screen_width / 2
            entity.pos.y = (screen_height / 8) * 5
        end,
    },
    {
        eid = nil,
        id = "player_soul",
        name = "Player Soul",
        hp = 100,
        tags = { "player_soul", "game_target" },
        sprite = {
            file = "gfx/entities/player_soul.png",
            width = 30,
            height = 30,
        },
        hitbox_radius = 50,
        pos = {
            x = nil,
            y = nil,
            r = 0,
            scale = 4,
            scale_x = 4,
            scale_y = 4,
        },
        velocity = {
            x = 0,
            y = 0,
        },
        colliding_with_mouse = false,
        func_on_hover = function(entity)
            --EntityLoad(entity.id, entity.pos.x + 60, entity.pos.y)
            --EntityKill(entity.eid)
        end,
        func_on_click = function(entity, button)

        end,
        func_every_frame = function(entity)
            
        end,
        func_on_death = function(entity)

        end,
    },
    {
        eid = nil,
        id = "projectile_bullet",
        name = "Bullet",
        hp = 1,
        tags = { "projectile" },
        sprite = {
            file = "gfx/entities/bullet.png",
            width = 2,
            height = 2,
        },
        hitbox_radius = 2,
        pos = {
            x = nil,
            y = nil,
            r = 0,
            scale = 4,
            scale_x = 4,
            scale_y = 4,
        },
        velocity = {
            x = 0,
            y = 5,
        },
        colliding_with_mouse = false,
        proj = {
            damage_types = {
                projectile = 5,
            }
        },
        func_on_hover = function(entity)
            
        end,
        func_on_click = function(entity, button)

        end,
        func_every_frame = function(entity)
            if not IsCoordsOnScreen(entity.pos.x, entity.pos.y) then
                EntityKill(entity.eid)
            end
            for i,target in ipairs(EntityGetAllWithTag("game_target")) do
                if DistanceBetween(entity.pos.x, entity.pos.y, target.pos.x, target.pos.y) <= target.hitbox_radius then
                    for i,damage in ipairs(entity.proj.damage_types) do
                        target.hp = target.hp - damage
                    end
                end
            end
        end,
    },
}