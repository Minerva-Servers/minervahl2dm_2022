local gradientUp = minerva.util.GetMaterial("vgui/gradient-u")

local PANEL = {}

function PANEL:Init()
    if ( IsValid(minerva.ui.information) ) then
        minerva.ui.information:Remove()
    end

    minerva.ui.information = self

    self:SetPos(0, -ScrH())
    self:SetSize(ScrW(), ScrH())
    self:MakePopup()

    self.bMoving = true
    self:MoveTo(0, 0, 0.5, 0, 0.75, function()
        self.bMoving = nil
    end)

    self.title = self:Add("DLabel")
    self.title:Dock(TOP)
    self.title:DockMargin(ScreenScale(16), ScreenScale(8), 0, 0)
    self.title:SetTextColor(color_white)
    self.title:SetText("Information")
    self.title:SetFont("Font-Elements-ScreenScale40")
    self.title:SizeToContents()

    self.returnButton = self:Add("minerva.Button")
    self.returnButton:SetText("Return")
    self.returnButton:SetFont("Font-Elements-ScreenScale18")
    self.returnButton:SetContentAlignment(4)
    self.returnButton:SetSize(self:GetWide(), ScreenScale(20))
    self.returnButton:SetPos(0, self:GetTall() - self.returnButton:GetTall())
    self.returnButton.DoClick = function(this)
        minerva.ui.menu:Show()

        self:Close()
    end

    self.container = self:Add("DPanel")
    self.container:Dock(FILL)
    self.container:DockMargin(ScreenScale(16), ScreenScale(8), ScreenScale(16), ScreenScale(32))
    self.container.Paint = function(this, width, height)
        surface.SetDrawColor(0, 0, 0, 80)
        surface.DrawRect(0, 0, width, height)
    end
end

function PANEL:Close()
    self.bMoving = true

    self:MoveTo(0, -ScrH(), 0.5, 0, 0.75, function()
        self:Remove()
    end)
end

local backgroundAlpha = 0
function PANEL:Paint(width, height)
    surface.SetDrawColor(ColorAlpha(color_black, backgroundAlpha))
    surface.SetMaterial(gradientUp)
    surface.DrawTexturedRect(0, 0, width, height)

    if ( self.bMoving or #minerva.ui.notificationTab.notifs >= 1 ) then
        backgroundAlpha = Lerp(0.1, backgroundAlpha, 0)
    else
        backgroundAlpha = Lerp(0.005, backgroundAlpha, 200)
    end

    surface.SetDrawColor(0, 0, 0, backgroundAlpha)
    surface.DrawRect(0, 0, width, height)

    minerva.util.DrawBlur(self, backgroundAlpha / 100, nil, backgroundAlpha)
end

vgui.Register("minerva.Information", PANEL, "EditablePanel")

if ( IsValid(minerva.ui.information) ) then
    minerva.ui.information:Remove()
end