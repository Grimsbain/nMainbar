local _, nMainbar = ...
local cfg = nMainbar.Config

local ActionBars = {
	"ActionButton",
	"MultiBarBottomLeftButton",
	"MultiBarBottomRightButton",
	"MultiBarLeftButton",
    "MultiBarRightButton",
    "nMainbarActionBarButton",
}

nMainbarMixin = {}

function nMainbarMixin:OnLoad()
    self:RegisterEvent("PLAYER_LOGIN")

    self:SetGryphons(cfg.MainMenuBar.showGryphons)
    self:SetVehicleScale(cfg.vehicleBar.scale)
    self:SetupExtrabars()
    self:SetupMouseoverFrames()

    RegisterNewSlashCommand(self.ToggleGM, "gm", "ticket")
end

function nMainbarMixin:OnEvent(event, ...)
    if ( event == "PLAYER_LOGIN" ) then
        -- local bagBinding = GetBindingKey("NBAGS_TOGGLE") or "ALT-CTRL-B"
        -- -- SetBinding(bagBinding, "NBAGS_TOGGLE")
        self:UpdateHotkeys()
    end
end

function nMainbarMixin:SetGryphons(shouldShow)
    if ( shouldShow ) then
        MainMenuBarArtFrame.LeftEndCap:SetTexCoord(0, 1, 0, 1)
        MainMenuBarArtFrame.RightEndCap:SetTexCoord(1, 0, 0, 1)
    else
        MainMenuBarArtFrame.LeftEndCap:SetTexCoord(0, 0, 0, 0)
        MainMenuBarArtFrame.RightEndCap:SetTexCoord(0, 0, 0, 0)
    end
end

function nMainbarMixin:SetVehicleScale(scale)
    OverrideActionBar:SetScale(scale)
end

function nMainbarMixin:ToggleGM()
    ToggleHelpFrame()
end

function nMainbarMixin:UpdateHotkeys()
    for _, actionBar in ipairs(ActionBars) do
        for i = 1, NUM_ACTIONBAR_BUTTONS do
            local button = _G[actionBar..i]
            if ( button ) then
                button:UpdateHotkeys(button.buttonType)
            end
        end
    end
end

function nMainbarMixin:SetupMouseoverFrames()
    local mouseoverData = {
        ["petBar"] = {
            frame = PetActionBarFrame,
            buttonName = "PetActionButton",
            maxButtons = NUM_PET_ACTION_SLOTS,
            minAlpha = cfg.petBar.hiddenAlpha,
            maxAlpha = cfg.petBar.alpha,
        },
        ["stanceBar"] = {
            frame = StanceBarFrame,
            buttonName = "StanceButton",
            maxButtons = NUM_STANCE_SLOTS,
            minAlpha = cfg.stanceBar.hiddenAlpha,
            maxAlpha = cfg.stanceBar.alpha,
        },
        ["multiBarRight"] = {
            frame = MultiBarRight,
            buttonName = "MultiBarRightButton",
            maxButtons = NUM_ACTIONBAR_BUTTONS,
            minAlpha = cfg.multiBarRight.hiddenAlpha,
            maxAlpha = cfg.multiBarRight.alpha,
        },
        ["multiBarLeft"] = {
            frame = MultiBarLeft,
            buttonName = "MultiBarLeftButton",
            maxButtons = NUM_ACTIONBAR_BUTTONS,
            minAlpha = cfg.multiBarLeft.hiddenAlpha,
            maxAlpha = cfg.multiBarLeft.alpha,
        },
        ["multiBarBottomLeft"] = {
            frame = MultiBarBottomLeft,
            buttonName = "MultiBarBottomLeftButton",
            maxButtons = NUM_ACTIONBAR_BUTTONS,
            minAlpha = cfg.multiBarBottomLeft.hiddenAlpha,
            maxAlpha = cfg.multiBarBottomLeft.alpha,
        },
        ["nMainbarActionBar"] = {
            frame = nMainbarActionBar,
            buttonName = "nMainbarActionBarButton",
            maxButtons = NUM_ACTIONBAR_BUTTONS,
            minAlpha = cfg.nMainbarActionBar.hiddenAlpha,
            maxAlpha = cfg.nMainbarActionBar.alpha,
        },
    }

    for name, info in pairs(mouseoverData) do
        local config = cfg[name]

        if ( config and config.mouseover ) then
            nMainbar:EnableMouseOver(info.frame, info.buttonName, info.maxButtons, info.minAlpha, info.maxAlpha)
        end
    end
end

function nMainbarMixin:SetupExtrabars()
    local extraBars = {
        ["petBar"] = PetActionBarFrame,
        ["stanceBar"] = StanceBarFrame,
        ["possessBar"] = PossessBarFrame,
    }

    local hiddenObjects = {
        PossessBackground1,
        PossessBackground2,
        StanceBarLeft,
        StanceBarMiddle,
        StanceBarRight,
        SlidingActionBarTexture0,
        SlidingActionBarTexture1,
    }

    for _, object in pairs(hiddenObjects) do
        nMainbar:Kill(object)
    end

    for name, bar in pairs(extraBars) do
        local info = cfg[name]

        if ( info and not info.hide) then
            bar:SetAlpha(info.alpha or 1)
            bar:SetScale(info.scale or 1)
            bar:SetFrameStrata("MEDIUM")
        end
    end

    if ( cfg.stanceBar.hide ) then
        hooksecurefunc("StanceBar_Update", function()
            if ( StanceBarFrame:IsShown() and not nMainbar:IsTaintable() ) then
                RegisterStateDriver(StanceBarFrame, "visibility", "hide")
            end
        end)
    end

    if ( cfg.petBar.vertical ) then
        for i = 2, NUM_PET_ACTION_SLOTS do
            local button = _G["PetActionButton"..i]
            button:ClearAllPoints()
            button:SetPoint("TOP", _G["PetActionButton"..(i - 1)], "BOTTOM", 0, -8)
        end
    end

    if ( not cfg.button.showKeybinds ) then
        hooksecurefunc("PetActionButton_SetHotkeys", function(self)
            if ( not cfg.button.showKeybinds ) then
                self.HotKey:Hide()
            end
        end)

        for i = 1, NUM_PET_ACTION_SLOTS do
            local button = _G["PetActionButton"..i]
            PetActionButton_SetHotkeys(button)
        end
    end

    -- Shift + alt-key and left mouse to move.

    if ( cfg.MainMenuBar.moveableExtraBars ) then
        for _, bar in pairs(extraBars) do
            bar:EnableMouse(false)
        end

        for _, button in pairs({
            _G["PossessButton1"],
            _G["PetActionButton1"],
            _G["StanceButton1"],
            _G["PlayerPowerBarAlt"],
        }) do
            button:ClearAllPoints()
            button:SetPoint("CENTER", UIParent, -100)

            button:RegisterForDrag("LeftButton")
            button:SetMovable(true)
            button:SetUserPlaced(true)

            button:HookScript("OnDragStart", function(self)
                if ( IsShiftKeyDown() and IsAltKeyDown() ) then
                    self:StartMoving()
                end
            end)

            button:HookScript("OnDragStop", function(self)
                self:StopMovingOrSizing()
            end)
        end
    end

    hooksecurefunc("MainMenuBarVehicleLeaveButton_Update", function()
        MainMenuBarVehicleLeaveButton:ClearAllPoints()
        MainMenuBarVehicleLeaveButton:SetPoint("CENTER", MainMenuBarArtFrame.RightEndCap, "TOP", 0, 15)
    end)
end
