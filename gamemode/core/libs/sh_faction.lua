minerva.faction = minerva.faction or {}
minerva.faction.stored = minerva.faction.stored or {}

FACTION_COMBINE = 1
FACTION_LAMBDA = 2

CLASS_COMBINE_SOLDIER = 1
CLASS_COMBINE_SHOTGUNNER = 2
CLASS_LAMBDA_FIGHTER = 1
CLASS_LAMBDA_MARKSMAN = 2

minerva.faction.list = {
    [FACTION_COMBINE] = {
        uniqueID = FACTION_COMBINE,
        name = "Combine",
        color = Color(25, 125, 250),
        image = "minerva/combine.png",
        description = "The Combine is a massive empire spanning countless parallel universes and dimensions, and includes an unknown number of sentient species. The Combine's ultimate goal is to conquer and harness the entire multiverse. Details of the Combine's leadership and administrative structure remain unknown, as do whether they consist of an economy, or even a society that exists beyond the limits of human understanding.",
        weapons = "weapon_stunstick",
        model = "models/player/combine_soldier.mdl",
        classes = {
            [CLASS_COMBINE_SOLDIER] = {
                factionID = FACTION_COMBINE,
                name = "Combine Soldier",
                description = "",
                model = "models/player/combine_soldier.mdl",
                skin = 0,
                weapons = {
                    "weapon_smg1",
                },
            },
            [CLASS_COMBINE_SHOTGUNNER] = {
                factionID = FACTION_COMBINE,
                name = "Combine Shotgunner",
                description = "",
                model = "models/player/combine_soldier.mdl",
                skin = 1,
                weapons = {
                    "weapon_shotgun",
                },
            },
        },
    },
    [FACTION_LAMBDA] = {
        uniqueID = FACTION_LAMBDA,
        name = "Lambda",
        color = Color(250, 150, 50),
        image = "minerva/lambda.png",
        description = "The Resistance has no central command structure due to The Combine's method of controlling the populace, as it was made incredibly difficult to try and coordinate anything without being caught. However, there are numerous central figures in the resistance that are keeping small clusters across the cities organized.",
        weapons = "weapon_crowbar",
        model = {
            "models/player/group03/male_01.mdl",
            "models/player/group03/male_02.mdl",
            "models/player/group03/male_03.mdl",
            "models/player/group03/male_04.mdl",
            "models/player/group03/male_05.mdl",
            "models/player/group03/male_06.mdl",
            "models/player/group03/male_07.mdl",
            "models/player/group03/male_08.mdl",
            "models/player/group03/male_09.mdl",
        },
        classes = {
            [CLASS_LAMBDA_FIGHTER] = {
                factionID = FACTION_LAMBDA,
                name = "Lambda Fighter",
                description = "",
                model = {
                    "models/player/group03/male_01.mdl",
                    "models/player/group03/male_02.mdl",
                    "models/player/group03/male_03.mdl",
                    "models/player/group03/male_04.mdl",
                    "models/player/group03/male_05.mdl",
                    "models/player/group03/male_06.mdl",
                    "models/player/group03/male_07.mdl",
                    "models/player/group03/male_08.mdl",
                    "models/player/group03/male_09.mdl",
                },
                weapons = {
                    "weapon_smg1",
                },
            },
            [CLASS_LAMBDA_MARKSMAN] = {
                factionID = FACTION_LAMBDA,
                name = "Lambda Marskman",
                description = "",
                model = {
                    "models/player/group03/male_01.mdl",
                    "models/player/group03/male_02.mdl",
                    "models/player/group03/male_03.mdl",
                    "models/player/group03/male_04.mdl",
                    "models/player/group03/male_05.mdl",
                    "models/player/group03/male_06.mdl",
                    "models/player/group03/male_07.mdl",
                    "models/player/group03/male_08.mdl",
                    "models/player/group03/male_09.mdl",
                },
                weapons = {
                    "weapon_crossbow",
                },
            },
        },
    },
}

function minerva.faction.Initialize()
    for k, v in pairs(minerva.faction.list) do
        minerva.faction.stored[k] = v

        team.SetUp(k, v.name, v.color, false)

        minerva.util.Message(v.color, v.name.." Faction Loaded.")
    end
end