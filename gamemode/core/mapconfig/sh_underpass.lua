minerva.mapConfig["dm_underpass"] = {
    menuView = {
        origin = Vector(-550.36773681641, -167.60690307617, 228.65817260742),
        angles = Angle(-5.1920003890991, -53.06409072876, 0),
        fov = 60,
    },
    initPostEntity = function()
        for k, v in pairs(ents.FindByClass("item_*")) do
            SafeRemoveEntity(v)
        end

        for k, v in pairs(ents.FindByClass("weapon_*")) do
            SafeRemoveEntity(v)
        end
    end,
}