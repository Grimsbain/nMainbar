local _, nMainbar = ...
local cfg = nMainbar.Config

local MEDIA_PATH = [[Interface\AddOns\nMainbar\Media\]]

local borderOffsets = {
    ["EXTRAACTIONBUTTON"] = { border = 4, shadow = 5}
}

local function SkinButton(self, borderOffset, shadowOffset)
    if ( cfg.button.useMasque ) then
        return
    end

    self.skinned = true

    local buttonName = self:GetName()
    local icon = self.icon
    local border = self.Border
    local cooldown = self.cooldown
    local floatingBG = _G[buttonName.."FloatingBG"]
    local normalTexture = _G[buttonName.."NormalTexture2"] or self.NormalTexture
    local quickKeybindHighlight = self.QuickKeybindHighlightTexture

    if ( icon ) then
        icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
        PixelUtil.SetPoint(icon, "TOPRIGHT", self, "TOPRIGHT", -1, -1)
        PixelUtil.SetPoint(icon, "BOTTOMLEFT", self, "BOTTOMLEFT", 1, 1)
    end

    if ( cooldown and not self.cooldownUpdated ) then
        if ( not InCombatLockdown() ) then
            cooldown:ClearAllPoints()
            PixelUtil.SetPoint(cooldown, "TOPRIGHT", self, "TOPRIGHT", -2, -2)
            PixelUtil.SetPoint(cooldown, "BOTTOMLEFT", self, "BOTTOMLEFT", 1, 1)
            self.cooldownUpdated = true
        end
    end

    if ( normalTexture ) then
        self:SetNormalTexture(MEDIA_PATH.."textureNormal")
        normalTexture:ClearAllPoints()
        PixelUtil.SetPoint(normalTexture, "TOPRIGHT", self, "TOPRIGHT", borderOffset, borderOffset)
        PixelUtil.SetPoint(normalTexture, "BOTTOMLEFT", self, "BOTTOMLEFT", -borderOffset, -borderOffset)
        normalTexture:SetVertexColor(cfg.color.Normal:GetRGBA())

        self:SetCheckedTexture(MEDIA_PATH.."textureChecked")
        self:GetCheckedTexture():SetAllPoints(normalTexture)

        self:SetPushedTexture(MEDIA_PATH.."texturePushed")
        self:GetPushedTexture():SetAllPoints(normalTexture)

        self:SetHighlightTexture(MEDIA_PATH.."textureHighlight")
        self:GetHighlightTexture():SetAllPoints(normalTexture)
    end

    if ( border ) then
        border:SetBlendMode("BLEND")
        border:SetTexture(MEDIA_PATH.."UI-ActionButton-Glow")
        border:ClearAllPoints()
        border:SetAllPoints(normalTexture)
    end

    if ( quickKeybindHighlight ) then
        quickKeybindHighlight:ClearAllPoints()
        quickKeybindHighlight:SetAllPoints(normalTexture)
        quickKeybindHighlight:SetTexture(MEDIA_PATH.."UI-ActionButton-Glow")
        quickKeybindHighlight:SetVertexColor(131/255, 122/255, 82/255)
    end

    if ( floatingBG ) then
        floatingBG:ClearAllPoints()
        floatingBG:Hide()
    end

    if ( self.FlyoutBorder ) then
        self.FlyoutBorder:ClearAllPoints()
        self.FlyoutBorderShadow:ClearAllPoints()
    end

    if ( not self.Background ) then
        self.Background = self:CreateTexture("$parentBackground", "BACKGROUND", nil, -8)
        self.Background:SetTexture(MEDIA_PATH.."textureBackground")
        PixelUtil.SetPoint(self.Background, "TOPRIGHT", self, "TOPRIGHT", 14, 12)
        PixelUtil.SetPoint(self.Background, "BOTTOMLEFT", self, "BOTTOMLEFT", -14, -16)

        self.Shadow = self:CreateTexture("$parentShadow", "BACKGROUND")
        self.Shadow:SetTexture(MEDIA_PATH.."textureShadow")
        self.Shadow:SetVertexColor(0.0, 0.0, 0.0, 1.0)
        PixelUtil.SetPoint(self.Shadow, "TOPRIGHT", normalTexture, "TOPRIGHT", shadowOffset, shadowOffset)
        PixelUtil.SetPoint(self.Shadow, "BOTTOMLEFT", normalTexture, "BOTTOMLEFT", -shadowOffset, -shadowOffset)
    end
