local _, nMainbar = ...
local cfg = nMainbar.Config

nMainbar_ExtraActionButton = {}

function nMainbar_ExtraActionButton:OnLoad()
    if ( not cfg.moveableExtraActionButton ) then
        return
    end

    CreateBeautyBorder(self)

    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterForDrag("LeftButton")
    self:SetSize(ExtraActionButton1:GetSize())

    ExtraActionButton1:ClearAllPoints()
    ExtraActionButton1:SetPoint("CENTER", self)

    RegisterNewSlashCommand(self.SlashCommand, "moveextraactionbar", "moveeab")
end

function nMainbar_ExtraActionButton:OnEvent(event, ...)
    if ( event == "PLAYER_REGEN_DISABLED" and self:IsShown() ) then
        self:SetShown(false)
    end
end

function nMainbar_ExtraActionButton:OnDragStart()
    self:StartMoving()
end

function nMainbar_ExtraActionButton:OnDragStop()
    self:StopMovingOrSizing()
end

function nMainbar_ExtraActionButton:SlashCommand(msg)
    if ( nMainbar:IsTaintable() ) then
        print(("|cffCC3333n|rMainbar: %s."):format(ERR_NOT_IN_COMBAT))
        return
    end

    local shouldShow = not nMainbar_ExtraActionButtonAnchor:IsShown()
    nMainbar_ExtraActionButtonAnchor:SetShown(shouldShow)
end
