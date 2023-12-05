function PLAYER:Notify(message)
    minerva.notification.Notify(message, self)
end

function PLAYER:OpenVGUI(ui)
    minerva.util.OpenVGUI(ui, self)
end

function PLAYER:GetFactionTable()
    return minerva.faction.stored[self:Team()]
end

function PLAYER:GetClassTable()
    return minerva.faction.stored[self:Team()].classes[self:GetNWInt("class", 1)]
end