end

local function UpdateAction(self, force)
    local borderOffset = 1
    local shadowOffset = 4

    local offsets = borderOffsets[self.buttonType]

    if ( offsets ) then
        borderOffset = offsets.border;
        shadowOffset = offsets.shadow;
    end

    if ( not self.skinned or not self.cooldownUpdated ) then
        SkinButton(self, borderOffset, shadowOffset)
    end
end

local hotkeyRegexStrings = {
    ["(s%-)"] = "S-",
    ["(a%-)"] = "A-",
    ["(c%-)"] = "C-",
    ["(st%-)"] = "C-", -- German Control "Steuerung"
    [KEY_NUMPADDECIMAL] = "Nu.",
    [KEY_NUMPADDECIMAL] = "Nu.",
    [KEY_NUMPADDIVIDE] = "Nu/",
    [KEY_NUMPADMINUS] = "Nu-",
    [KEY_NUMPADMULTIPLY] = "Nu*",
    [KEY_NUMPADPLUS] = "Nu+",
    [KEY_MOUSEWHEELUP] = "MU",
    [KEY_MOUSEWHEELDOWN] = "MD",
    [KEY_NUMLOCK] = "NuL",
    [KEY_PAGEUP] = "PU",
    [KEY_PAGEDOWN] = "PD",
    [KEY_SPACE] = "_",
    [KEY_INSERT] = "Ins",
    [KEY_HOME] = "Hm",
    [KEY_DELETE] = "Del",
}

local function UpdateHotkeys(self, actionButtonType)
    local text = self.HotKey:GetText()

    if ( text == RANGE_INDICATOR ) then
        self.HotKey:SetText("*")
        return
    end

    if ( cfg.button.showKeybinds ) then
        if ( not self.hotkeyUpdated ) then
            self.HotKey:ClearAllPoints()
            self.HotKey:SetPoint("TOPRIGHT", self, 0, -3)
            self.HotKey:SetFontObject("nMainbarHotkeyFont")
            self.HotKey:SetVertexColor(cfg.color.HotKeyText:GetRGB())
            self.hotkeyUpdated = true
        end
    else
        self.HotKey:Hide()
        return
    end

    for patern, replace in pairs(hotkeyRegexStrings) do
        text = text:gsub(patern, replace)
    end

    for i = 1, 30 do
        text = text:gsub(_G["KEY_BUTTON"..i], "M"..i)
    end

    for i = 1, 9 do
        text = text:gsub(_G["KEY_NUMPAD"..i], "Nu"..i)
    end

    self.HotKey:SetText(text)
    self.HotKey:Show()
end

local function UpdateActionButton(self)
    self.HotKey:SetVertexColor(cfg.color.HotKeyText:GetRGB())

    if ( self.Name ) then
        if ( cfg.button.showMacroNames ) then
            self.Name:SetFontObject("nMainbarMacroFont")
            self.Name:SetVertexColor(cfg.color.MacroText:GetRGB())
        else
            self.Name:SetText("")
        end
    end

    if ( self.Border ) then
        if ( IsEquippedAction(self.action) ) then
            self.Border:SetVertexColor(cfg.color.IsEquipped:GetRGB())
            self.Border:SetAlpha(1)
        else
            self.Border:SetAlpha(0)
        end
    end
end

local function ShowGrid(self)
    if ( self.NormalTexture ) then
        self.NormalTexture:SetVertexColor(cfg.color.Normal:GetRGBA())
    end
end

