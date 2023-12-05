local gradientUp = minerva.util.GetMaterial("vgui/gradient-u")

local PANEL = {}

function PANEL:Init()
    if ( IsValid(minerva.ui.menu) ) then
        minerva.ui.menu:Remove()
    end

    minerva.ui.menu = self
    
    surface.PlaySound("music/stingers/hl1_stinger_song16.mp3")

    self:SetPos(0, -ScrH())
    self:SetSize(ScrW(), ScrH())
    self:MakePopup()

    self.bMoving = true
    self:MoveTo(0, 0, 1, 1, 0.75, function()
        self.bMoving = nil
    end)

    net.Start("minerva.EnterMainMenu")
    net.SendToServer()

    self.title = self:Add("DLabel")
    self.title:Dock(TOP)
    self.title:DockMargin(ScreenScale(16), ScreenScale(8), 0, 0)
    self.title:SetTextColor(color_white)
    self.title:SetText(GAMEMODE.Author)
    self.title:SetFont("Font-Elements-ScreenScale40")
    self.title:SizeToContents()

    self.subTitle = self:Add("DLabel")
    self.subTitle:Dock(TOP)
    self.subTitle:DockMargin(ScreenScale(32), 0, 0, 0)
    self.subTitle:SetTextColor(minerva.config["color"])
    self.subTitle:SetText(GAMEMODE.Name)
    self.subTitle:SetFont("Font-Elements-ScreenScale26")
    self.subTitle:SizeToContents()

    self.buttonList = self:Add("DScrollPanel")
    self.buttonList:SetWide(ScrW() / 4)
    self.buttonList:Dock(LEFT)
    self.buttonList:DockMargin(ScreenScale(16), ScreenScale(32), ScreenScale(8), ScreenScale(16))
    self.buttonList.Paint = function(this, width, height)
    end

    local buttons = {
        {
            text = "Play",
            color = nil,
            func = function(this)
                if not ( LocalPlayer():Team() != 0 and LocalPlayer():GetNWInt("class", 0) != 0 ) then
                    minerva.notification.Notify("Please select a faction and a class first!")
                    return
                end

                self:Close(function()
                    net.Start("minerva.Play")
                    net.SendToServer()

                    LocalPlayer().isPlaying = true
                end)
            end
        },
        {
            text = "Return",
            color = nil,
            func = function(this)
                if not ( LocalPlayer():Team() != 0 and LocalPlayer():GetNWInt("class", 0) != 0 ) then
                    minerva.notification.Notify("You are not in the game currently!")
                    return
                end

                self:Close()
            end
        },
        {
            text = "Switch Faction",
            color = nil,
            func = function(this)
                vgui.Create("minerva.Factions")

                self:Hide()
            end
        },
        {
            text = "Switch Class",
            color = nil,
            func = function(this)
                vgui.Create("minerva.Classes")

                self:Hide()
            end
        },
        {
            text = "Settings",
            color = nil,
            func = function(this)
                minerva.notification.Notify("Sorry, this is not a feature currently!")
                --vgui.Create("minerva.Settings")

                --self:Hide()
            end
        },
        {
            text = "Information",
            color = nil,
            func = function(this)
                vgui.Create("minerva.Information")

                self:Hide()
            end
        },
        {
            text = "Discord",
            color = minerva.config["color"],
            func = function(this)
                gui.OpenURL(minerva.config["discord"])
            end
        },
        {
            text = "Disconnect",
            color = Color(255, 0, 0),
            func = function(this)
                self:Close(function()
                    RunConsoleCommand("disconnect")
                end)
            end
        },
    }
    for k, v in SortedPairs(buttons) do
        local button = self.buttonList:Add("minerva.Button")
        button:SetText(v.text)
        button:SetFont("Font-Elements-ScreenScale16")
        button:SetTextColor(v.color or color_white)
        button:SetTall(ScreenScale(18))
        button:Dock(TOP)
        button.insetColor = v.color or nil
        button.bTextInsetMove = true
        button.DoClick = v.func
    end
end

function PANEL:Hide()
    self.bMoving = true
    self:MoveTo(0, ScrH(), 0.5, 0, 0.75, function()
        self.bMoving = nil
        self.bHidden = true
    end)
end

function PANEL:Show()
    self.bMoving = true
    self:MoveTo(0, 0, 0.5, 0, 0.75, function()
        self.bMoving = nil
        self.bHidden = nil
    end)
end

function PANEL:Close(func)
    self.bMoving = true

    net.Start("minerva.PreExitMainMenu")
    net.SendToServer()

    self:MoveTo(0, ScrH(), 1, 0, 0.75, function()
        net.Start("minerva.ExitMainMenu")
        net.SendToServer()
        
        self:Remove()

        if ( func ) then
            func()
        end
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

vgui.Register("minerva.MainMenu", PANEL, "EditablePanel")

if ( IsValid(minerva.ui.menu) ) then
    vgui.Create("minerva.MainMenu")
end