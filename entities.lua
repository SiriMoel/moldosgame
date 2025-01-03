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
        id = "gui_text_battle",
        name = "",
        hp = nil,
        tags = { "gui", "render_shape_on_hover", },
        sprite = {
            file = "gfx/gui/text_battle.png",
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
                UpdateGameState("in_round")
                BeginRound()
            end
        end,
        func_every_frame = function(entity)
            entity.pos.x = (screen_width / 5)
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
        hitbox_radius = 30,
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
            entity.pos.x = screen_width / 2
            entity.pos.y = (screen_height / 7) * 6
        end,
        func_on_death = function(entity)

        end,
    },
    {
        eid = nil,
        id = "enemy_soul",
        name = "Enemy Soul",
        hp = 1,
        tags = { "enemy_soul", "game_target", "render_shape_on_hover" },
        sprite = {
            file = "gfx/entities/enemy_soul.png",
            width = 30,
            height = 30,
        },
        hitbox_radius = 30,
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
            entity.pos.x = screen_width / 2
            entity.pos.y = (screen_height / 9)
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
            eid_who_shot = nil,
            damage_types = {
                projectile = 5,
            }
        },
        func_on_hover = function(entity)
            
        end,
        func_on_click = function(entity, button)

        end,
        func_every_frame = function(entity)
            keystring = EntityGet(entity.proj.eid_who_shot).name
            if not IsCoordsOnScreen(entity.pos.x, entity.pos.y) then
                EntityKill(entity.eid)
            end
            local targets = EntityGetAllWithTag("game_target")
            for i=1,#targets do
                local target = targets[i]
                if entity.proj.entity_who_shot ~= target.eid then
                    if DistanceBetween(entity.pos.x, entity.pos.y, target.pos.x, target.pos.y) <= (target.hitbox_radius * target.pos.scale) then
                        keystring = tostring(target.hp)
                        for i=1,#entity.proj.damage_types do
                            local damage = entity.proj.damage_types[i]
                            target.hp = target.hp - damage
                            EntityKill(entity.eid)
                        end
                    end
                end
            end
        end,
    },
}