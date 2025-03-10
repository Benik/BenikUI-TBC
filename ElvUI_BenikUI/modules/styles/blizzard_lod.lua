local BUI, E, L, V, P, G = unpack((select(2, ...)))
local S = E:GetModule("Skins")

local _G = _G
local pairs, unpack = pairs, unpack
local hooksecurefunc = hooksecurefunc

-- AchievementUI
local function style_AchievementUI()
	if E.private.skins.blizzard.achievement ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.AchievementFrame
	if frame.backdrop then
		frame.backdrop:BuiStyle("Outside")
	end
end
S:AddCallbackForAddon("Blizzard_AchievementUI", "BenikUI_AchievementUI", style_AchievementUI)

-- AlliedRacesUI
local function style_AlliedRacesUI()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.alliedRaces ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.AlliedRacesFrame
	if frame.backdrop then
		frame.backdrop:BuiStyle("Outside")
	end
end
S:AddCallbackForAddon("Blizzard_AlliedRacesUI", "BenikUI_AlliedRaces", style_AlliedRacesUI)

-- ArchaeologyUI
local function style_ArchaeologyUI()
	if E.private.skins.blizzard.archaeology ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ArchaeologyFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_ArchaeologyUI", "BenikUI_ArchaeologyUI", style_ArchaeologyUI)

-- ArtifactUI
local function style_ArtifactUI()
	if E.private.skins.blizzard.artifact ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.ArtifactFrame
	frame.backdrop:BuiStyle("Outside")
	frame.CloseButton:ClearAllPoints()
	frame.CloseButton:Point("TOPRIGHT", ArtifactFrame, "TOPRIGHT", 2, 2)
end
S:AddCallbackForAddon("Blizzard_ArtifactUI", "BenikUI_ArtifactUI", style_ArtifactUI)

-- AuctionHouseUI
local function style_AuctionHouseUI()
	if E.private.skins.blizzard.auctionhouse ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.AuctionHouseFrame
	frame:BuiStyle("Outside")
	-- todo update this once ElvUI starts skinning it again
	--frame.WoWTokenResults.GameTimeTutorial:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_AuctionHouseUI", "BenikUI_AuctionHouseUI", style_AuctionHouseUI)

-- AzeriteEssenceUI
local function style_AzeriteEssenceUI()
	if E.private.skins.blizzard.azeriteEssence ~= true or E.private.skins.blizzard.enable ~= true or E.db.benikui.general.benikuiStyle ~= true then return end

	_G.AzeriteEssenceUI:BuiStyle('Outside')
end
S:AddCallbackForAddon("Blizzard_AzeriteEssenceUI", "BenikUI_AzeriteEssenceUI", style_AzeriteEssenceUI)

-- AzeriteUI
local function style_AzeriteUI()
	if E.private.skins.blizzard.azerite ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.AzeriteEmpoweredItemUI.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_AzeriteUI", "BenikUI_AzeriteUI", style_AzeriteUI)

-- AzeriteRespecFrame
local function style_AzeriteRespecUI()
	if E.private.skins.blizzard.azeriteRespec ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.AzeriteRespecFrame
	frame:BuiStyle("Inside")

	local CloseButton = frame.CloseButton
	CloseButton:ClearAllPoints()
	CloseButton:Point("TOPRIGHT", frame, "TOPRIGHT", -2, -6)

	AzeriteRespecFrameTitleText:ClearAllPoints()
	AzeriteRespecFrameTitleText:Point("TOP", frame, "TOP", 0, -12)

	frame.ButtonFrame.AzeriteRespecButton:ClearAllPoints()
	frame.ButtonFrame.AzeriteRespecButton:Point("TOP", frame.ItemSlot, "BOTTOM", 0, -20)
end
S:AddCallbackForAddon("Blizzard_AzeriteRespecUI", "BenikUI_AzeriteRespecUI", style_AzeriteRespecUI)

-- ReforgingFrame
local function style_ReforgingUI()
	if E.private.skins.blizzard.reforge ~= true or E.private.skins.blizzard.enable ~= true or
			E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ReforgingFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_ReforgingUI", "BenikUI_ReforgingUI", style_ReforgingUI)

-- BarberShop
local function style_BarberShop()
	if E.private.skins.blizzard.barber ~= true or E.private.skins.blizzard.enable ~= true or
			E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.BarberShopFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_BarbershopUI", "BenikUI_BarbershopUI", style_BarberShop)

