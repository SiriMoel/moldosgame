dofile("utils.lua")

--[[

types
- attack: has a projectile table
- defense:
- self:
- modifier:

damage types: projectile, slice, fire, poison, electricity

]]

cards_all = {
    {
        id = "bullet",
        name = "Bullet",
        desc = "Shoot a projectile forward",
        type = "attack",
        cooldown = 1, -- 1 turn cooldown, cooldowns are reduced at start of turn
        projectile = {
            vel_x = 0,
            vel_y = 100,
            damage = {
                projectile = 5,
            },
        },
        func_init = function(entity_this, entity_played) end,
        func_on_hit = function(entity_this, entity_hit, entity_played)
            -- entity_this: this entity
            -- entity_hit: the hit entity
            -- entity_played: the entity that played this card
        end,
        func_mid_flight = function(entity_this, entity_played) end,
    },
}

cards_player = {}

cards_deck = {} -- up to 30 cards

cards_hand = {} -- 5 cards