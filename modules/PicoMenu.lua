local _, nMainbar = ...
local cfg = nMainbar.Config

local menuList = {
    {
        text = MAINMENU_BUTTON,
        isTitle = true,
        notCheckable = true,
    },
    {
        text = CHARACTER_BUTTON,
        icon = [[Interface\PaperDollInfoFrame\UI-EquipmentManager-Toggle]],
        func = function()
            ToggleCharacter("PaperDollFrame")
        end,
        notCheckable = true,
    },
    {
        text = SPELLBOOK_ABILITIES_BUTTON,
        icon = [[Interface\MINIMAP\TRACKING\Class]],
        func = function()
            ToggleSpellBook(BOOKTYPE_SPELL)
        end,
        notCheckable = true,
    },
    {
        text = TALENTS,
        icon = [[Interface\AddOns\nMainbar\Media\picomenu\picomenuTalents]],
        func = function()
            ToggleTalentFrame()
        end,
        notCheckable = true,
    },
    {
        text = ACHIEVEMENT_BUTTON,
        icon = [[Interface\AddOns\nMainbar\Media\picomenu\picomenuAchievement]],
        func = function()
            ToggleAchievementFrame()
        end,
        notCheckable = true,
    },
    {
        text = QUESTLOG_BUTTON,
        icon = [[Interface\GossipFrame\ActiveQuestIcon]],
        func = function()
            ToggleQuestLog()
        end,
        notCheckable = true,
    },
    {
        text = COMMUNITIES_FRAME_TITLE,
        icon = [[Interface\GossipFrame\TabardGossipIcon]],
        arg1 = IsInGuild("player"),
        func = function()
            ToggleGuildFrame()
        end,
        notCheckable = true,
    },
    {
        text = SOCIAL_BUTTON,
        icon = [[Interface\FriendsFrame\PlusManz-BattleNet]],
        func = function()
            ToggleFriendsFrame()
        end,
        notCheckable = true,
    },
    {
        text = PLAYER_V_PLAYER,
        icon = [[Interface\MINIMAP\TRACKING\BattleMaster]],
        func = function()
            TogglePVPUI()
        end,
        notCheckable = true,
    },
    {
        text = DUNGEONS_BUTTON,
        icon = [[Interface\LFGFRAME\BattleNetWorking0]],
        func = function()
            ToggleLFDParentFrame()
        end,
        notCheckable = true,
    },
    {
        text = CHALLENGES,
        icon = [[Interface\BUTTONS\UI-GroupLoot-DE-Up]],
        func = function()
            PVEFrame_ToggleFrame("ChallengesFrame", nil)
        end,
        notCheckable = true,
    },
    {
        text = RAID,
        icon = [[Interface\TARGETINGFRAME\UI-TargetingFrame-Skull]],
        func = function()
            ToggleRaidFrame()
        end,
        notCheckable = true,
    },
    {
        text = MOUNTS,
        icon = [[Interface\MINIMAP\TRACKING\StableMaster]],
        func = function()
            ToggleCollectionsJournal(1)
        end,
        notCheckable = true,
    },
    {
        text = PETS,
        icon = [[Interface\ICONS\Tracking_WildPet]],
        func = function()
            ToggleCollectionsJournal(2)
        end,
        notCheckable = true,
    },
    {
        text = TOY_BOX,
        icon = [[Interface\MINIMAP\TRACKING\Reagents]],
        func = function()
            ToggleCollectionsJournal(3)
        end,
        notCheckable = true,
    },
    {
        text = HEIRLOOMS,
        icon = [[Interface\PaperDollInfoFrame\UI-EquipmentManager-Toggle]],
        func = function()
            ToggleCollectionsJournal(4)
        end,
        notCheckable = true,
    },
    {
        text = WARDROBE,
        icon = [[Interface\MINIMAP\TRACKING\Transmogrifier]],
        func = function()
            ToggleCollectionsJournal(5)
        end,
        notCheckable = true,
    },
    {
        text = ENCOUNTER_JOURNAL,
        icon = [[Interface\MINIMAP\TRACKING\Profession]],
        func = function()
            ToggleEncounterJournal()
        end,
        notCheckable = true,
    },
    {
        text = GM_EMAIL_NAME,
        icon = [[Interface\CHATFRAME\UI-ChatIcon-Blizz]],
        func = function()
            ToggleHelpFrame()
        end,
        notCheckable = true,
    },
    {
        text = BATTLEFIELD_MINIMAP,
        func = function()
            ToggleBattlefieldMap()
        end,
        notCheckable = true,
    },
}

local addonMenuTable = {
    {
        text = true,
		hasArrow = false,
		dist = 0,
		isTitle = true,
		isUninteractable = true,
        notCheckable = true,
        minWidth = 150,
    },
    {   text = ADDONS,
        hasArrow = true,
        notCheckable = true,
        menuList = {
            {
                text = ADDONS,
                isTitle = true,
                notCheckable = true,
            },
        }
    }
}

