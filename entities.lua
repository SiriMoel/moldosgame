entities = {
    {
        eid = nil,
        id = "player_soul",
        name = "Player Soul",
        hp = 100,
        tags = { "player_soul" },
        sprite = {
            file = "sprites/player_soul.png",
            width = 30,
            height = 30,
        },
        hitbox_radius = 50,
        pos = {
            x = nil,
            y = nil,
            r = 0,
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
    }
}