function DistanceBetween(x1, y1, x2, y2)
    return math.sqrt(((x2 - x1)^2) + ((y2 - y1)^2))
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
        return true
    end
end
    return false
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
            table.remove(entities_loaded, i)
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