-- BattlefieldMap
local function style_BattlefieldMap()
	if E.private.skins.blizzard.bgmap ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.BattlefieldMapFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_BattlefieldMap", "BenikUI_BattlefieldMap", style_BattlefieldMap)

-- BindingUI
local function style_BindingUI()
	if E.private.skins.blizzard.binding ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.KeyBindingFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_BindingUI", "BenikUI_BindingUI", style_BindingUI)

-- BlackMarketUI
local function style_BlackMarketUI()
	if E.private.skins.blizzard.bmah ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.BlackMarketFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_BlackMarketUI", "BenikUI_BlackMarketUI", style_BlackMarketUI)

-- Calendar
local function style_Calendar()
	if E.private.skins.blizzard.calendar ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	if _G.CalendarFrame.backdrop then
		_G.CalendarFrame.backdrop:BuiStyle("Outside")
	end
	_G.CalendarViewEventFrame:BuiStyle("Outside")
	_G.CalendarViewHolidayFrame:BuiStyle("Outside")
	_G.CalendarCreateEventFrame:BuiStyle("Outside")
	_G.CalendarContextMenu:BuiStyle("Outside")
	_G.CalendarViewRaidFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_Calendar", "BenikUI_Calendar", style_Calendar)

-- ChallengesUI
local function style_ChallengesUI()
	if E.private.skins.blizzard.lfg ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ChallengesKeystoneFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_ChallengesUI", "BenikUI_ChallengesUI", style_ChallengesUI)

-- Channels
local function style_Channels()
	if E.private.skins.blizzard.channels ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ChannelFrame.backdrop:BuiStyle("Outside")
	_G.CreateChannelPopup.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_Channels", "BenikUI_Channels", style_Channels)

-- Collections
local function style_Collections()
	if E.private.skins.blizzard.collections ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.CollectionsJournal:BuiStyle("Outside")
	if _G.WardrobeFrame then
		_G.WardrobeFrame:BuiStyle("Outside")
	end
	if _G.WardrobeOutfitEditFrame then
		_G.WardrobeOutfitEditFrame:BuiStyle("Outside")
	end
	if E.private.skins.blizzard.tooltip and _G.PetJournalPrimaryAbilityTooltip then
		_G.PetJournalPrimaryAbilityTooltip.backdrop:BuiStyle("Outside")
	end
end
S:AddCallbackForAddon("Blizzard_Collections", "BenikUI_Collections", style_Collections)

-- Communities
local function style_Communities()
	if E.private.skins.blizzard.communities ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.CommunitiesFrame
	if frame then
		frame:BuiStyle("Outside")
		if E.Cata then
			frame.GuildMemberDetailFrame:BuiStyle("Outside")
		end
		frame.NotificationSettingsDialog:BuiStyle("Outside")
	end
	if E.Cata then
		_G.CommunitiesGuildLogFrame:BuiStyle("Outside")
	end
	_G.CommunitiesSettingsDialog:BuiStyle("Outside")
	_G.CommunitiesAvatarPickerDialog:BuiStyle("Outside")
	if E.Cata then
		_G.ClubFinderCommunityAndGuildFinderFrame.RequestToJoinFrame:BuiStyle("Outside")
		_G.ClubFinderGuildFinderFrame.RequestToJoinFrame:BuiStyle("Outside")
	end
end
S:AddCallbackForAddon("Blizzard_Communities", "BenikUI_Communities", style_Communities)

-- Contribution
local function style_Contribution()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.contribution ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.ContributionCollectionFrame
	if not frame.backdrop then
		frame:CreateBackdrop("Transparent")
	end

	if frame.backdrop then
		frame.backdrop:BuiStyle("Outside")
	end

	-- Not sure about this tooltip tho -- Merathilis
	if E.private.skins.blizzard.tooltip ~= true then
		return
	end
	ContributionBuffTooltip:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_Contribution", "BenikUI_Contribution", style_Contribution)

-- CovenantPreviewUI
local function style_CovenantPreviewUI()
	if E.private.skins.blizzard.covenantPreview ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.CovenantPreviewFrame
	hooksecurefunc(frame, 'TryShow', function(covenantInfo)
		if covenantInfo and not frame.IsStyled then
			frame.backdrop:BuiStyle("Outside")
			frame.IsStyled = true
		end
	end)
