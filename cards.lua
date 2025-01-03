dofile("utils.lua")
require 'globals'

---@alias Card BaseCard|AttackCard|DefenseCard|ModifierCard

---@class BaseCard
---@field id string
---@field name string
---@field desc string
---@field type CardType
---@field sprite string,
---@field cooldown integer
---@field use_next integer

---@class AttackCard: BaseCard
---@field projectile table

---@class DefenseCard: BaseCard

---@class ModifierCard: BaseCard
---@field modifier table,
---@field func_on_used fun()
---@field func_every_frame fun()

---@class MulticastCard: BaseCard


---@type Card[]
cards_all = {
    {
        id = "bullet",
        name = "Bullet",
        desc = "Shoot a projectile",
        type = CardType.ATTACK,
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

---@type Card[]
cards_deck_player = {} -- between 10 and 20 cards

---@type Card[]
cards_deck_enemy = {}

---@type Card[]
cards_hand_player = {} -- 5 cards

---@type Card[]
cards_hand_enemy = {}

---@type Card[]
cards_barrel_player = {} -- up to 5, this is what gets 'shot' at the end of the turn

---@type Card[]
cards_barrel_enemy = {}