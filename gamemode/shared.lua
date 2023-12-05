// gonna be real here, most of this stuff is taken from corpoware because im lazy, lel...

ENTITY = FindMetaTable("Entity")
PLAYER = FindMetaTable("Player")

DeriveGamemode("base")

GM.Name = "Half-Life 2 Deathmatch"
GM.Author = "Minerva Servers"
GM.Description = "A light weight deathmatch gamemode for Minerva Servers."

minerva.config = minerva.config or {}
minerva.config["color"] = Color(40, 140, 240)
minerva.config["discord"] = "https://discord.gg/dnXSHNBwbP"
minerva.config["walkSpeed"] = 100
minerva.config["runSpeed"] = 200
minerva.config["notificationSound"] = "buttons/blip1.wav"

minerva.util.Message(Color(255, 255, 0), "Loading Core...")

minerva.util.IncludeDir(GM.FolderName.."/gamemode/core/hooks")
minerva.util.IncludeDir(GM.FolderName.."/gamemode/core/libs")
minerva.util.IncludeDir(GM.FolderName.."/gamemode/core/mapconfig")
minerva.util.IncludeDir(GM.FolderName.."/gamemode/core/meta")
minerva.util.IncludeDir(GM.FolderName.."/gamemode/core/net")
minerva.util.IncludeDir(GM.FolderName.."/gamemode/core/vgui")

minerva.modules.IncludeDir(GM.FolderName.."/gamemode/modules")

minerva.faction.Initialize()

hook.Run("CreateFonts")

minerva.util.Message(Color(0, 255, 0), "Core Loaded.")