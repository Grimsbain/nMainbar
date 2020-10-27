local _, nMainbar = ...

    -- Experience Bar

hooksecurefunc(ExpBarMixin, "OnLoad", function(self)
    self.OverlayFrame.Text:SetFontObject("nMainbarWatchbarFont")
end)

    -- Azerite Bar

hooksecurefunc(AzeriteBarMixin, "OnLoad", function(self)
    self.OverlayFrame.Text:SetFontObject("nMainbarWatchbarFont")
end)

    -- Reputation Bar

hooksecurefunc(ReputationBarMixin, "OnLoad", function(self)
    self.OverlayFrame.Text:SetFontObject("nMainbarWatchbarFont")

    self:SetScript("OnMouseDown", function(self, button)
        if ( not nMainbar:IsTaintable() and IsAltKeyDown() ) then
            ToggleCharacter("ReputationFrame")
        end
    end)
end)

    -- Honor Bar

hooksecurefunc(HonorBarMixin, "OnLoad", function(self)
    self.OverlayFrame.Text:SetFontObject("nMainbarWatchbarFont")

    self:SetScript("OnMouseDown", function(self, button)
        if ( not nMainbar:IsTaintable() and IsAltKeyDown() ) then
            ToggleTalentFrame(PVP_TALENTS_TAB)
        end
    end)
end)

    -- Legion Artifact Bar

hooksecurefunc(ArtifactBarMixin, "OnLoad", function(self)
    self.OverlayFrame.Text:SetFontObject("nMainbarWatchbarFont")
end)
