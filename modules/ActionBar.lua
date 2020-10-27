local _, nMainbar = ...
local cfg = nMainbar.Config

nMainbarActionBarMixin = {}

function nMainbarActionBarMixin:OnLoad()
    if ( nMainbar.UpdateButtons ) then
        nMainbar:UpdateButtons()
    end

    if ( not cfg.miniBottomRightBar ) then
        return
    end

    local _, bottomRightShown = GetActionBarToggles()

    if ( bottomRightShown ) then
        self:Hide()
    end

    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterEvent("ACTIONBAR_SHOWGRID")
    self:RegisterEvent("ACTIONBAR_HIDEGRID")
    self:RegisterEvent("PET_BAR_SHOWGRID")
    self:RegisterEvent("PET_BAR_HIDEGRID")

    self:SetupHooks()
end

function nMainbarActionBarMixin:OnEvent(event, ...)
    if ( event == "PLAYER_REGEN_DISABLED" ) then
        InterfaceOptionsActionBarsPanelBottomRight:Disable()
    elseif ( event == "PLAYER_REGEN_ENABLED" ) then
        InterfaceOptionsActionBarsPanelBottomRight:Enable()

        if ( self.needsUpdate ) then
            self:CheckShouldShow()
        end
    elseif ( event == "ACTIONBAR_SHOWGRID" or event == "PET_BAR_SHOWGRID" ) then
		self:SetGrid(1)
	elseif ( event == "ACTIONBAR_HIDEGRID" or event == "PET_BAR_HIDEGRID" ) then
		if ( not KeybindFrames_InQuickKeybindMode() ) then
			self:SetGrid(0)
		end
    end
end

function nMainbarActionBarMixin:SetGrid(showgrid)
    if ( nMainbar:IsTaintable() ) then
        return
    end

    if ( ALWAYS_SHOW_MULTIBARS == "1" or ALWAYS_SHOW_MULTIBARS == 1 ) then
        showgrid = 1
    end

    for i = 1, NUM_ACTIONBAR_BUTTONS do
        local button = _G['nMainbarActionBarButton'..i]
        button:SetAttribute("showgrid", showgrid)
        button:ShowGrid(ACTION_BUTTON_SHOW_GRID_REASON_CVAR)
    end
end

function nMainbarActionBarMixin:CheckShouldShow()
    if ( nMainbar:IsTaintable() ) then
        nMainbarActionBar.needsUpdate = true
        return
    end

    if ( nMainbarActionBar ) then
        local status = cfg.miniBottomRightBar and not SHOW_MULTI_ACTIONBAR_2
        nMainbarActionBar:SetShown(status)
    end
end

function nMainbarActionBarMixin:SetHighlights(show)
    for i = 1, NUM_ACTIONBAR_BUTTONS do
        _G["nMainbarActionBarButton"..i].QuickKeybindHighlightTexture:SetShown(show)
    end
end

function nMainbarActionBarMixin:SetupHooks()
    hooksecurefunc(MainMenuBar, "ChangeMenuBarSizeAndPosition", self.CheckShouldShow)

    hooksecurefunc(ActionButtonUtil, "ShowAllQuickKeybindButtonHighlights", function()
        self:SetHighlights(true)
    end)

    hooksecurefunc(ActionButtonUtil, "HideAllQuickKeybindButtonHighlights", function()
        self:SetHighlights(false)
    end)

    hooksecurefunc("MultiActionBar_ShowAllGrids", function(reason, force)
        self:SetGrid(1)
    end)

    hooksecurefunc("MultiActionBar_HideAllGrids", function(reason, force)
        self:SetGrid(0)
    end)

    hooksecurefunc("MultiActionBar_SetAllQuickKeybindModeEffectsShown", function(show)
        self.QuickKeybindGlow:SetShown(show)
    end)
end
