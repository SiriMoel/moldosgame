dofile("utils.lua")

--[[

types
- attack: has a projectile table
- defense: 
- self:
- modifier: has a modifier table, a func_on_used, and a func_every_frame, use next > 0
- multicast: use_next > 1

damage types: projectile, slice, fire, poison, electricity

]]

cards_all = {
    {
        id = "bullet",
        name = "Bullet",
        desc = "Shoot a projectile",
        type = "attack",
        sprite = "gfx/cards/bullet.png",
        cooldown = 1, -- 1 turn cooldown, cooldowns are reduced at start of turn
        use_next = 0,
        projectile = {
            entity = "projectile_bullet",
            count = 1,
        },
        func_drawn = function(card) end,
    },
}

cards_deck_player = {} -- between 10 and 20 cards
cards_deck_enemy = {}

cards_hand_player = {} -- 5 cards
cards_hand_enemy = {}

cards_barrel_player = {} -- up to 5, this is what gets 'shot' at the end of the turn
cards_barrel_enemy = {}