local function UpdateCount(self)
    if ( self.Count ) then
        self.Count:SetPoint("BOTTOMRIGHT", self, 0, 1)
        self.Count:SetFontObject("nMainbarCountFont")
        self.Count:SetVertexColor(cfg.color.CountText:GetRGB())
    end
end

local function UpdateUsable(self, checksRange, inRange)
	if ( not self.NormalTexture ) then
		return
	end

    local isUsable, notEnoughMana = IsUsableAction(self.action)

	if ( isUsable ) then
		self.icon:SetVertexColor(1.0, 1.0, 1.0)
		self.NormalTexture:SetVertexColor(cfg.color.Normal:GetRGBA())
	elseif ( notEnoughMana ) then
		self.icon:SetVertexColor(cfg.color.OutOfMana:GetRGB())
		self.NormalTexture:SetVertexColor(cfg.color.OutOfMana:GetRGB())
	else
		self.icon:SetVertexColor(cfg.color.NotUsable:GetRGB())
		self.NormalTexture:SetVertexColor(cfg.color.NotUsable:GetRGB())
    end

    if ( checksRange and not inRange ) then
        self.icon:SetVertexColor(cfg.color.OutOfRange:GetRGB())
    end
end

hooksecurefunc("ExtraActionBar_Update", function()
    local bar = ExtraActionBarFrame

    if ( HasExtraActionBar() and bar.button.style:IsShown() ) then
        bar.button.style:Hide()
    end
end)

hooksecurefunc("ActionButton_UpdateRangeIndicator", function(self, checksRange, inRange)
    if ( self.action and cfg.button.buttonOutOfRange ) then
        UpdateUsable(self, checksRange, inRange)
    end

    if ( self.HotKey:GetText() == RANGE_INDICATOR ) then
        if ( checksRange ) then
            self.HotKey:Show()
            if ( inRange ) then
                self.HotKey:SetVertexColor(cfg.color.HotKeyText:GetRGB())
            else
                self.HotKey:SetVertexColor(cfg.color.OutOfRange:GetRGB())
            end
        else
            self.HotKey:Hide()
        end
    else
        if ( checksRange and not inRange ) then
            self.HotKey:SetVertexColor(cfg.color.OutOfRange:GetRGB())
        else
            self.HotKey:SetVertexColor(cfg.color.HotKeyText:GetRGB())
        end
    end
end)

hooksecurefunc("PetActionBar_Update", function()
    for i=1, NUM_PET_ACTION_SLOTS do
        local self = _G["PetActionButton"..i]

        SkinButton(self, 1.5, 4)

        if ( self.HotKey ) then
            if ( cfg.button.showKeybinds ) then
                self.HotKey:ClearAllPoints()
                self.HotKey:SetPoint("TOPRIGHT", self, 0, -3)
                self.HotKey:SetFontObject("nMainbarHotkeyFont")
                self.HotKey:SetVertexColor(cfg.color.HotKeyText:GetRGB())
            else
                self.HotKey:Hide()
            end
        end
    end
end)
securecall("PetActionBar_Update")

hooksecurefunc("StanceBar_UpdateState", function()
    for i = 1, NUM_STANCE_SLOTS do
        local self = StanceBarFrame.StanceButtons[i]
        SkinButton(self, 2, 4)
    end
end)

hooksecurefunc("PossessBar_UpdateState", function()
    for i = 1, NUM_POSSESS_SLOTS do
        local self = _G["PossessButton"..i]
        SkinButton(self, 1.5, 4)
    end
end)

function nMainbar:UpdateButtons()
    for _, button in pairs(ActionBarButtonEventsFrame.frames) do
        hooksecurefunc(button, "Update", UpdateActionButton)
        hooksecurefunc(button, "UpdateAction", UpdateAction)
        hooksecurefunc(button, "UpdateHotkeys", UpdateHotkeys)
        hooksecurefunc(button, "ShowGrid", ShowGrid)
        hooksecurefunc(button, "UpdateCount", UpdateCount)
        hooksecurefunc(button, "UpdateUsable", UpdateUsable)
    end
end