end
S:AddCallbackForAddon("Blizzard_CovenantPreviewUI", "BenikUI_CovenantPreviewUI", style_CovenantPreviewUI)

-- CovenantSanctum
local function style_CovenantSanctum()
	if E.private.skins.blizzard.covenantSanctum ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.CovenantSanctumFrame
	frame:HookScript('OnShow', function()
		if not frame.backdrop.style then
			frame.backdrop:BuiStyle("Outside")
		end
	end)
end
S:AddCallbackForAddon("Blizzard_CovenantSanctum", "BenikUI_CovenantSanctum", style_CovenantSanctum)

-- DeathRecap
local function style_DeathRecap()
	if E.private.skins.blizzard.deathRecap ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.DeathRecapFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_DeathRecap", "BenikUI_DeathRecap", style_DeathRecap)

-- EncounterJournal
local function style_EncounterJournal()
	if E.private.skins.blizzard.encounterjournal ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.EncounterJournal:BuiStyle("Outside")

	local Buttons = {
		_G.EncounterJournalInstanceSelectSuggestTab,
		_G.EncounterJournalInstanceSelectDungeonTab,
		_G.EncounterJournalInstanceSelectRaidTab,
		_G.EncounterJournalInstanceSelectLootJournalTab
	}

	for _, Button in pairs(Buttons) do
		if Button then
			local text = Button:GetFontString()
			if text then
				text:ClearAllPoints()
				text:Point("CENTER", Button, "CENTER", 0, 2)
				text:FontTemplate(nil, 12)
			end
		end
	end

	if E.private.skins.blizzard.tooltip ~= true then
		return
	end
	_G.EncounterJournalTooltip:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_EncounterJournal", "BenikUI_EncounterJournal", style_EncounterJournal)

-- FlightMap
local function style_FlightMap()
	if E.private.skins.blizzard.taxi ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.FlightMapFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_FlightMap", "BenikUI_FlightMap", style_FlightMap)

