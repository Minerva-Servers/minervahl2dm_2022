minerva.modules = minerva.modules or {}
minerva.modules.list = minerva.modules.list or {}

_hookCache = _hookCache or {}

function minerva.modules.Get(name)
	if ( minerva.modules.list[name] ) then
		return minerva.modules.list[name]
	end

	for k, v in pairs(minerva.modules.list) do
		if ( v.name == name ) then
			return v
		end
	end
end

function minerva.modules.IncludeDir(dir)
	local files, dirs = file.Find(dir.."/*", "LUA")

	MODULE = {}
	for k, v in ipairs(files) do
		local niceName = string.StripExtension(v)

		MODULE.path = dir
		minerva.util.Include(dir.."/"..v)

		minerva.modules.list[niceName] = table.Copy(MODULE)

		MODULE = {}
	end

	for k, v in ipairs(dirs) do
		MODULE.path = dir.."/"..v

		if not ( file.Exists(dir.."/"..v.."/sh_plugin.lua") ) then
			ErrorNoHalt("sh_plugin.lua for plugin %s does not exist", v)
			continue
		end

		minerva.util.Include(dir.."/"..v.."/sh_plugin.lua")
		minerva.util.IncludeDir(dir.."/"..v.."/libs")
		minerva.util.IncludeDir(dir.."/"..v.."/vgui")

		minerva.modules.list[v] = MODULE

		MODULE = {}
	end

	MODULE = nil

	minerva.modules.CacheHooks()
end

function minerva.modules.CacheHooks()
	_hookCache = {}
	for k, v in pairs(minerva.modules.list) do
		for k2, v2 in pairs(v) do
			if not ( isfunction(v2) ) then
				continue
			end

			_hookCache[k2] = _hookCache[k2] or {}
			_hookCache[k2][v] = v2
		end
	end
end

hook.minervaCall = hook.minervaCall or hook.Call

function hook.Call(name, gm, ...)
	local hooks = _hookCache[name]

	if ( hooks ) then
		for k, v in pairs(hooks) do
			local a, b, c, d, e, f = v(k, ...)

			if ( a != nil ) then
				return a, b, c, d, e, f
			end
		end
	end

	return hook.minervaCall( name, gm, ... )
end