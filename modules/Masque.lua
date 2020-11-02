local _, nMainbar = ...
local cfg = nMainbar.Config

if ( not cfg.button.useMasque ) then
    return
end

local Masque = LibStub("Masque", true)
local MasqueGroup = Masque and Masque:Group("nMainbar", "ActionBars")

for _, button in pairs(ActionBarButtonEventsFrame.frames) do
    MasqueGroup:AddButton(button)
end

MasqueGroup:ReSkin()
