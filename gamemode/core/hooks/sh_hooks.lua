function GM:PlayerFootstep(ply, position, foot, soundName, volume)
    if ( SERVER ) then
        local extraSoundName = ""
        
        if ( ply:GetNWInt("faction") == FACTION_COMBINE ) then
            extraSoundName = "npc/combine_soldier/gear"..math.random(1, 6)..".wav"
        elseif ( ply:GetNWInt("faction") == FACTION_LAMBDA ) then
            extraSoundName = "minerva/hl2rp/footsteps/hardboot_generic"..math.random(1, 9)..".mp3"
        end

        if ( ply:KeyDown(IN_SPEED) ) then
            if not ( extraSoundName == "" ) then
                ply:EmitSound(extraSoundName, 80, math.random(90, 110))
            end

            ply:EmitSound(soundName, 80, math.random(90, 110))
        else
            ply:EmitSound(soundName, 70, math.random(90, 110))
        end
    end

    return true
end

function GM:EntityFireBullets(ent, data)
    if not ( IsValid(ent) and ent:IsPlayer() ) then
        return
    end

    ent:ViewPunch(Angle(-1, math.random(-1, 1), math.random(-1, 1)))
end