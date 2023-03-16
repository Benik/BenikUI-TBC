local BUI, E, _, V, P, G = unpack((select(2, ...)))
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale or 'enUS');

local tinsert = table.insert

local function miscTable()
	E.Options.args.benikui.args.misc = {
		order = 90,
		type = 'group',
		name = BUI:cOption(L["Miscellaneous"], "orange"),
		args = {
			flightMode = {
				order = 3,
				type = 'group',
				guiInline = true,
				name = L['Flight Mode'],
				args = {
					enable = {
						order = 1,
						type = 'toggle',
						name = L['Enable'],
						desc = L['Display the Flight Mode screen when taking flight paths'],
						get = function(info) return E.db.benikui.misc.flightMode[ info[#info] ] end,
						set = function(info, value) E.db.benikui.misc.flightMode[ info[#info] ] = value; BUI:GetModule('FlightMode'):Toggle() E:StaticPopup_Show('PRIVATE_RL') end,
					},
					logo = {
						order = 2,
						type = 'select',
						name = L['Shown Logo'],
						values = {
							['BENIKUI'] = L['BenikUI'],
							['WOW'] = L['WoW'],
							['NONE'] = NONE,
						},
						disabled = function() return not E.db.benikui.misc.flightMode.enable end,
						get = function(info) return E.db.benikui.misc.flightMode[ info[#info] ] end,
						set = function(info, value) E.db.benikui.misc.flightMode[ info[#info] ] = value; BUI:GetModule('FlightMode'):ToggleLogo() end,
					},
				},
			},
			afkModeGroup = {
				order = 4,
				type = 'group',
				guiInline = true,
				name = L['AFK Mode'],
				args = {
					afkMode = {
						order = 1,
						type = 'toggle',
						name = L['Enable'],
						get = function(info) return E.db.benikui.misc[ info[#info] ] end,
						set = function(info, value) E.db.benikui.misc[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL') end,
					},
				},
			},
		},
	}
end
tinsert(BUI.Config, miscTable)
