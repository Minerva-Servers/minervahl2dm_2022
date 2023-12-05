function GM:PlayerInitialSpawn(ply)
    ply:KillSilent()
end

function GM:PlayerHurt(ply)
    if ( ply:Team() == FACTION_COMBINE ) then
        ply:EmitSound("npc/combine_soldier/pain"..math.random(1, 3)..".wav", 70)
    elseif ( ply:Team() == FACTION_LAMBDA ) then
        ply:EmitSound("vo/npc/male01/pain0"..math.random(1, 9)..".wav", 70)
    end
end

function GM:GetGameDescription()
    return "Minerva: "..GAMEMODE.Name
end

function GM:SetupPlayerVisibility(ply, viewEntity)
    local mapConfig = minerva.mapConfig[game.GetMap()]

    if ( ply.bInMainMenu and mapConfig and mapConfig.menuView ) then
        AddOriginToPVS(mapConfig.menuView.origin)
    end
end

function GM:InitPostEntity()
    local mapConfig = minerva.mapConfig[game.GetMap()]

    if ( mapConfig and mapConfig.initPostEntity ) then
        mapConfig.initPostEntity()
    end
end

function GM:CanPlayerSuicide()
    return false
end

function GM:PlayerShouldTakeDamage(ply, attacker)
    if ( attacker:Team() == ply:Team() ) then
        return false
    else
        return true
    end
end

function GM:PlayerSwitchFlashlight()
    return true
end

function GM:PlayerSpray()
    return true
end

function GM:GetFallDamage(ply, speed)
    return speed / 8
end

function GM:OnDamagedByExplosion()
    return true
end

function GM:DoPlayerDeath(ply)
end

function GM:PlayerDeath(ply)
    timer.Simple(1, function()
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
    end)
end

function GM:ScalePlayerDamage(ply, hitgroup, dmginfo)
    local attacker = dmginfo:GetAttacker()
    if ( attacker:IsPlayer() ) then
        dmginfo:ScaleDamage(2)

        if ( attacker:GetActiveWeapon() and attacker:GetActiveWeapon():GetClass() == "weapon_shotgun" ) then
            dmginfo:ScaleDamage(2)
        end

        if ( attacker:GetActiveWeapon() and attacker:GetActiveWeapon():GetClass() == "weapon_ar2" ) then
            dmginfo:ScaleDamage(2)
        end

        if ( attacker:GetActiveWeapon() and attacker:GetActiveWeapon():GetClass() == "weapon_crossbow" ) then
            dmginfo:ScaleDamage(2)
        end
    end
end