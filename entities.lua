dofile("utils.lua")

entities = {
    {
        eid = nil,
        id = "gui_text_begin",
        name = "",
        hp = -1,
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
        tags = { "player_soul" },
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
    },
}