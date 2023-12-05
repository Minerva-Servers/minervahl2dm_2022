minerva.fonts = minerva.fonts or {}
minerva.fonts.stored = minerva.fonts.stored or {}

function minerva.fonts.Register(name, data)
    surface.CreateFont(name, data)

    minerva.fonts.stored[name] = {
        name = name,
        data = data
    }
end

hook.Add("CreateFonts", "DefaultFonts", function()
    for i = 1, 15 do
        minerva.fonts.Register("Font-Elements"..i * 5, {
            font = "Futura Std Medium",
            size = i * 5,
            antialias = true,
        })

        minerva.fonts.Register("Font-Elements-Italic"..i * 5, {
            font = "Futura Std Medium",
            size = i * 5,
            antialias = true,
            italic = true,
        })

        minerva.fonts.Register("Font-Elements-Light"..i * 5, {
            font = "Futura Std Light",
            size = i * 5,
            antialias = true,
        })

        minerva.fonts.Register("Font-Elements-Lines"..i * 2, {
            font = "Futura Std Medium",
            size = i * 5,
            scanlines = 4,
        })

        minerva.fonts.Register("Font-Elements-ItalicLines"..i * 2, {
            font = "Futura Std Medium",
            size = i * 5,
            italic = true,
            scanlines = ScreenScale(1),
        })
    end

    for i = 3, 30 do
        minerva.fonts.Register("Font-Elements-ScreenScale"..i * 2, {
            font = "Futura Std Medium",
            size = ScreenScale(i * 2),
            antialias = true,
        })

        minerva.fonts.Register("Font-Elements-Italic-ScreenScale"..i * 2, {
            font = "Futura Std Medium",
            size = ScreenScale(i * 2),
            antialias = true,
            italic = true,
        })

        minerva.fonts.Register("Font-Elements-Light-ScreenScale"..i * 2, {
            font = "Futura Std Light",
            size = ScreenScale(i * 2),
            antialias = true,
        })

        minerva.fonts.Register("Font-Elements-Lines-ScreenScale"..i * 2, {
            font = "Futura Std Medium",
            size = ScreenScale(i * 2),
            scanlines = 4,
        })

        minerva.fonts.Register("Font-Elements-ItalicLines-ScreenScale"..i * 2, {
            font = "Futura Std Medium",
            size = ScreenScale(i * 2),
            italic = true,
            scanlines = ScreenScale(1),
        })
    end

    minerva.util.Message(Color(0, 255, 0), "Fonts Loaded.")
end)

concommand.Add("minerva_loadfonts", function()
    minerva.util.Message(Color(255, 255, 0), "Loading Fonts...")

    hook.Run("CreateFonts")
end)

concommand.Add("minerva_getfonts", function()
    minerva.util.Message(Color(0, 255, 0), "Stored Fonts:")

    for k, v in SortedPairs(minerva.fonts.stored) do
        minerva.util.Message(Color(0, 150, 150), k)
    end
end)