-- Garrison BuiStyle
local fRecruits = {}
local function style_GarrisonUI()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.garrison ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.OrderHallMissionFrame:BuiStyle("Small")
	if _G.AdventureMapQuestChoiceDialog.backdrop then
		_G.AdventureMapQuestChoiceDialog.backdrop:BuiStyle("Outside")
	end

	_G.BFAMissionFrame.backdrop:BuiStyle("Outside")
	local CovenantMissionFrame = _G.CovenantMissionFrame
	CovenantMissionFrame.backdrop:BuiStyle("Outside")

	CovenantMissionFrame.Top:Hide()
	CovenantMissionFrame.TopBorder:Hide()
	CovenantMissionFrame.Bottom:Hide()
	CovenantMissionFrame.BottomBorder:Hide()
	CovenantMissionFrame.Left:Hide()
	CovenantMissionFrame.LeftBorder:Hide()
	CovenantMissionFrame.Right:Hide()
	CovenantMissionFrame.RightBorder:Hide()
	CovenantMissionFrame.TopLeftCorner:Hide()
	CovenantMissionFrame.TopRightCorner:Hide()
	CovenantMissionFrame.BotRightCorner:Hide()
	CovenantMissionFrame.BotLeftCorner:Hide()

	GarrisonCapacitiveDisplayFrame.IncrementButton:ClearAllPoints()
	GarrisonCapacitiveDisplayFrame.IncrementButton:Point("LEFT", GarrisonCapacitiveDisplayFrame.Count, "RIGHT", 4, 0)
	if E.private.skins.blizzard.tooltip then
		_G.GarrisonFollowerAbilityWithoutCountersTooltip:BuiStyle("Outside")
		_G.GarrisonFollowerMissionAbilityWithoutCountersTooltip:BuiStyle("Outside")
	end

	_G.GarrisonMissionFrame.backdrop:BuiStyle("Outside")
	_G.GarrisonLandingPage.backdrop:BuiStyle("Outside")
	_G.GarrisonBuildingFrame.backdrop:BuiStyle("Outside")
	_G.GarrisonCapacitiveDisplayFrame.backdrop:BuiStyle("Outside")

	-- ShipYard
	_G.GarrisonShipyardFrame.backdrop:BuiStyle("Outside")
	-- Tooltips
	if E.private.skins.blizzard.tooltip then
		_G.GarrisonShipyardMapMissionTooltip:BuiStyle("Outside")
		_G.GarrisonBonusAreaTooltip:StripTextures()
		_G.GarrisonBonusAreaTooltip:CreateBackdrop("Transparent")
		_G.GarrisonBonusAreaTooltip.backdrop:BuiStyle("Outside")
		_G.GarrisonMissionMechanicFollowerCounterTooltip:BuiStyle("Outside")
		_G.GarrisonMissionMechanicTooltip:BuiStyle("Outside")
		_G.FloatingGarrisonShipyardFollowerTooltip:BuiStyle("Outside")
		_G.GarrisonShipyardFollowerTooltip:BuiStyle("Outside")
		_G.GarrisonBuildingFrame.BuildingLevelTooltip:BuiStyle("Outside")
		_G.GarrisonFollowerAbilityTooltip:BuiStyle("Outside")
		_G.GarrisonMissionMechanicTooltip:StripTextures()
		_G.GarrisonMissionMechanicTooltip:CreateBackdrop("Transparent")
		_G.GarrisonMissionMechanicTooltip.backdrop:BuiStyle("Outside")
		_G.GarrisonMissionMechanicFollowerCounterTooltip:StripTextures()
		_G.GarrisonMissionMechanicFollowerCounterTooltip:CreateBackdrop("Transparent")
		_G.GarrisonMissionMechanicFollowerCounterTooltip.backdrop:BuiStyle("Outside")
		_G.FloatingGarrisonFollowerTooltip:BuiStyle("Outside")
		_G.GarrisonFollowerTooltip:BuiStyle("Outside")
	end

	-- Garrison Monument
	local GMonument = _G.GarrisonMonumentFrame
	GMonument:StripTextures()
	GMonument:CreateBackdrop("Transparent")
	GMonument:BuiStyle("Small")
	GMonument:ClearAllPoints()
	GMonument:Point("CENTER", E.UIParent, "CENTER", 0, -200)
	GMonument:Height(70)
	GMonument.RightBtn:Size(25, 25)
	GMonument.LeftBtn:Size(25, 25)

	-- Follower recruiting (available at the Inn)
	_G.GarrisonRecruiterFrame.backdrop:BuiStyle("Outside")
	S:HandleDropDownBox(_G.GarrisonRecruiterFramePickThreatDropDown)
	local rBtn = _G.GarrisonRecruiterFrame.Pick.ChooseRecruits
	rBtn:ClearAllPoints()
	rBtn:Point("BOTTOM", _G.GarrisonRecruiterFrame.backdrop, "BOTTOM", 0, 30)
	S:HandleButton(rBtn)

	local GRecruitSelect = _G.GarrisonRecruitSelectFrame
	GRecruitSelect:StripTextures()
	GRecruitSelect:CreateBackdrop("Transparent")
	GRecruitSelect.backdrop:BuiStyle("Outside")
	S:HandleCloseButton(GRecruitSelect.CloseButton)
	S:HandleEditBox(GRecruitSelect.FollowerList.SearchBox)

	GRecruitSelect.FollowerList:StripTextures()
	S:HandleScrollBar(_G.GarrisonRecruitSelectFrameListScrollFrameScrollBar)
	GRecruitSelect.FollowerSelection:StripTextures()

	GRecruitSelect.FollowerSelection.Recruit1:CreateBackdrop()
	GRecruitSelect.FollowerSelection.Recruit1:ClearAllPoints()
	GRecruitSelect.FollowerSelection.Recruit1:Point("LEFT", GRecruitSelect.FollowerSelection, "LEFT", 6, 0)
	GRecruitSelect.FollowerSelection.Recruit2:CreateBackdrop()
	GRecruitSelect.FollowerSelection.Recruit2:ClearAllPoints()
	GRecruitSelect.FollowerSelection.Recruit2:Point("LEFT", GRecruitSelect.FollowerSelection.Recruit1, "RIGHT", 6, 0)
	GRecruitSelect.FollowerSelection.Recruit3:CreateBackdrop()
	GRecruitSelect.FollowerSelection.Recruit3:ClearAllPoints()
	GRecruitSelect.FollowerSelection.Recruit3:Point("LEFT", GRecruitSelect.FollowerSelection.Recruit2, "RIGHT", 6, 0)

	for i = 1, 3 do
		fRecruits[i] = CreateFrame("Frame", nil, E.UIParent, 'BackdropTemplate')
		fRecruits[i]:SetTemplate("Default", true)
		fRecruits[i]:Size(190, 60)
		if i == 1 then
			fRecruits[i]:SetParent(GRecruitSelect.FollowerSelection.Recruit1)
			fRecruits[i]:Point("TOP", GRecruitSelect.FollowerSelection.Recruit1.backdrop, "TOP")
			fRecruits[i]:SetFrameLevel(GRecruitSelect.FollowerSelection.Recruit1:GetFrameLevel())
			GRecruitSelect.FollowerSelection.Recruit1.Class:Size(60, 58)
		elseif i == 2 then
			fRecruits[i]:SetParent(GRecruitSelect.FollowerSelection.Recruit2)
			fRecruits[i]:Point("TOP", GRecruitSelect.FollowerSelection.Recruit2.backdrop, "TOP")
			fRecruits[i]:SetFrameLevel(GRecruitSelect.FollowerSelection.Recruit2:GetFrameLevel())
			GRecruitSelect.FollowerSelection.Recruit2.Class:Size(60, 58)
		elseif i == 3 then
			fRecruits[i]:SetParent(GRecruitSelect.FollowerSelection.Recruit3)
			fRecruits[i]:Point("TOP", GRecruitSelect.FollowerSelection.Recruit3.backdrop, "TOP")
			fRecruits[i]:SetFrameLevel(GRecruitSelect.FollowerSelection.Recruit3:GetFrameLevel())
			GRecruitSelect.FollowerSelection.Recruit3.Class:Size(60, 58)
		end
	end
	S:HandleButton(GRecruitSelect.FollowerSelection.Recruit1.HireRecruits)
	S:HandleButton(GRecruitSelect.FollowerSelection.Recruit2.HireRecruits)
	S:HandleButton(GRecruitSelect.FollowerSelection.Recruit3.HireRecruits)
