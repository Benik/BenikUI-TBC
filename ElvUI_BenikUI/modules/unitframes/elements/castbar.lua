local BUI, E, L, V, P, G = unpack((select(2, ...)))
local mod = BUI:NewModule('Castbar', 'AceTimer-3.0', 'AceEvent-3.0')
local UF = E:GetModule('UnitFrames');
local LSM = E.Libs.LSM

--[[
	CREDIT:
	This module is based on Blazeflack's ElvUI_CastBarPowerOverlay
	Castbar Backdrop Color. Credit: Blazeflack - Taken from ElvUI CustomTweaks
	Edited for BenikUI under Blaze's permission. Many thanks :)
]]

local _G = _G

local INVERT_ANCHORPOINT = {
	TOPLEFT = 'BOTTOMRIGHT',
	LEFT = 'RIGHT',
	BOTTOMLEFT = 'TOPRIGHT',
	RIGHT = 'LEFT',
	TOPRIGHT = 'BOTTOMLEFT',
	BOTTOMRIGHT = 'TOPLEFT',
	CENTER = 'CENTER',
	TOP = 'BOTTOM',
	BOTTOM = 'TOP',
}

local units = {"Player", "Target", "Focus", "Pet"}

-- GLOBALS: hooksecurefunc

local function changeCastbarLevel(unit, unitframe)
	local castbar = unitframe.Castbar

	castbar:SetFrameStrata("LOW")
	castbar:SetFrameLevel(unitframe.InfoPanel:GetFrameLevel() + 10)
end

local function resetCastbarLevel(unit, unitframe)
	local db = E.db.unitframe.units[unit].castbar;
	local castbar = unitframe.Castbar

	if db.strataAndLevel and db.strataAndLevel.useCustomStrata then
		castbar:SetFrameStrata(db.strataAndLevel.frameStrata)
	else
		castbar:SetFrameStrata("HIGH")
	end

	if db.strataAndLevel and db.strataAndLevel.useCustomLevel then
		castbar:SetFrameLevel(db.strataAndLevel.frameLevel)
	else
		castbar:SetFrameLevel(6)
	end
end

local function ConfigureCastbarShadow(unit, unitframe)
	if not BUI.ShadowMode then return end
	local castbar = unitframe.Castbar
	local db = E.db.unitframe.units[unit].castbar;

	if not castbar.backdrop.shadow then return end

	if db.overlayOnFrame == 'None' then
		castbar.backdrop.shadow:Show()
	else
		castbar.backdrop.shadow:Hide()
		if not db.iconAttached then
			castbar.ButtonIcon.bg.shadow:Show()
		else
			castbar.ButtonIcon.bg.shadow:Hide()
		end
	end

	if not db.iconAttached and db.icon then
		local attachPoint = db.iconAttachedTo == "Frame" and unitframe or unitframe.Castbar
		local anchorPoint = db.iconPosition
		castbar.ButtonIcon.bg:ClearAllPoints()
		castbar.ButtonIcon.bg:Point(INVERT_ANCHORPOINT[anchorPoint], attachPoint, anchorPoint, db.iconXOffset, db.iconYOffset)
	elseif(db.icon) then
		castbar.ButtonIcon.bg:ClearAllPoints()
		if unitframe.ORIENTATION == "RIGHT" then
			castbar.ButtonIcon.bg:Point("LEFT", castbar, "RIGHT", (UF.SPACING*3), 0)
		else
			castbar.ButtonIcon.bg:Point("RIGHT", castbar, "LEFT", -(UF.SPACING*3), 0)
		end
	end
end

--Initiate update/reset of castbar
local function ConfigureCastbar(unit, unitframe)
	local db = E.db.unitframe.units[unit].castbar;

	if unit == 'player' or unit == 'target' then
		ConfigureCastbarShadow(unit, unitframe)
		if unitframe.USE_INFO_PANEL and db.insideInfoPanel then
			if E.db.benikui.unitframes.castbar.text.ShowInfoText then
				changeCastbarLevel(unit, unitframe)
			else
				resetCastbarLevel(unit, unitframe)
			end
		else
			resetCastbarLevel(unit, unitframe)
		end
	elseif unit == "focus" or unit == "pet" then
		ConfigureCastbarShadow(unit, unitframe)
	elseif unit == "arena" then
		for i = 1, 5 do
			local unitframe = _G["ElvUF_Arena"..i]
			ConfigureCastbarShadow(unit, unitframe)
		end
	end
end

--Initiate update of unit
function mod:UpdateSettings(unit)
	if unit == 'player' or unit == 'target' then
		local unitFrameName = "ElvUF_"..E:StringTitle(unit)
		local unitframe = _G[unitFrameName]
		ConfigureCastbar(unit, unitframe)
	end
end

-- Function to be called when registered events fire
function mod:UpdateAllCastbars()
	mod:UpdateSettings("player")
	mod:UpdateSettings("target")
	mod:UpdateSettings("focus")
	mod:UpdateSettings("pet")
	mod:UpdateSettings("arena")
end

--Castbar texture
function mod:PostCast(unit, unitframe)
	local castTexture = LSM:Fetch("statusbar", E.db.benikui.unitframes.textures.castbar)

	if not self.isTransparent then
		self:SetStatusBarTexture(castTexture)
	end
end

function mod:PostCastInterruptible(unit, unitframe)
	if unit == "vehicle" or unit == "player" then return end

	local castTexture = LSM:Fetch("statusbar", E.db.benikui.unitframes.textures.castbar)

	if not self.isTransparent then
		self:SetStatusBarTexture(castTexture)
	end
end

function mod:CastBarHooks()
	for _, unit in pairs(units) do
		local unitframe = _G["ElvUF_"..unit];
		local castbar = unitframe and unitframe.Castbar
		if castbar then
			if BUI.ShadowMode then
				castbar.backdrop:CreateSoftShadow()
				castbar.backdrop.shadow:SetFrameLevel(castbar.backdrop:GetFrameLevel())
				castbar.ButtonIcon.bg:CreateSoftShadow()
			end
			hooksecurefunc(castbar, "PostCastStart", mod.PostCast)
			hooksecurefunc(castbar, "PostCastInterruptible", mod.PostCastInterruptible)
		end
	end
end

function mod:Initialize()
	--ElvUI UnitFrames are not enabled, stop right here!
	if E.private.unitframe.enable ~= true then return end

	--Profile changed, update castbar overlay settings
	hooksecurefunc(E, "UpdateAll", function()
		--Delay it a bit to allow all db changes to take effect before we update
		self:ScheduleTimer('UpdateAllCastbars', 0.5)
	end)

	--Castbar was modified, re-apply settings
	hooksecurefunc(UF, "Configure_Castbar", function(self, frame)
		local unit = frame.unitframeType
		if unit and (unit == 'player' or unit == 'target') then
			mod:UpdateSettings(unit)
		end
	end)

	hooksecurefunc(UF, "LoadUnits", mod.CastBarHooks)
	hooksecurefunc(UF, "LoadUnits", mod.UpdateAllCastbars)
end

BUI:RegisterModule(mod:GetName())
