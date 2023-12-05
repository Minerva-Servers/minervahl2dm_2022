function GM:InitPostEntity()
    RunConsoleCommand("stopsound")

    minerva.util.OpenVGUI("minerva.MainMenu")
    minerva.util.OpenVGUI("minerva.NotificationTab")
end

function GM:CalcView(ply, origin, angles, fov)
    if ( IsValid(minerva.ui.menu) and minerva.mapConfig[game.GetMap()] and minerva.mapConfig[game.GetMap()].menuView ) then
        local view = {
            origin = minerva.mapConfig[game.GetMap()].menuView.origin,
            angles = minerva.mapConfig[game.GetMap()].menuView.angles,
            fov = minerva.mapConfig[game.GetMap()].menuView.fov or fov,
        }

        return view
    end
end

function GM:Think()
    if not ( LocalPlayer():Team() == 0 and vgui.CursorVisible() and IsValid(minerva.ui.menu) or minerva.ui.menu:IsVisible() ) then
        if ( input.IsKeyDown(KEY_F1) ) then
            minerva.util.OpenVGUI("minerva.MainMenu")
        end

        hook.Run("CheckMenuInput")
    end
end

local hidden = {}
hidden["CHudHealth"] = true
hidden["CHudBattery"] = true
hidden["CHudAmmo"] = true
hidden["CHudSecondaryAmmo"] = true
hidden["CHudCrosshair"] = true
hidden["CHudHistoryResource"] = true
hidden["CHudPoisonDamageIndicator"] = true
hidden["CHudSquadStatus"] = true
hidden["CHUDQuickInfo"] = true

function GM:HUDShouldDraw(element)
    if ( IsValid(minerva.ui.menu) ) then
        return
    end

    if ( hidden[element] ) then
        return false
    end

    return true
end

local scrW, scrH = ScrW(), ScrH()
local damageOverlay = minerva.util.GetMaterial("minerva/screendamage.png")
local vignette1 = minerva.util.GetMaterial("minerva/vignette.png")
local vignette2 = minerva.util.GetMaterial("minerva/vignette_cw.png")
local function DrawPlayerScreenDamage(ply, damageFraction)
    surface.SetDrawColor(255, 0, 0, math.Clamp(255 * damageFraction, 0, 255))
    surface.SetMaterial(vignette2)
    surface.DrawTexturedRect(0, 0, scrW, scrH)

    surface.SetDrawColor(255, 255, 255, math.Clamp(255 * damageFraction, 0, 255))
    surface.SetMaterial(damageOverlay)
    surface.DrawTexturedRect(0, 0, scrW, scrH)
end

local function DrawPlayerVignette()
    surface.SetDrawColor(0, 0, 0, 240)
    surface.SetMaterial(vignette1)
    surface.DrawTexturedRect(0, 0, scrW, scrH)

    surface.SetDrawColor(0, 0, 0, 240)
    surface.SetMaterial(vignette2)
    surface.DrawTexturedRect(0, 0, scrW, scrH)
end

function GM:HUDPaintBackground()
    local ply = LocalPlayer()

    if not ( IsValid(ply) ) then
        return
    end

    if ( ply:Alive() ) then
        local maxHealth = ply:GetMaxHealth()
        local health = ply:Health()
        
        if ( health < maxHealth ) then
            DrawPlayerScreenDamage(ply, 1 - ((1 / maxHealth) * health))
        end
    else
        return
    end

    DrawPlayerVignette()
end

function GM:HUDPaint()
    local ply = LocalPlayer()

    if not ( IsValid(ply) and ply:Alive() ) then
        return
    end

    local factionTable = ply:GetFactionTable()
    local fontElement = "Font-Elements-Italic-"
    if ( factionTable.uniqueID == FACTION_COMBINE ) then
        fontElement = "Font-Elements-ItalicLines-"
    end

    draw.DrawText("HEALTH", fontElement.."ScreenScale14", 20, ScrH() - ScreenScale(14) - ScreenScale(40), factionTable.color)
    draw.DrawText(ply:Health(), fontElement.."ScreenScale40", 20, ScrH() - 20 - ScreenScale(40), factionTable.color)
    
    draw.DrawText("Combine: "..#minerva.util.GetAllCombine(), fontElement.."ScreenScale40", 20, 20, team.GetColor(FACTION_COMBINE), TEXT_ALIGN_LEFT)
    draw.DrawText("Lambda: "..#minerva.util.GetAllRebels(), fontElement.."ScreenScale40", 20, 20 + ScreenScale(40), team.GetColor(FACTION_LAMBDA), TEXT_ALIGN_LEFT)
end

function GM:ScoreboardShow()
    if ( LocalPlayer():Team() == 0 ) then
        return
    end
    
    minerva.util.OpenVGUI("minerva.Scoreboard")
end

function GM:ScoreboardHide()
    if ( LocalPlayer():Team() == 0 ) then
        return
    end
    
    if ( IsValid(minerva.ui.scoreboard) ) then
        minerva.ui.scoreboard:Remove()
    end
end