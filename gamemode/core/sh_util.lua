minerva.util = minerva.util or {}

function minerva.util.Message(color, message)
    MsgC(minerva.config["color"], "[Minerva] ", color or color_white, tostring(message).."\n")
end

local realms = {
    ["cl"] = function(dir)
        if ( SERVER ) then
            AddCSLuaFile(dir)
            return
        end

        return include(dir)
    end,
    ["sh"] = function(dir)
        if ( SERVER ) then
            AddCSLuaFile(dir)
        end

        return include(dir)
    end,
    ["sv"] = function(dir)
        if ( CLIENT ) then
            return
        end

        return include(dir)
    end,
}
realms["client"] = realms["cl"]
realms["shared"] = realms["sh"]
realms["server"] = realms["sv"]

function minerva.util.Include(dir, realm)
    if not ( file.Exists(dir, "LUA") ) then
        return
    end

    if ( realms[realm] ) then
        return realms[realm](dir)
    end

    if ( dir:match("sh_") ) then
        return realms["sh"](dir)
    elseif ( dir:match("cl_") ) then
        return realms["cl"](dir)
    elseif ( dir:match("sv_") ) then
        return realms["sv"](dir)
    else
        return realms["sh"](dir)
    end
end

function minerva.util.IncludeDir(dir)
    local files, dirs = file.Find(dir .. "/*", "LUA")

    for k, v in ipairs(files) do
        minerva.util.Include(dir .. "/" .. v)
    end

    for k, v in ipairs(dirs) do
        minerva.util.IncludeDir(dir .. "/" .. v)
    end
end

minerva.util.materials = minerva.util.materials or {}
function minerva.util.GetMaterial(name, ...)
    if ( minerva.util.materials[name] ) then
        minerva.util.materials[name] = Material(name, ...)
    end

    return minerva.util.materials[name] or Material(name, ...)
end

function minerva.util.GetTextSize(text, font)
    surface.SetFont(font)
    return surface.GetTextSize(text)
end

function minerva.util.LerpColor(delta, start, finish)
    local c = Color(start.r, start.g, start.b, start.a)
    c.r = Lerp(delta, start.r, finish.r)
    c.g = Lerp(delta, start.g, finish.g)
    c.b = Lerp(delta, start.b, finish.b)
    c.a = Lerp(delta, start.a, finish.a)

    return c
end

function minerva.util.OpenVGUI(ui, ply)
    if ( SERVER ) then
        net.Start("minerva.OpenVGUI")
            net.WriteString(ui)
        net.Send(ply)
    else
        vgui.Create(ui)
    end
end

function minerva.util.GetAllCombine()
    local combine = {}

    for _, v in ipairs(player.GetAll()) do
        if ( v:Team() == FACTION_COMBINE ) then
            table.insert(combine, v)
        end
    end

    return combine
end

function minerva.util.GetAllRebels()
    local rebels = {}

    for _, v in ipairs(player.GetAll()) do
        if ( v:Team() == FACTION_LAMBDA ) then
            table.insert(rebels, v)
        end
    end

    return rebels
end

if ( CLIENT ) then
    local bMat = minerva.util.GetMaterial("pp/blurscreen")
    function minerva.util.DrawBlur(panel, amount, passes, alpha)
        amount = amount or 3

        surface.SetMaterial(bMat )
        surface.SetDrawColor(255, 255, 255, alpha or 255)

        local x, y = panel:LocalToScreen(0, 0)

        for i = -( 0.2 or passes ), 1, 0.2 do
            bMat:SetFloat("$blur", i * amount)
            bMat:Recompute()

            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRect(x * -1, y * -1, ScrW(), ScrH())
        end
    end
    
    function minerva.util.DrawBlurAt(x, y, w, h, amount, passes, alpha)
        amount = amount or 3

        surface.SetMaterial(bMat)
        surface.SetDrawColor(255, 255, 255, alpha or 255)

        local sW = ScrW()
        local sH = ScrH()

        local x2 = x / sW
        local y2 = y / sH

        local w2 = ( x + w ) / sW
        local h2 = ( y + h ) / sH

        for i = -( passes or 0.2 ), 1, 0.2 do
            bMat:SetFloat("$blur", i * amount)
            bMat:Recompute()

            render.UpdateScreenEffectTexture()
            surface.DrawTexturedRectUV(x, y, w, h, x2, y2, w2, h2)
        end
    end
end