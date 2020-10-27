local _, nMainbar = ...

nMainbar.Config = {
    showPicomenu = true,
    miniBottomRightBar = true,
    moveableExtraActionButton = true,

    button = {
        useMasque = true,
        showVehicleKeybinds = true,
        showKeybinds = true,
        showMacroNames = false,
        buttonOutOfRange = false,
    },

    color = {   -- Red, Green, Blue, Alpha
        Normal =     CreateColor(1.0, 1.0, 1.0, 1.0),
        IsEquipped = CreateColor(0.0, 1.0, 0.0, 1.0),
        OutOfRange = CreateColor(0.8, 0.1, 0.1, 1.0),
        OutOfMana =  CreateColor(0.3, 0.3, 1.0, 1.0),
        NotUsable =  CreateColor(0.35, 0.35, 0.35, 1.0),

        HotKeyText = CreateColor(0.6, 0.6, 0.6, 1.0),
        MacroText =  CreateColor(1.0, 1.0, 1.0, 1.0),
        CountText =  CreateColor(1.0, 1.0, 1.0, 1.0),
    },

    MainMenuBar = {
        moveableExtraBars = true,
        showGryphons = true,
    },

    vehicleBar = {
        scale = 0.80,
    },

    ["petBar"] = {
        mouseover = false,
        scale = 0.75,
        hiddenAlpha = 0,
        alpha = 1,
        vertical = false,
    },

    ["stanceBar"] = {
        hide = false,
        mouseover = false,
        hiddenAlpha = 0.5,
        alpha = 1,
        scale = 1,
    },

    ["possessBar"] = {
        scale = 1,
        alpha = 1,
    },

    ["multiBarRight"] = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
    },

    ["multiBarLeft"] = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
    },

    ["multiBarBottomLeft"] = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
    },

    -- Requires miniBottomRightBar option.

    ["nMainbarActionBar"] = {
        mouseover = false,
        hiddenAlpha = 0,
        alpha = 1,
    },
}
