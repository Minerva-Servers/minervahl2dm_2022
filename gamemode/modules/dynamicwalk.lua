local MODULE = MODULE

MODULE.name = "Minerva Servers Dynamic Walk"
MODULE.description = ""
MODULE.author = "Reece™"

if ( CLIENT ) then
    return
end

function MODULE:Move(ply, mv)
    local walkSpeed = minerva.config["walkSpeed"]
    local runSpeed = minerva.config["runSpeed"]

    ply:SetDuckSpeed(0.4)
    ply:SetUnDuckSpeed(0.4)
    ply:SetSlowWalkSpeed(70)
    ply:SetCrouchedWalkSpeed(0.7)

    if ( ( ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) ) and ply:KeyDown(IN_MOVELEFT) ) then
        walkSpeed = walkSpeed - 10
        runSpeed = runSpeed - 15
    elseif ( ( ply:KeyDown(IN_FORWARD) or ply:KeyDown(IN_BACK) ) and ply:KeyDown(IN_MOVERIGHT) ) then
        walkSpeed = walkSpeed - 10
        runSpeed = runSpeed - 15
    elseif ( ply:KeyDown(IN_FORWARD) and not ( ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) ) ) then
        walkSpeed = walkSpeed
        runSpeed = runSpeed
    elseif ( ply:KeyDown(IN_MOVELEFT) or ply:KeyDown(IN_MOVERIGHT) ) then
        walkSpeed = walkSpeed - 5
        runSpeed = runSpeed - 10
    elseif ( ply:KeyDown(IN_BACK) ) then
        walkSpeed = walkSpeed - 20
        runSpeed = runSpeed - 20
    end

    ply:SetWalkSpeed(walkSpeed)
    ply:SetRunSpeed(runSpeed)
end