end
S:AddCallbackForAddon("Blizzard_GarrisonUI", "BenikUI_GarrisonUI", style_GarrisonUI)

-- GuildBankUI
local function style_GuildBankUI()
	if E.private.skins.blizzard.gbank ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.GuildBankFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_GuildBankUI", "BenikUI_GuildBankUI", style_GuildBankUI)

-- GuildUI
local function style_GuildUI()
	if E.private.skins.blizzard.guild ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.GuildFrame:BuiStyle("Outside")

	local GuildFrames = {
		_G.GuildMemberDetailFrame,
		_G.GuildTextEditFrame,
		_G.GuildLogFrame,
		_G.GuildNewsFiltersFrame
	}
	for _, frame in pairs(GuildFrames) do
		if frame and frame.backdrop and not frame.backdrop.style then
			frame.backdrop:BuiStyle("Outside")
		end
	end
end
S:AddCallbackForAddon("Blizzard_GuildUI", "BenikUI_GuildUI", style_GuildUI)

-- GuildControlUI
local function style_GuildControlUI()
	if E.private.skins.blizzard.guildcontrol ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end
	_G.GuildControlUI:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_GuildControlUI", "BenikUI_GuildControlUI", style_GuildControlUI)

-- IslandsQueueUI
local function style_IslandsQueueUI()
	if E.private.skins.blizzard.islandQueue ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.IslandsQueueFrame.backdrop:BuiStyle("Outside")

	-- tooltip
	if E.private.skins.blizzard.tooltip ~= true then
		return
	end
	_G.IslandsQueueFrameTooltip:GetParent():GetParent():HookScript(
		"OnShow",
		function(self)
			if not self.style then
				self:BuiStyle("Outside")
			end
		end
	)
end
S:AddCallbackForAddon("Blizzard_IslandsQueueUI", "BenikUI_IslandsQueueUI", style_IslandsQueueUI)

-- InspectUI
local function style_InspectUI()
	if E.private.skins.blizzard.inspect ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.InspectFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_InspectUI", "BenikUI_InspectUI", style_InspectUI)

-- ItemInteractionUI
local function style_ItemInteractionUI()
	if E.private.skins.blizzard.itemInteraction ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ItemInteractionFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_ItemInteractionUI", "BenikUI_ItemInteractionUI", style_ItemInteractionUI)

