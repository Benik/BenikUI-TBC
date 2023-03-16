local BUI, E, L, V, P, G = unpack((select(2, ...)))
local mod = BUI:GetModule('Styles')
local S = E:GetModule('Skins')

local CreateFrame = CreateFrame

local function StyleDBM_Options()
	if not E.db.benikui.Skins.addonSkins.dbm or not BUI.AS then
		return
	end

	DBM_GUI_OptionsFrame:HookScript("OnShow", function()
		DBM_GUI_OptionsFrame:BuiStyle("Outside")
	end)
end

local function StyleInFlight()
	if E.db.benikui.Skins.variousSkins.inflight ~= true or E.db.benikui.misc.flightMode == true then
		return
	end

	local frame = _G.InFlightBar
	if frame then
		if not frame.isStyled then
			frame:CreateBackdrop("Transparent")
			frame.backdrop:BuiStyle("Outside")
			frame.isStyled = true
		end
	end
end

local function LoadInFlight()
	local f = CreateFrame("Frame")
	f:RegisterEvent("UPDATE_BONUS_ACTIONBAR")

	f:SetScript("OnEvent", function(self, event)
		if event then
			StyleInFlight()
			f:UnregisterEvent(event)
		end
	end)
end

local function KalielsTracker()
	if BUI:IsAddOnEnabled('!KalielsTracker') and E.db.benikui.general.benikuiStyle and E.db.benikui.Skins.variousSkins.kt then
		_G['!KalielsTrackerFrame']:BuiStyle('Outside')
	end
end

local function RXPGuides()
	if not E.db.benikui.Skins.variousSkins.rxpguides then return end

	local RXPFrame = _G.RXPFrame
	local ItemFrame = _G.RXPItemFrame
	local GuideName = RXPFrame.GuideName
	local BottomFrame = RXPFrame.BottomFrame
	local Footer = RXPFrame.Footer
	local ScrollFrame = RXPFrame.ScrollFrame
	local ScrollBar = ScrollFrame.ScrollBar

	S:HandleFrame(GuideName, true, 'Default')
	S:HandleFrame(BottomFrame)
	S:HandleFrame(Footer, true, 'Default')
	S:HandleScrollBar(ScrollBar, 20, 5, 'NoBackdrop')

	BottomFrame:SetPoint("TOPLEFT", RXPFrame, 3, 0)
	BottomFrame:SetPoint("BOTTOMRIGHT", RXPFrame, -3, 22)

	GuideName:SetHeight(25)
	GuideName:SetPoint("BOTTOMLEFT", BottomFrame, "TOPLEFT", 0, 2)
	GuideName:SetPoint("BOTTOMRIGHT", BottomFrame, "TOPRIGHT", 0, 2)

	ScrollFrame:SetPoint("TOPLEFT", BottomFrame, 2, -3)
	ScrollFrame:SetPoint("BOTTOMRIGHT", BottomFrame, -20, 5)

	if BUI.ShadowMode then
		local shadows = {GuideName, BottomFrame, Footer}
		for _, frame in pairs(shadows) do
			frame:CreateSoftShadow()
		end
	end

	local function SkinItemFrame()
		ItemFrame.isSkinned = false

		if not ItemFrame.isSkinned then
			S:HandleFrame(ItemFrame)
			S:HandleFrame(ItemFrame.title, false, 'Default')

			if BUI.ShadowMode then
				ItemFrame:CreateSoftShadow()
				ItemFrame.title:CreateSoftShadow()
			end

			ItemFrame.isSkinned = true
		end
	end
	hooksecurefunc(RXP, 'UpdateItemFrame', SkinItemFrame)

	local function SkinStepFrames()
		local FramePool = RXPFrame.CurrentStepFrame.framePool

		for i, stepframe in ipairs(FramePool) do
			stepframe.isSkinned = false

			if not stepframe.isSkinned then
				S:HandleFrame(stepframe)
				S:HandleFrame(stepframe.number, false, 'Default')

				if BUI.ShadowMode then
					stepframe:CreateSoftShadow()
					stepframe.number:CreateSoftShadow()
				end

				stepframe.isSkinned = true
			end
		end
	end
	hooksecurefunc(RXP, 'SetStep', SkinStepFrames)
end

function mod:LoD_AddOns(_, addon)
	if addon == "DBM-GUI" then
		StyleDBM_Options()
	end

	if addon == "InFlight" then
		LoadInFlight()
	end
end

function mod:StyleAddons()
	KalielsTracker()
	if BUI:IsAddOnEnabled('RXPGuides') then RXPGuides() end
end