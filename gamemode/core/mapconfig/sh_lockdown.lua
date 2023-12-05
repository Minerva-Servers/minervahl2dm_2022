minerva.mapConfig["dm_lockdown"] = {
    menuView = {
        origin = Vector(-2804.2163085938, 4997.2368164063, 208.98585510254),
        angles = Angle(3.4320034980774, -122.75183105469, 0),
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