-- ItemSocketingUI
local function style_ItemSocketingUI()
	if E.private.skins.blizzard.socket ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ItemSocketingFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_ItemSocketingUI", "BenikUI_ItemSocketingUI", style_ItemSocketingUI)

-- ItemUpgradeUI
local function style_ItemUpgradeUI()
	if E.private.skins.blizzard.itemUpgrade ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ItemUpgradeFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_ItemUpgradeUI", "BenikUI_ItemUpgradeUI", style_ItemUpgradeUI)

-- LookingForGroupUI
local function style_LookingForGroupUI()
	if E.Classic or E.private.skins.blizzard.lfg ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.LFGListingFrame.backdrop:BuiStyle("Outside")
	_G.LFGBrowseFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_LookingForGroupUI", "BenikUI_LookingForGroupUI", style_LookingForGroupUI)

-- LookingForGuildUI
local function style_LookingForGuildUI()
	if E.private.skins.blizzard.lfguild ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.LookingForGuildFrame:BuiStyle("Outside")
end

local function LoadStyle()
	if LookingForGuildFrame then
		--Frame already created
		style_LookingForGuildUI()
	else
		--Frame not created yet, wait until it is
		hooksecurefunc("LookingForGuildFrame_CreateUIElements", style_LookingForGuildUI)
	end
end
S:AddCallbackForAddon("Blizzard_LookingForGuildUI", "BenikUI_LookingForGuildUI", LoadStyle)

-- MacroUI
local function style_MacroUI()
	if E.private.skins.blizzard.macro ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.MacroFrame:BuiStyle("Outside")
	_G.MacroPopupFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_MacroUI", "BenikUI_MacroUI", style_MacroUI)

-- ObliterumUI
local function style_ObliterumUI()
	if E.private.skins.blizzard.obliterum ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ObliterumForgeFrame:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_ObliterumUI", "BenikUI_ObliterumUI", style_ObliterumUI)

-- OrderHallUI
local function style_OrderHallUI()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.orderhall ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.OrderHallTalentFrame:HookScript(
		"OnShow",
		function(self)
			if self.styled then
				return
			end
			self:BuiStyle("Outside")
			self.styled = true
		end
	)
end
S:AddCallbackForAddon("Blizzard_OrderHallUI", "BenikUI_OrderHallUI", style_OrderHallUI)

-- PlayerChoiceUI
local function style_PlayerChoiceUI()
	if E.private.skins.blizzard.playerChoice ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.PlayerChoiceFrame
	hooksecurefunc(frame, 'Update', function()
		if not frame.IsStyled then
			frame.backdrop:BuiStyle("Outside")
			frame.IsStyled = true
		end
	end)
end
S:AddCallbackForAddon("Blizzard_PlayerChoiceUI", "BenikUI_PlayerChoiceUI", style_PlayerChoiceUI)

-- PVPUI
local function style_PVPUI()
	if E.private.skins.blizzard.pvp ~= true or E.private.skins.blizzard.tooltip ~= true or
		E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ConquestTooltip:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_PVPUI", "BenikUI_PVPUI", style_PVPUI)

-- PVPMatch
local function style_PVPMatch()
	if E.private.skins.blizzard.bgscore ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.PVPMatchScoreboard.backdrop:BuiStyle("Outside")
	_G.PVPMatchResults.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_PVPMatch", "BenikUI_PVPMatch", style_PVPMatch)

-- QuestChoice
local function style_QuestChoice()
	if E.private.skins.blizzard.questChoice ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.QuestChoiceFrame:BuiStyle("Small")
end
S:AddCallbackForAddon("Blizzard_QuestChoice", "BenikUI_QuestChoice", style_QuestChoice)

-- ScrappingMachine
local function style_ScrappingMachineUI()
	if E.private.skins.blizzard.scrapping ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ScrappingMachineFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_ScrappingMachineUI", "BenikUI_ScrappingMachineUI", style_ScrappingMachineUI)

-- Soulbinds
local function style_Soulbinds()
	if E.private.skins.blizzard.soulbinds ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.SoulbindViewer.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_Soulbinds", "BenikUI_Soulbinds", style_Soulbinds)

