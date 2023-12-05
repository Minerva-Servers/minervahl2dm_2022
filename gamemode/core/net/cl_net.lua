net.Receive("minerva.OpenVGUI", function()
    local ui = net.ReadString()

    vgui.Create(ui)
end)

net.Receive("minerva.Notification.Notify", function()
    local message = net.ReadString()
    local color = net.ReadColor()

    minerva.notification.Notify(message, _, color)
end)