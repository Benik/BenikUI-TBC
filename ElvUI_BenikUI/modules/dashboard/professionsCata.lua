local BUI, E, L, V, P, G = unpack((select(2, ...)))
local mod = BUI:GetModule('Dashboards');
local DT = E:GetModule('DataTexts');
local LSM = E.Libs.LSM

local getn = getn
local pairs, ipairs = pairs, ipairs
local tinsert, twipe, tsort = table.insert, table.wipe, table.sort

local UIFrameFadeIn, UIFrameFadeOut = UIFrameFadeIn, UIFrameFadeOut
local GetProfessions = GetProfessions
local GetProfessionInfo = GetProfessionInfo
local CastSpellByName = CastSpellByName
local TRADE_SKILLS = TRADE_SKILLS

-- GLOBALS: hooksecurefunc

local DASH_HEIGHT = 20
local DASH_SPACING = 3
local SPACING = 1

local classColor = E.myclass == 'PRIEST' and E.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[E.myclass] or RAID_CLASS_COLORS[E.myclass])

local function sortFunction(a, b)
	return a.name < b.name
end

local function OnMouseUp(self, btn)
	if InCombatLockdown() then return end

	if btn == "RightButton" then
		E:ToggleOptions()
		local ACD = E.Libs.AceConfigDialog
		if ACD then ACD:SelectGroup("ElvUI", "benikui", "dashboards", "professions") end
	else
		CastSpellByName(self.name)
	end
end

function mod:UpdateCataProfessions()
	local db = E.db.benikui.dashboards
	local holder = BUI_ProfessionsDashboard

	if(BUI.ProfessionsDB[1]) then
		for i = 1, getn(BUI.ProfessionsDB) do
			BUI.ProfessionsDB[i]:Kill()
		end
		wipe(BUI.ProfessionsDB)
		holder:Hide()
	end

	if db.professions.mouseover then holder:SetAlpha(0) else holder:SetAlpha(1) end

	local prof1, prof2, archy, fishing, cooking, firstAid = GetProfessions()
	if (prof1 or prof2 or archy or fishing or cooking or firstAid) then
		local proftable = { GetProfessions() }

		for _, id in pairs(proftable) do
			local name, icon, rank, maxRank, _, _, _, rankModifier = GetProfessionInfo(id)
			if name and (rank < maxRank or (not db.capped)) then
				if E.private.dashboards.professions.chooseProfessions[id] == true then
					holder:Show()
					holder:Height(((DASH_HEIGHT + (E.PixelMode and 1 or DASH_SPACING)) * (#BUI.ProfessionsDB + 1)) + DASH_SPACING + (E.PixelMode and 0 or 2))
					if ProfessionsMover then
						ProfessionsMover:Size(holder:GetSize())
						holder:Point('TOPLEFT', ProfessionsMover, 'TOPLEFT')
					end

					local bar = self:CreateDashboard(holder, 'professions', true)

					bar:SetScript('OnMouseUp', OnMouseUp)

					local RankModifier = (rankModifier and rankModifier > 0)
					local MaxValue = (RankModifier and (maxRank + rankModifier)) or maxRank
					local StatusBarValue = (RankModifier and (rank + rankModifier)) or rank
					local BarColor = (db.barColor == 1 and classColor) or db.customBarColor
					local TextColor = (db.textColor == 1 and classColor) or db.customTextColor
					local displayString = ''

					bar.Status:SetMinMaxValues(1, MaxValue)
					bar.Status:SetValue(StatusBarValue)
					bar.Status:SetStatusBarColor(BarColor.r, BarColor.g, BarColor.b)

					if RankModifier then
						displayString = format('%s: %s |cFF6b8df4+%s|r / %s', name, rank, rankModifier, maxRank)
					else
						displayString = format('%s: %s / %s', name, rank, maxRank)
					end

					bar.Text:SetText(displayString)
					bar.Text:SetTextColor(TextColor.r, TextColor.g, TextColor.b)
					bar.IconBG.Icon:SetTexture(icon)

					bar.db = db
					bar.name = name
					bar.rank = rank
					bar.maxRank = maxRank
					bar.rankModifier = rankModifier

					tinsert(BUI.ProfessionsDB, bar)
				end
			end
		end
	end

	tsort(BUI.ProfessionsDB, sortFunction)

	for key, frame in ipairs(BUI.ProfessionsDB) do
		frame:ClearAllPoints()
		if(key == 1) then
			frame:Point( 'TOPLEFT', holder, 'TOPLEFT', 0, -SPACING -(E.PixelMode and 0 or 4))
		else
			frame:Point('TOP', BUI.ProfessionsDB[key - 1], 'BOTTOM', 0, -SPACING -(E.PixelMode and 0 or 2))
		end
	end
	mod:FontStyle(BUI.ProfessionsDB)
end

function mod:UpdateCataProfessionSettings()
	mod:FontStyle(BUI.ProfessionsDB)
	mod:FontColor(BUI.ProfessionsDB)
	mod:BarColor(BUI.ProfessionsDB)
end

function mod:CataProfessionsEvents()
	self:RegisterEvent('SKILL_LINES_CHANGED', 'UpdateProfessions')
	self:RegisterEvent('CHAT_MSG_SKILL', 'UpdateProfessions')
end

function mod:CreateCataProfessionsDashboard()
	local mapholderWidth = E.private.general.minimap.enable and _G.ElvUI_MinimapHolder:GetWidth() or 150
	local DASH_WIDTH = E.db.benikui.dashboards.professions.width or 150

	self.proHolder = self:CreateDashboardHolder('BUI_ProfessionsDashboard', 'professions')

	if E.private.general.minimap.enable then
		self.proHolder:Point('TOPLEFT', _G.ElvUI_MinimapHolder, 'BOTTOMLEFT', 0, -5)
	else
		self.proHolder:Point('TOPLEFT', E.UIParent, 'TOPLEFT', 2, -120)
	end
	self.proHolder:Width(mapholderWidth or DASH_WIDTH)

	mod:UpdateCataProfessions()
	mod:UpdateCataProfessionSettings()
	mod:UpdateHolderDimensions(self.proHolder, 'professions', BUI.ProfessionsDB)
	mod:ToggleStyle(self.proHolder, 'professions')
	mod:ToggleTransparency(self.proHolder, 'professions')

	E:CreateMover(self.proHolder, 'ProfessionsMover', TRADE_SKILLS, nil, nil, nil, 'ALL,BenikUI', nil, 'benikui,dashboards,professions')
end

function mod:LoadCataProfessions()
	if E.db.benikui.dashboards.professions.enableProfessions ~= true then return end

	mod:CreateCataProfessionsDashboard()
	mod:CataProfessionsEvents()

	hooksecurefunc(DT, 'LoadDataTexts', mod.UpdateCataProfessionSettings)
end