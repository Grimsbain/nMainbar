local _, nMainbar = ...
local cfg = nMainbar.Config

local MEDIA_PATH = [[Interface\AddOns\nMainbar\Media\]]

BINDING_HEADER_NBAGS = "nMainbar"
BINDING_NAME_NBAGS_TOGGLE = "Bag Bar Toggle"

local bagButtons = {
    MainMenuBarBackpackButton,
    CharacterBag0Slot,
    CharacterBag1Slot,
    CharacterBag2Slot,
    CharacterBag3Slot
}

nMainbarBagsMixin = {}

function nMainbarBagsMixin:OnLoad()
    if ( not cfg.showPicomenu ) then
        return
    end

    self:RegisterEvent("ADDON_LOADED")
    self.lastButton = nil

    if ( BagsShown == nil ) then
        BagsShown = false
    end

    self:Initialize()
end

function nMainbarBagsMixin:OnEvent(event, ...)
    local name = ...
    if ( name == "nMainbar" ) then
        self:SetBagVisibility()
        self:Initialize()
        self:UnregisterEvent("ADDON_LOADED")
    end
end

function nMainbarBagsMixin:Initialize()
    for _, button in ipairs(bagButtons) do
        self:SetupButton(button)
    end

    MicroButtonAndBagsBar.MicroBagBar:ClearAllPoints()
    MicroButtonAndBagsBar.MicroBagBar:Hide()
    MicroButtonAndBagsBar.QuickKeybindsMicroBagBarGlow:SetTexture(nil)

    CharacterMicroButton:ClearAllPoints()
    CharacterMicroButton:SetPoint("BOTTOMLEFT", UIParent, 9000, 9000)

    hooksecurefunc("MoveMicroButtons", function(anchor, achorTo, relAnchor, x, y, isStacked)
        if ( not isStacked ) then
            CharacterMicroButton:ClearAllPoints()
            CharacterMicroButton:SetPoint("BOTTOMLEFT", UIParent, 9000, 9000)
        end
    end)

    RegisterNewSlashCommand(self.ToggleBags, "neavbag", "neavbagtogle")
end

function nMainbarBagsMixin:SetBagVisibility()
    for _, button in ipairs(bagButtons) do
        button:SetShown(BagsShown)
    end
end

function nMainbarBagsMixin:ToggleBags()
    if ( not cfg.showPicomenu ) then
        return
    end

    BagsShown = not BagsShown
    nMainbarBags:SetBagVisibility()
end

function nMainbarBagsMixin:SetupButton(button)
    if ( not button ) then
        return
    end

    local count = button.Count
    local border = button.IconBorder
    local highlightTexture = button.SlotHighlightTexture
    local normalTexture = _G[button:GetName().."NormalTexture"]

    button:SetSize(36, 36)
    button.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)

    if ( count ) then
        count:ClearAllPoints()
        count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -1, 1.5)
    end

    if ( border ) then
        border:SetAlpha(0)
    end

    if ( normalTexture ) then
        normalTexture:SetWidth(64);
        normalTexture:SetHeight(64);
        normalTexture:SetVertexColor(cfg.color.Normal:GetRGBA())

        normalTexture:ClearAllPoints()
        PixelUtil.SetPoint(normalTexture, "TOPRIGHT", button, "TOPRIGHT", 1, 1)
        PixelUtil.SetPoint(normalTexture, "BOTTOMLEFT", button, "BOTTOMLEFT", -1, -1)

        button:SetNormalTexture(MEDIA_PATH.."textureNormal")
        button:SetPushedTexture(MEDIA_PATH.."texturePushed")
        button:GetPushedTexture():SetAllPoints(normalTexture)
        button:SetHighlightTexture(MEDIA_PATH.."textureHighlight")
        button:GetHighlightTexture():SetAllPoints(normalTexture)
    end

    if ( highlightTexture ) then
        highlightTexture:SetTexture(MEDIA_PATH.."texturePushed")
        highlightTexture:ClearAllPoints()
        highlightTexture:SetAllPoints(normalTexture)
    end

    button:ClearAllPoints()

    if ( button == MainMenuBarBackpackButton ) then
        button:SetPoint("BOTTOMRIGHT", UIParent)
    else
        button:SetPoint("RIGHT", self.lastButton, "LEFT")
    end

    self.lastButton = button
end
