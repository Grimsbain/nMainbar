local _, nMainbar = ...

nMainbarMouseoverMixin = {}

function nMainbarMouseoverMixin:OnLoad()
    self.bar = self:GetParent()
end

function nMainbarMouseoverMixin:OnShow()
    if ( not self:IsMouseOver() ) then
        self.bar:SetAlpha(self.minAlpha)
    end
end

function nMainbarMouseoverMixin:OnEnter()
    self.bar:SetAlpha(self.maxAlpha)
end

function nMainbarMouseoverMixin:OnLeave()
    self.bar:SetAlpha(self.minAlpha)
end

function nMainbarMouseoverMixin:SetupBar(buttonName, maxButtons, minAlpha, maxAlpha)
    self.buttonName = buttonName
    self.maxButtons = maxButtons
    self.minAlpha = minAlpha or 0
    self.maxAlpha = maxAlpha or 1

    self.bar:SetAlpha(self.minAlpha)

    self:SetPoint("TOPLEFT", _G[self.buttonName..1], -5, 5)
    self:SetPoint("BOTTOMRIGHT", _G[self.buttonName..self.maxButtons], 5, -5)

    self:SetupButtons()

    hooksecurefunc("ValidateActionBarTransition", function()
        if ( self.bar:IsShown() ) then
            if ( not self:IsMouseOver() ) then
                self.bar:SetAlpha(self.minAlpha)
            end
        end
    end)
end

function nMainbarMouseoverMixin:SetupButtons()
    for i = 1, self.maxButtons do
        local button = _G[self.buttonName..i]

        if ( button ) then
            button:HookScript("OnEnter", function()
                self.bar:SetAlpha(self.maxAlpha)
            end)

            button:HookScript("OnLeave", function()
                if ( not self:IsMouseOver() ) then
                    self.bar:SetAlpha(self.minAlpha)
                end
            end)
        end
    end
end
