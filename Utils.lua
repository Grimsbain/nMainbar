local _, nMainbar = ...

function nMainbar:IsTaintable()
    return (InCombatLockdown() or (UnitAffectingCombat("player") or UnitAffectingCombat("pet")))
end

function nMainbar:Kill(object)
    if ( not object ) then
        return
    end

    local objectType = object:GetObjectType()

    if ( objectType == "Frame" or objectType == "Button" ) then
        object:UnregisterAllEvents()
        object:Hide()
    elseif ( objectType == "Texture" ) then
        object:SetTexture(nil)
    end
end

function nMainbar:EnableMouseOver(bar, buttonName, maxButtons, minAlpha, maxAlpha)
    local frame = CreateFrame("Frame", bar:GetName().."MouseOverFrame", bar, "nMainbar_MouseoverTemplate")
    frame:SetupBar(buttonName, maxButtons, minAlpha, maxAlpha)
end
