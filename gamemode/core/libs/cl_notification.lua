minerva.notification = minerva.notification or {}

function minerva.notification.Notify(message, _, color)
    if ( IsValid(minerva.ui.notificationTab) ) then
        minerva.ui.notificationTab:AddNotification(message, nil, color)
    end
end