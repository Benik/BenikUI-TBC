local BUI, E, L, V, P, G = unpack((select(2, ...)))
local mod = BUI:GetModule('Styles')
local S = E:GetModule('Skins')

local _G = _G
local pairs = pairs
local C_TimerAfter = C_Timer.After

local MAX_STATIC_POPUPS = 4

local function LoadSkin()
	if E.db.benikui.general.benikuiStyle ~= true then return end

	if E.private.skins.blizzard.enable ~= true then
		return
	end

	local db = E.private.skins.blizzard

	if db.addonManager then
		_G.AddonList:BuiStyle("Outside")
	end

	if db.blizzardOptions then
		_G.AudioOptionsFrame:BuiStyle("Outside")
		_G.ChatConfigFrame:BuiStyle("Outside")
		_G.InterfaceOptionsFrame:BuiStyle("Outside")
		_G.ReadyCheckFrame:BuiStyle("Outside")
		_G.ReadyCheckListenerFrame:BuiStyle("Outside")
		_G.VideoOptionsFrame:BuiStyle("Outside")
	end

	local function repUpdate()
		if _G.ReputationDetailFrame then
			_G.ReputationDetailFrame:BuiStyle("Outside")
		end
	end

	if db.character then
		_G.CharacterFrame.backdrop:BuiStyle("Outside")
		if E.Wrath then
			_G.PVPFrame.backdrop:BuiStyle("Outside")
		end
		hooksecurefunc('ReputationFrame_Update', repUpdate)
	end

	if db.dressingroom then
		_G.DressUpFrame.backdrop:BuiStyle("Outside")
	end

	if db.friends then
		_G.AddFriendFrame:BuiStyle("Outside")
		_G.FriendsFrame.backdrop:BuiStyle("Outside")
		_G.FriendsFriendsFrame.backdrop:BuiStyle("Outside")
	end

	if db.gossip then
		_G.GossipFrame.backdrop:BuiStyle("Outside")
		_G.ItemTextFrame:BuiStyle("Outside")
	end

	if db.guildregistrar then
		_G.GuildRegistrarFrame:BuiStyle("Outside")
	end

	if db.help then
		_G.HelpFrame.backdrop:BuiStyle("Outside")
	end

	if db.loot then
		_G.LootFrame:BuiStyle("Outside")
		_G.MasterLooterFrame:BuiStyle("Outside")
	end

	if db.mail then
		_G.MailFrame.backdrop:BuiStyle("Outside")
		_G.OpenMailFrame:BuiStyle("Outside")
	end

	if db.merchant then
		if _G.MerchantFrame then
			_G.MerchantFrame.backdrop:BuiStyle("Outside")
		end
	end

	if db.misc then
		local ChatMenus = {
			_G.ChatMenu,
			_G.EmoteMenu,
			_G.LanguageMenu,
			_G.VoiceMacroMenu,
		}

		for _, menu in pairs(ChatMenus) do
			if menu then
				menu:BuiStyle('Outside')
			end
		end

		_G.BNToastFrame:BuiStyle("Outside")
		_G.GameMenuFrame:BuiStyle("Outside")
		if not E.Classic then
			_G.ReportFrame:BuiStyle("Outside")
		end
		_G.ReportCheatingDialog.backdrop:BuiStyle("Outside")
		_G.SideDressUpFrame:BuiStyle("Outside")
		_G.StackSplitFrame:BuiStyle("Outside")
		_G.StaticPopup1:BuiStyle("Outside")
		_G.StaticPopup2:BuiStyle("Outside")
		_G.StaticPopup3:BuiStyle("Outside")
		_G.StaticPopup4:BuiStyle("Outside")
		_G.TicketStatusFrameButton:BuiStyle("Outside")

		hooksecurefunc('UIDropDownMenu_CreateFrames', function(level)
			local listFrame = _G['DropDownList'..level];
			local listFrameName = listFrame:GetName();
			local Backdrop = _G[listFrameName..'Backdrop']
			Backdrop:BuiStyle("Outside")

			local menuBackdrop = _G[listFrameName..'MenuBackdrop']
			menuBackdrop:BuiStyle("Outside")
		end)

		local function StylePopups()
			for i = 1, MAX_STATIC_POPUPS do
				local frame = _G['ElvUI_StaticPopup'..i]
				if frame and not frame.style then
					frame:BuiStyle("Outside")
				end
			end
		end
		C_TimerAfter(1, StylePopups)
	end

	if db.nonraid then
		_G.RaidInfoFrame:BuiStyle("Outside")
	end

	if db.petition then
		_G.PetitionFrame.backdrop:BuiStyle("Outside")
	end

	if db.pvp then
		_G.PVPReadyDialog:BuiStyle("Outside")
	end

	if db.quest then
		_G.QuestFrame.backdrop:BuiStyle("Outside")
		_G.QuestLogFrame.backdrop:BuiStyle("Outside")
		if E.Wrath then
			_G.QuestLogDetailFrame.backdrop:BuiStyle("Outside")
		end
	end

	if db.stable then
		_G.PetStableFrame.backdrop:BuiStyle("Outside")
	end

	if db.spellbook then
		_G.SpellBookFrame.backdrop:BuiStyle("Outside")
	end

	if db.tabard then
		_G.TabardFrame:BuiStyle("Outside")
	end

	if db.taxi then
		_G.TaxiFrame.backdrop:BuiStyle("Outside")
	end

	if db.trade then
		_G.TradeFrame:BuiStyle("Outside")
	end

	if IsAddOnLoaded('ColorPickerPlus') then return end
	_G.ColorPickerFrame:HookScript('OnShow', function(frame)
		if frame.backdrop and not frame.backdrop.style then
			frame.backdrop:BuiStyle("Outside")
		end
	end)
end
S:AddCallback("BenikUI_styleFreeBlizzardFrames", LoadSkin)

-- WorldMap
function mod:styleWorldMap()
	if E.private.skins.blizzard.enable ~= true or E.private.skins.blizzard.worldmap ~= true or E.db.benikui.general.benikuiStyle ~= true then
		return
	end

	local mapFrame = _G.WorldMapFrame
	if not mapFrame.style then
		mapFrame:BuiStyle("Outside")
	end
end