minerva.notification = minerva.notification or {}

function minerva.notification.Notify(message, ply, color)
    net.Start("minerva.Notification.Notify")
        net.WriteString(message)
        net.WriteColor(color or color_white)
    net.Send(ply)
end