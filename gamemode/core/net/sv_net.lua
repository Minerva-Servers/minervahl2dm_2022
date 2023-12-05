util.AddNetworkString("minerva.OpenVGUI")
util.AddNetworkString("minerva.EnterMainMenu")
util.AddNetworkString("minerva.PreExitMainMenu")
util.AddNetworkString("minerva.ExitMainMenu")
util.AddNetworkString("minerva.Notification.Notify")
util.AddNetworkString("minerva.Play")
util.AddNetworkString("minerva.SelectFaction")
util.AddNetworkString("minerva.SelectClass")

net.Receive("minerva.EnterMainMenu", function(len, ply)
    ply.bInMainMenu = true

    ply:ScreenFade(SCREENFADE.IN, color_black, 10, 1)
end)

net.Receive("minerva.PreExitMainMenu", function(len, ply)
    ply:ScreenFade(SCREENFADE.OUT, color_black, 0.5, 0.5)
end)

net.Receive("minerva.ExitMainMenu", function(len, ply)
    ply.bInMainMenu = nil
end)

net.Receive("minerva.Play", function(len, ply)
    ply:StripAmmo()
    ply:StripWeapons()
    ply:Spawn()

    local model = ply:GetClassTable() and ply:GetClassTable().model or ply:GetFactionTable() and ply:GetFactionTable().model
    if ( istable(model) ) then
        ply:SetModel(table.Random(model))
    else
        ply:SetModel(model)
    end

    local skin = ply:GetClassTable() and ply:GetClassTable().skin or ply:GetFactionTable() and ply:GetFactionTable().skin
    ply:SetSkin(skin or 0)

    local weapons = ply:GetClassTable() and ply:GetClassTable().weapons
    if ( weapons ) then
        for k, v in pairs(weapons) do
            ply:Give(v)
        end
    end
    
    if ( ply:GetFactionTable().weapons ) then
        ply:Give(ply:GetFactionTable().weapons)
    end

    ply:GiveAmmo(99999, "smg1")
    ply:GiveAmmo(99999, "buckshot")
    ply:GiveAmmo(99999, "XBowBolt")

    ply:SetupHands()

    ply.isPlaying = true
end)

net.Receive("minerva.SelectFaction", function(len, ply)
    local uniqueID = net.ReadUInt(8)
    ply:SetTeam(uniqueID)

    local factionTable = minerva.faction.stored[ply:Team()]
    minerva.notification.Notify("You have selected the "..factionTable.name.." Faction!", ply, factionTable.color)
end)

net.Receive("minerva.SelectClass", function(len, ply)
    local uniqueID = net.ReadUInt(8)
    ply:SetNWInt("class", uniqueID)

    local classTable = minerva.faction.stored[ply:Team()].classes[ply:GetNWInt("class")]
    minerva.notification.Notify("You have selected the "..classTable.name.." Class!", ply, classTable.color)
end)