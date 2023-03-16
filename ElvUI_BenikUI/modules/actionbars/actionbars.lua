local BUI, E, L, V, P, G = unpack((select(2, ...)))
local mod = BUI:GetModule('Actionbars')
local AB = E:GetModule('ActionBars')

if E.private.actionbar.enable ~= true then return; end

local _G = _G
local pairs = pairs
local GetNumShapeshiftForms = GetNumShapeshiftForms
local C_TimerAfter = C_Timer.After
local MAX_TOTEMS = MAX_TOTEMS
local MAX_STANCES = GetNumShapeshiftForms()
local Masque = E.Masque
local MasqueGroup = Masque and E.private.actionbar.masque.actionbars

-- GLOBALS: NUM_PET_ACTION_SLOTS
-- GLOBALS: ElvUI_BarPet, ElvUI_StanceBar

local classColor = E:ClassColor(E.myclass, true)

local styleOtherBacks = {ElvUI_BarPet, ElvUI_StanceBar, ElvUI_MicroBar}

function mod:StyleBackdrops()
	-- Actionbar backdrops
	for _, bar in pairs(AB.handledBars) do
		if bar then
			bar.backdrop:BuiStyle('Outside', nil, true, true)

			if BUI.ShadowMode and not MasqueGroup then
				for _, button in ipairs(bar.buttons) do
					if button then
						button:CreateSoftShadow()
					end
				end
			end
		end
	end

	-- Other bar backdrops
	for _, frame in pairs(styleOtherBacks) do
		if frame.backdrop then
			frame.backdrop:BuiStyle('Outside', nil, true, true)
		end
	end
end

function mod:ToggleStyle()
	local db = E.db.benikui.actionbars.style
	-- Actionbar backdrops
	for i = 1, 10 do
		if _G['ElvUI_Bar'..i].backdrop.style then
			_G['ElvUI_Bar'..i].backdrop.style:SetShown(db['bar'..i])
		end
	end

	if E.Wrath then
		for i = 13, 15 do
			if _G['ElvUI_Bar'..i].backdrop.style then
				_G['ElvUI_Bar'..i].backdrop.style:SetShown(db['bar'..i])
			end
		end
	end

	-- Other bar backdrops
	if _G.ElvUI_BarPet.backdrop.style then
		_G.ElvUI_BarPet.backdrop.style:SetShown(db.petbar)
	end

	if _G.ElvUI_StanceBar.backdrop.style then
		_G.ElvUI_StanceBar.backdrop.style:SetShown(db.stancebar)
	end

	if _G.ElvUI_MicroBar.backdrop.style then
		_G.ElvUI_MicroBar.backdrop.style:SetShown(db.microbar)
	end
end

local r, g, b = 0, 0, 0
function mod:StyleColor()
	if E.db.benikui.general.benikuiStyle ~= true then return end
	local db = E.db.benikui.colors

	for _, bar in pairs(AB.handledBars) do
		if bar then
			if db.abStyleColor == 1 then
				r, g, b = classColor.r, classColor.g, classColor.b
			elseif db.abStyleColor == 2 then
				r, g, b = BUI:unpackColor(db.customAbStyleColor)
			elseif db.abStyleColor == 3 then
				r, g, b = BUI:unpackColor(E.db.general.valuecolor)
			else
				r, g, b = BUI:unpackColor(E.db.general.backdropcolor)
			end
			bar.backdrop.style:SetBackdropColor(r, g, b, db.abAlpha or 1)
		end
	end

	for _, frame in pairs(styleOtherBacks) do
		local name = _G[frame:GetName()].backdrop.style

		if db.abStyleColor == 1 then
			r, g, b = classColor.r, classColor.g, classColor.b
		elseif db.abStyleColor == 2 then
			r, g, b = BUI:unpackColor(db.customAbStyleColor)
		elseif db.abStyleColor == 3 then
			r, g, b = BUI:unpackColor(E.db.general.valuecolor)
		else
			r, g, b = BUI:unpackColor(E.db.general.backdropcolor)
		end
		if name then
			name:SetBackdropColor(r, g, b, db.abAlpha or 1)
		end
	end
end

function mod:PetShadows()
	-- Pet Buttons
	for i = 1, NUM_PET_ACTION_SLOTS do
		local petButtons = {_G['PetActionButton'..i]}
		for _, button in pairs(petButtons) do
			if button.backdrop then
				if BUI.ShadowMode and not MasqueGroup then
					if not button.backdrop.shadow then
						button.backdrop:CreateSoftShadow()
					end
				end
			end
		end
	end
end

function mod:StancebarShadows()
	for i = 1, MAX_STANCES do
		local button = _G['ElvUI_StanceBarButton'..i]
		if BUI.ShadowMode and not MasqueGroup then
			if button and not button.shadow then
				button:CreateSoftShadow()
			end
		end
	end
end

function mod:TotemShadows()
	if not BUI.ShadowMode or MasqueGroup then return end

	for i=1, MAX_TOTEMS do
		local button = _G["ElvUI_TotemBarTotem"..i];
		if button then
			if not button.shadow then
				button:CreateSoftShadow()
			end
		end
	end
end

local function VehicleExit()
	if E.private.actionbar.enable ~= true then
		return
	end
	local f = _G.MainMenuBarVehicleLeaveButton
	local arrow = "Interface\\AddOns\\ElvUI_BenikUI\\media\\textures\\flightMode\\arrow"
	f:SetNormalTexture(arrow)
	f:SetPushedTexture(arrow)
	f:SetHighlightTexture(arrow)

	if MasqueGroup and E.private.actionbar.masque.actionbars then return end
	f:GetNormalTexture():SetTexCoord(0, 1, 0, 1)
	f:GetPushedTexture():SetTexCoord(0, 1, 0, 1)
end

function mod:Initialize()
	C_TimerAfter(1, mod.StyleBackdrops)
	C_TimerAfter(1, mod.PetShadows)
	C_TimerAfter(2, mod.StyleColor)
	C_TimerAfter(2, mod.LoadToggleButtons)
	C_TimerAfter(2, mod.ToggleStyle)
	C_TimerAfter(2, mod.TotemShadows)
	C_TimerAfter(2, mod.StancebarShadows)
	VehicleExit()

	hooksecurefunc(BUI, "SetupColorThemes", mod.StyleColor)
end

BUI:RegisterModule(mod:GetName())