local addonMenuData = {
    ["BigWigs"] = {
        text = "BigWigs",
        func = function()
            if ( BigWigsOptions ) then
                BigWigsOptions:Open()
            else
                LoadAddOn("BigWigs_Options")
                BigWigsOptions:Open()
            end
        end,
        found = false,
    },
    ["DBM-Core"] = {
        text = "DBM",
        func = function()
            DBM:LoadGUI()
        end,
        found = false,
    },
    ["Details"] = {
        text = "Details",
        func = function()
            if ( not IsShiftKeyDown() ) then
                _detalhes:ToggleWindow(1)
                _detalhes:ToggleWindow(2)
            else
                _detalhes.tabela_historico:resetar()
            end
        end,
        found = false,
    },
    ["Skada"] = {
        text = "Skada",
        func = function()
            Skada:ToggleWindow()
        end,
        found = false,
    },
    ["Recount"] = {
        text = "Recount",
        func = function()
            ToggleFrame(Recount.MainWindow)

            if ( Recount.MainWindow:IsShown() ) then
                Recount:RefreshMainWindow()
            end
        end,
        found = false,
    },
    ["TinyDPS"] = {
        text = "TinyDPS",
        func = function()
            ToggleFrame(tdpsFrame)
        end,
        found = false,
    },
    ["Numeration"] = {
        text = "Numeration",
        func = function()
            if ( not IsShiftKeyDown() ) then
                Numeration:ToggleVisibility()
            else
                StaticPopup_Show("RESET_DATA")
            end
        end,
        found = false,
    },
    ["nPlates"] = {
        text = "nPlates 2",
        func = function()
            SlashCmdList["NPLATES"]("config")
        end,
        found = false,
    },
    ["oUF_NeavRaid"] = {
        text = "oUF NeavRaid",
        func = function()
            SlashCmdList["NEAVRT"]("UNLOCK")
        end,
        found = false,
    },
    ["Grid"] = {
        text = "Grid",
        func = function()
            ToggleFrame(GridLayoutFrame)
        end,
        found = false,
    },
    ["Grid2"] = {
        text = "Grid",
        func = function()
            ToggleFrame(Grid2LayoutFrame)
        end,
        found = false,
    },
    ["PhoenixStyle"] = {
        text = "PhoenixStyle",
        func = function()
            ToggleFrame(PSFmain1)
            ToggleFrame(PSFmain2)
            ToggleFrame(PSFmain3)
        end,
        found = false,
    },
    ["VuhDo"] = {
        text = "VuhDo",
        func = function()
            SlashCmdList["VUHDO"]("toggle")
        end,
        found = false,
    },
    ["AtlasLoot"] = {
        text = "AtlasLoot",
        func = function()
            AtlasLoot.GUI:Toggle()
        end,
        found = false,
    },
    ["Altoholic"] = {
        text = "Altoholic",
        func = function()
            ToggleFrame(AltoholicFrame)
        end,
        found = false,
    },
}

nMainbarPicoMenuMixin = {}

function nMainbarPicoMenuMixin:OnLoad()
    if ( not cfg.showPicomenu ) then
        self:Hide()
        return
    end

    self.addonFound = false
    self.tableInserted = false

    self:SetPoint("BOTTOM", MainMenuBarArtFrame.RightEndCap, 0, 8)
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")
    self:RegisterEvent("PLAYER_REGEN_DISABLED")
    self:RegisterForMouse("LeftButtonDown","LeftButtonUp","RightButtonDown","RightButtonUp")

    self:MoveTicketButton()
end

function nMainbarPicoMenuMixin:OnEvent(event, ...)
    if ( event == "ADDON_LOADED" ) then
        self:UpdateAddOnTable()
    elseif ( event == "PLAYER_REGEN_ENABLED" ) then
        self:Enable()
    elseif ( event == "PLAYER_REGEN_DISABLED" ) then
        DropDownList1:Hide()
        self:Disable()
    end
end

function nMainbarPicoMenuMixin:OnMouseDown(button)
    if ( nMainbar:IsTaintable() ) then
        return
    end

    self.normalTexture:ClearAllPoints()
    self.normalTexture:SetPoint("CENTER", 1, -1)
end

function nMainbarPicoMenuMixin:OnMouseUp(button)
    if ( nMainbar:IsTaintable() ) then
        return
    end

    self.normalTexture:ClearAllPoints()
    self.normalTexture:SetPoint("CENTER")

    if ( button == "LeftButton" ) then
        if ( DropDownList1:IsShown() ) then
            DropDownList1:Hide()
        else
            EasyMenu(menuList, self.DropDown, self, 5, 310, "MENU", 5)
        end
    else
        if ( not GameMenuFrame:IsVisible() ) then
            ShowUIPanel(GameMenuFrame)
        else
            HideUIPanel(GameMenuFrame)
        end
    end

    GameTooltip:Hide()
end

function nMainbarPicoMenuMixin:OnEnter()
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT", 25, -5)
    GameTooltip:AddLine(MAINMENU_BUTTON)
    GameTooltip:Show()
end

function nMainbarPicoMenuMixin:OnLeave()
    GameTooltip:Hide()
end

function nMainbarPicoMenuMixin:UpdateAddOnTable()
    for addon, data in pairs(addonMenuData) do
        if ( IsAddOnLoaded(addon) and data.found == false ) then
            self.addonFound = true
            data.found = true
            addonMenuTable[2].menuList[(#addonMenuTable[2].menuList) + 1] = {
                text = data.text,
                func = data.func,
                notCheckable = true,
                keepShownOnClick = true,
            }
        end
    end

    if ( self.addonFound and not self.tableInserted ) then
        table.insert(menuList, addonMenuTable[1])
        table.insert(menuList, addonMenuTable[2])
        self.tableInserted = true
    end
end

function nMainbarPicoMenuMixin:MoveTicketButton()
    HelpOpenWebTicketButton:ClearAllPoints()
    HelpOpenWebTicketButton:SetPoint("LEFT", self, "RIGHT")
    HelpOpenWebTicketButton:SetParent(self)
end