-- TalentUI
local function style_TalentUI()
	if E.private.skins.blizzard.talent ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.PlayerTalentFrame.backdrop:BuiStyle("Outside")
	for i = 1, 3 do
		local tab = _G["PlayerSpecTab" .. i]
		if tab then
			tab:CreateSoftShadow()
		end
	end
end
S:AddCallbackForAddon("Blizzard_TalentUI", "BenikUI_TalentUI", style_TalentUI)

-- TalkingHeadUI
local function style_TalkingHeadUI()
	if E.private.skins.blizzard.talkinghead ~= true or E.db.benikui.Skins.variousSkins.talkingHead ~= true or
		E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.TalkingHeadFrame
	if frame then
		-- Hide ElvUI's backdrop
		if frame.backdrop then
			frame.backdrop:Hide()
		end

		frame.BackgroundFrame:CreateBackdrop("Transparent")
		frame.BackgroundFrame.backdrop:SetAllPoints()
		frame.BackgroundFrame.backdrop:CreateWideShadow() -- to hide the borders not showing due to scaling

		frame.BackgroundFrame:BuiStyle("Inside")
		if frame.BackgroundFrame.style then
			frame.BackgroundFrame.style:ClearAllPoints()
			frame.BackgroundFrame.style:Point("TOPLEFT", frame, "TOPLEFT", -(E.PixelMode and 0 or 2), (E.PixelMode and -5 or -7))
			frame.BackgroundFrame.style:Point("BOTTOMRIGHT", frame, "TOPRIGHT", (E.PixelMode and -1 or 1), (E.PixelMode and 0 or -2))
		end
	end
end
S:AddCallbackForAddon("Blizzard_TalkingHeadUI", "BenikUI_TalkingHeadUI", style_TalkingHeadUI)

local function style_TimeManager()
	if E.private.skins.blizzard.timemanager ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.TimeManagerFrame:BuiStyle("Outside")
	_G.StopwatchFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_TimeManager", "BenikUI_TimeManager", style_TimeManager)

-- TradeSkillUI
local function style_TradeSkillUI()
	if E.private.skins.blizzard.tradeskill ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.TradeSkillFrame
	frame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_TradeSkillUI", "BenikUI_TradeSkillUI", style_TradeSkillUI)

-- CraftFrame
local function style_CraftUI()
	if E.private.skins.blizzard.craft ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.CraftFrame
	if frame.backdrop then
		frame.backdrop:BuiStyle("Outside")
	end
end
S:AddCallbackForAddon("Blizzard_CraftUI", "BenikUI_CraftUI", style_CraftUI)

-- TrainerUI
local function style_TrainerUI()
	if E.private.skins.blizzard.trainer ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	_G.ClassTrainerFrame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_TrainerUI", "BenikUI_TrainerUI", style_TrainerUI)

-- VoidStorageUI
local function style_VoidStorageUI()
	if E.private.skins.blizzard.voidstorage ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.VoidStorageFrame
	frame.backdrop:BuiStyle("Outside")
	for i = 1, 2 do
		local tab = frame["Page" .. i]
		if not tab.style then
			tab:BuiStyle("Inside")
			tab:GetNormalTexture():SetTexCoord(unpack(BUI.TexCoords))
			tab:GetNormalTexture():SetInside()
		end
	end
end
S:AddCallbackForAddon("Blizzard_VoidStorageUI", "BenikUI_VoidStorageUI", style_VoidStorageUI)

-- WarboardUI
local function style_WarboardUI()
	if E.private.skins.blizzard.warboard ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.WarboardQuestChoiceFrame
	frame.backdrop:BuiStyle("Outside")
	frame.backdrop.style:SetFrameLevel(1)
end
S:AddCallbackForAddon("Blizzard_WarboardUI", "BenikUI_WarboardUI", style_WarboardUI)

-- WeeklyRewards
local function style_WeeklyRewards()
	if E.private.skins.blizzard.weeklyRewards ~= true or E.private.skins.blizzard.enable ~= true or
		E.db.benikui.general.benikuiStyle ~= true
	then
		return
	end

	local frame = _G.WeeklyRewardsFrame
	frame.backdrop:BuiStyle("Outside")
end
S:AddCallbackForAddon("Blizzard_WeeklyRewards", "BenikUI_WeeklyRewards", style_WeeklyRewards)
