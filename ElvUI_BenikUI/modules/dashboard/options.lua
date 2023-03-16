local BUI, E, _, V, P, G = unpack((select(2, ...)))
local L = E.Libs.ACL:GetLocale('ElvUI', E.global.general.locale or 'enUS');
local BUID = BUI:GetModule('Dashboards');

local tinsert, pairs, ipairs, gsub, unpack, format = table.insert, pairs, ipairs, gsub, unpack, string.format
local GetProfessions = GetProfessions
local GetProfessionInfo = GetProfessionInfo

local PROFESSIONS_MISSING_PROFESSION = PROFESSIONS_MISSING_PROFESSION
local CALENDAR_TYPE_DUNGEON, CALENDAR_TYPE_RAID, PLAYER_V_PLAYER, SECONDARY_SKILLS, TRADE_SKILLS = CALENDAR_TYPE_DUNGEON, CALENDAR_TYPE_RAID, PLAYER_V_PLAYER, SECONDARY_SKILLS, TRADE_SKILLS

-- GLOBALS: AceGUIWidgetLSMlists, hooksecurefunc

local boards = {L["FPS"], L["MS"], L["Durability"], L["Bags"], L["Volume"]}

local iconOrientationValues = {
	['LEFT'] = L['Left'],
	['RIGHT'] = L['Right'],
}

local textAlignValues = {
	['CENTER'] = L['Center'],
	['LEFT'] = L['Left'],
	['RIGHT'] = L['Right'],
}

local dungeonTokens = {
	221, -- Emblem of Conquest
	341, -- Emblem of Frost
	101, -- Emblem of Heroism
	301, -- Emblem of Triumph
	102, -- Emblem of Valor
}

local pvpTokens = {
	121, -- Alterac Valley Mark of Honor
	122, -- Arathi Basin Mark of Honor
	--103, -- Arena Points
	123, -- Eye of the Storm Mark of Honor
	--104, -- Honor Points
	321, -- Isle of Conquest Mark of Honor
	161, -- Stone Keeper's Shard
	124, -- Strand of the Ancients Mark of Honor
	201, -- Venture Coin
	125, -- Warsong Gulch Mark of Honor
	126, -- Wintergrasp Mark of Honor
}

local miscTokens = {
	42, -- Badge of Justice
	241, -- Champion's Seal
	81, -- Dalaran Cooking Award
	61, -- Dalaran Jewelcrafter's Token
}

local currencyTables = {
	-- table, option, name
	{dungeonTokens, 'dungeonTokens', GROUP_FINDER},
	{pvpTokens, 'pvpTokens', PLAYER_V_PLAYER},
	{miscTokens, 'miscTokens', MISCELLANEOUS},
}

local function UpdateSystemOptions()
	for _, boardname in pairs(boards) do
		local optionOrder = 1
		E.Options.args.benikui.args.dashboards.args.system.args.chooseSystem.args[boardname] = {
			order = optionOrder + 1,
			type = 'toggle',
			name = boardname,
			desc = L['Enable/Disable ']..boardname,
			get = function(info) return E.db.benikui.dashboards.system.chooseSystem[boardname] end,
			set = function(info, value) E.db.benikui.dashboards.system.chooseSystem[boardname] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
		}
	end

	E.Options.args.benikui.args.dashboards.args.system.args.latency = {
		order = 10,
		type = "select",
		name = L['Latency (MS)'],
		values = {
			[1] = L.HOME,
			[2] = L.WORLD,
		},
		disabled = function() return not E.db.benikui.dashboards.system.chooseSystem.MS end,
		get = function(info) return E.db.benikui.dashboards.system.latency end,
		set = function(info, value) E.db.benikui.dashboards.system.latency = value; E:StaticPopup_Show('PRIVATE_RL'); end,
	}
end

local function UpdateTokenOptions()
	for i, v in ipairs(currencyTables) do
		local tableName, option, optionName = unpack(v)
		local optionOrder = 1
		for _, id in ipairs(tableName) do
			E.Options.args.benikui.args.dashboards.args.tokens.args[option] = {
				order = i,
				type = 'group',
				name = optionName,
				args = {
				},
			}
			for _, id in ipairs(tableName) do
				local tname, amount, icon, _, _, isDiscovered = BUID:GetTokenInfo(id)
				if tname then
					E.Options.args.benikui.args.dashboards.args.tokens.args[option].args.desc = {
						order = optionOrder + 1,
						name = BUI:cOption(L['Tip: Grayed tokens are not yet discovered'], "blue"),
						type = 'header',
					}
					E.Options.args.benikui.args.dashboards.args.tokens.args[option].args[tname] = {
						order = optionOrder + 2,
						type = 'toggle',
						name = (icon and '|T'..icon..':18|t '..tname) or tname,
						desc = format('%s %s\n\n|cffffff00%s: %s|r', L['Enable/Disable'], tname, L['Amount'], BreakUpLargeNumbers(amount)),
						get = function(info) return E.private.dashboards.tokens.chooseTokens[id] end,
						set = function(info, value) E.private.dashboards.tokens.chooseTokens[id] = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
						disabled = function() return not isDiscovered end,
					}
				end
			end
		end
	end
end

local function UpdateProfessionOptions()
	local optionOrder = 1
	E.Options.args.benikui.args.dashboards.args.professions.args.chooseProfessions = {
		order = 50,
		type = 'group',
		guiInline = true,
		name = L['Select Professions'],
		disabled = function() return not E.db.benikui.dashboards.professions.enableProfessions end,
		args = {
		},
	}

	local hasSecondary = false
	for skillIndex = 1, GetNumSkillLines() do
		local skillName, isHeader, _, skillRank, _, skillModifier, skillMaxRank, isAbandonable = GetSkillLineInfo(skillIndex)

		if hasSecondary and isHeader then
			hasSecondary = false
		end

		if (skillName and isAbandonable) or hasSecondary then
			E.Options.args.benikui.args.dashboards.args.professions.args.chooseProfessions.args[skillName] = {
				order = optionOrder + 1,
				type = 'toggle',
				name = skillName,
				desc = L['Enable/Disable '] .. skillName,
				get = function(info)
					return E.private.dashboards.professions.chooseProfessions[skillIndex]
				end,
				set = function(info, value)
					E.private.dashboards.professions.chooseProfessions[skillIndex] = value;
					BUID:UpdateProfessions();
					BUID:UpdateProfessionSettings();
				end,
			}
		end

		if isHeader then
			if skillName == BUI.SecondarySkill then
				hasSecondary = true
			end
		end
	end
end

local function UpdateReputationOptions()
	local optionOrder = 30

	for i, info in ipairs(BUI.ReputationsList) do
		local optionOrder = 1
		local name, factionID, headerIndex, isHeader, hasRep, isChild = unpack(info)

		if isHeader and not (hasRep or isChild) then
			E.Options.args.benikui.args.dashboards.args.reputations.args[tostring(headerIndex)] = {
				order = optionOrder + 1,
				type = 'group',
				name = name,
				args = {
				},
			}
		elseif headerIndex then
			E.Options.args.benikui.args.dashboards.args.reputations.args[tostring(headerIndex)].args[tostring(i)] = {
				order = optionOrder + 2,
				type = 'toggle',
				name = name,
				desc = format('%s %s', L['Enable/Disable'], name),
				disabled = function() return not E.db.benikui.dashboards.reputations.enableReputations end,
				get = function(info) return E.private.dashboards.reputations.chooseReputations[factionID] end,
				set = function(info, value) E.private.dashboards.reputations.chooseReputations[factionID] = value; BUID:UpdateReputations(); BUID:UpdateReputationSettings(); end,
			}
		end
	end
end

local function UpdateAllDashboards()
	if E.db.benikui.dashboards.professions.enableProfessions then BUID:UpdateProfessionSettings(); end
	if E.Wrath and E.db.benikui.dashboards.tokens.enableTokens then BUID:UpdateTokenSettings(); end
	if E.db.benikui.dashboards.system.enableSystem then BUID:UpdateSystemSettings(); end
	if E.db.benikui.dashboards.reputations.enableReputations then BUID:UpdateReputationSettings(); end
end

local function dashboardsTable()
	E.Options.args.benikui.args.dashboards = {
		order = 60,
		type = 'group',
		name = BUI:cOption(L['Dashboards'], "orange"),
		args = {
			dashColor = {
				order = 1,
				type = 'group',
				name = L.COLOR,
				guiInline = true,
				args = {
					barColor = {
						type = "select",
						order = 1,
						name = L['Bar Color'],
						values = {
							[1] = L.CLASS_COLORS,
							[2] = L.CUSTOM,
						},
						get = function(info) return E.db.benikui.dashboards[ info[#info] ] end,
						set = function(info, value) E.db.benikui.dashboards[ info[#info] ] = value;
							UpdateAllDashboards()
						end,
					},
					customBarColor = {
						order = 2,
						type = "color",
						name = COLOR_PICKER,
						disabled = function() return E.db.benikui.dashboards.barColor == 1 end,
						get = function(info)
							local t = E.db.benikui.dashboards[ info[#info] ]
							local d = P.benikui.dashboards[info[#info]]
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b
						end,
						set = function(info, r, g, b, a)
							E.db.benikui.dashboards[ info[#info] ] = {}
							local t = E.db.benikui.dashboards[ info[#info] ]
							t.r, t.g, t.b, t.a = r, g, b, a
							UpdateAllDashboards()
						end,
					},
					spacer = {
						order = 3,
						type = 'header',
						name = '',
					},
					textColor = {
						order = 4,
						type = "select",
						name = L['Text Color'],
						values = {
							[1] = L.CLASS_COLORS,
							[2] = L.CUSTOM,
						},
						get = function(info) return E.db.benikui.dashboards[ info[#info] ] end,
						set = function(info, value) E.db.benikui.dashboards[ info[#info] ] = value;
							UpdateAllDashboards()
						end,
					},
					customTextColor = {
						order = 5,
						type = "color",
						name = L.COLOR_PICKER,
						disabled = function() return E.db.benikui.dashboards.textColor == 1 end,
						get = function(info)
							local t = E.db.benikui.dashboards[ info[#info] ]
							local d = P.benikui.dashboards[info[#info]]
							return t.r, t.g, t.b, t.a, d.r, d.g, d.b
							end,
						set = function(info, r, g, b, a)
							E.db.benikui.dashboards[ info[#info] ] = {}
							local t = E.db.benikui.dashboards[ info[#info] ]
							t.r, t.g, t.b, t.a = r, g, b, a
							UpdateAllDashboards()
						end,
					},
				},
			},
			dashfont = {
				order = 2,
				type = 'group',
				name = L['Fonts'],
				guiInline = true,
				disabled = function() return not E.db.benikui.dashboards.system.enableSystem and not E.db.benikui.dashboards.tokens.enableTokens and not E.db.benikui.dashboards.professions.enableProfessions end,
				get = function(info) return E.db.benikui.dashboards.dashfont[ info[#info] ] end,
				set = function(info, value) E.db.benikui.dashboards.dashfont[ info[#info] ] = value;
					UpdateAllDashboards()
				end,
				args = {
					useDTfont = {
						order = 1,
						name = L['Use DataTexts font'],
						type = 'toggle',
						width = 'full',
					},
					dbfont = {
						type = 'select', dialogControl = 'LSM30_Font',
						order = 2,
						name = L['Font'],
						desc = L['Choose font for all dashboards.'],
						disabled = function() return E.db.benikui.dashboards.dashfont.useDTfont end,
						values = AceGUIWidgetLSMlists.font,
					},
					dbfontsize = {
						order = 3,
						name = L.FONT_SIZE,
						desc = L['Set the font size.'],
						disabled = function() return E.db.benikui.dashboards.dashfont.useDTfont end,
						type = 'range',
						min = 6, max = 22, step = 1,
					},
					dbfontflags = {
						order = 4,
						name = L['Font Outline'],
						disabled = function() return E.db.benikui.dashboards.dashfont.useDTfont end,
						type = 'select',
						values = E.Config[1].Values.FontFlags,
					},
				},
			},
			system = {
				order = 3,
				type = 'group',
				name = L['System'],
				args = {
					enableSystem = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						width = 'full',
						desc = L['Enable the System Dashboard.'],
						get = function(info) return E.db.benikui.dashboards.system.enableSystem end,
						set = function(info, value) E.db.benikui.dashboards.system.enableSystem = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					variousGroup = {
						order = 2,
						type = 'group',
						name = ' ',
						guiInline = true,
						disabled = function() return not E.db.benikui.dashboards.system.enableSystem end,
						args = {
							width = {
								order = 1,
								type = 'range',
								name = L['Width'],
								desc = L['Change the System Dashboard width.'],
								min = 120, max = 520, step = 1,
								get = function(info) return E.db.benikui.dashboards.system[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.system[ info[#info] ] = value; BUID:UpdateHolderDimensions(BUI_SystemDashboard, 'system', BUI.SystemDB); BUID:UpdateSystemSettings(); end,
							},
							textAlign ={
								order = 2,
								name = E.NewSign..L['Text Alignment'],
								type = 'select',
								values = textAlignValues,
								get = function(info) return E.db.benikui.dashboards.system[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.system[ info[#info] ] = value BUID:UpdateSystemTextAlignment() end,
							},
							barHeight = {
								order = 3,
								type = 'range',
								name = L['Bar Height'],
								desc = L['Change the Bar Height.'],
								min = 1, max = 20, step = 1,
								get = function(info) return E.db.benikui.dashboards.system[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.system[ info[#info] ] = value; BUID:BarHeight('system', BUI.SystemDB); end,
							},
							layoutOptions = {
								order = 4,
								type = 'multiselect',
								name = L['Layout'],
								disabled = function() return not E.db.benikui.dashboards.system.enableSystem end,
								get = function(_, key) return E.db.benikui.dashboards.system[key] end,
								set = function(_, key, value) E.db.benikui.dashboards.system[key] = value; BUID:ToggleStyle(BUI_SystemDashboard, 'system') BUID:ToggleTransparency(BUI_SystemDashboard, 'system') end,
								values = {
									style = L['BenikUI Style'],
									transparency = L['Panel Transparency'],
									backdrop = L['Backdrop'],
								}
							},
							variousGroup = {
								order = 5,
								type = 'group',
								name = ' ',
								guiInline = true,
								disabled = function() return not E.db.benikui.dashboards.system.enableSystem end,
								args = {
									combat = {
										order = 1,
										name = L['Combat Fade'],
										desc = L['Show/Hide System Dashboard when in combat'],
										type = 'toggle',
										get = function(info) return E.db.benikui.dashboards.system[ info[#info] ] end,
										set = function(info, value) E.db.benikui.dashboards.system[ info[#info] ] = value; BUID:EnableDisableCombat(BUI_SystemDashboard, 'system'); end,
									},
									mouseover = {
										order = 2,
										name = L['Mouse Over'],
										desc = L['The frame is not shown unless you mouse over the frame.'],
										type = 'toggle',
										get = function(info) return E.db.benikui.dashboards.system[ info[#info] ] end,
										set = function(info, value) E.db.benikui.dashboards.system[ info[#info] ] = value; BUID:UpdateSystemSettings() end,
									},
								},
							},
						},
					},
					spacer = {
						order = 10,
						type = 'header',
						name = '',
					},
					chooseSystem = {
						order = 20,
						type = 'group',
						guiInline = true,
						name = L['Select System Board'],
						disabled = function() return not E.db.benikui.dashboards.system.enableSystem end,
						args = {
						},
					},
				},
			},
			tokens = {
				order = 4,
				type = 'group',
				name = TOKENS,
				childGroups = 'select',
				args = {
					enableTokens = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						width = 'full',
						desc = L['Enable the Tokens Dashboard.'],
						get = function(info) return E.db.benikui.dashboards.tokens.enableTokens end,
						set = function(info, value) E.db.benikui.dashboards.tokens.enableTokens = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					sizeGroup = {
						order = 2,
						type = 'group',
						name = ' ',
						guiInline = true,
						disabled = function() return not E.db.benikui.dashboards.tokens.enableTokens end,
						args = {
							width = {
								order = 1,
								type = 'range',
								name = L['Width'],
								desc = L['Change the Tokens Dashboard width.'],
								min = 120, max = 520, step = 1,
								get = function(info) return E.db.benikui.dashboards.tokens[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.tokens[ info[#info] ] = value; BUID:UpdateHolderDimensions(BUI_TokensDashboard, 'tokens', BUI.TokensDB); BUID:UpdateTokenSettings(); end,
							},
							iconPosition = {
								order = 2,
								type = 'select',
								name = L['Icon Position'],
								get = function(info) return E.db.benikui.dashboards.tokens[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.tokens[ info[#info] ] = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
								values = iconOrientationValues,
							},
							barHeight = {
								order = 3,
								type = 'range',
								name = L['Bar Height'],
								desc = L['Change the Bar Height.'],
								min = 1, max = 20, step = 1,
								get = function(info) return E.db.benikui.dashboards.tokens[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.tokens[ info[#info] ] = value; BUID:BarHeight('tokens', BUI.TokensDB); end,
							},
						},
					},
					layoutOptions = {
						order = 3,
						type = 'multiselect',
						name = L['Layout'],
						disabled = function() return not E.db.benikui.dashboards.tokens.enableTokens end,
						get = function(_, key) return E.db.benikui.dashboards.tokens[key] end,
						set = function(_, key, value) E.db.benikui.dashboards.tokens[key] = value; BUID:ToggleStyle(BUI_TokensDashboard, 'tokens') BUID:ToggleTransparency(BUI_TokensDashboard, 'tokens') end,
						values = {
							style = L['BenikUI Style'],
							transparency = L['Panel Transparency'],
							backdrop = L['Backdrop'],
						},
					},
					variousGroup = {
						order = 4,
						type = 'group',
						name = ' ',
						guiInline = true,
						disabled = function() return not E.db.benikui.dashboards.tokens.enableTokens end,
						args = {
							zeroamount = {
								order = 1,
								name = L['Show zero amount tokens'],
								desc = L['Show the token, even if the amount is 0'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.tokens[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.tokens[ info[#info] ] = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
							},
							weekly = {
								order =2,
								name = L['Show Weekly max'],
								desc = L['Show Weekly max tokens instead of total max'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.tokens[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.tokens[ info[#info] ] = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
							},
							combat = {
								order = 3,
								name = L['Combat Fade'],
								desc = L['Show/Hide Tokens Dashboard when in combat'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.tokens[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.tokens[ info[#info] ] = value; BUID:EnableDisableCombat(BUI_TokensDashboard, 'tokens'); end,
							},
							mouseover = {
								order = 4,
								name = L['Mouse Over'],
								desc = L['The frame is not shown unless you mouse over the frame.'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.tokens[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.tokens[ info[#info] ] = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
							},
							tooltip = {
								order = 5,
								name = L['Tooltip'],
								desc = L['Show/Hide Tooltips'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.tokens[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.tokens[ info[#info] ] = value; BUID:UpdateTokens(); BUID:UpdateTokenSettings(); end,
							},
						},
					},
					spacer = {
						order = 10,
						type = 'header',
						name = '',
					},
				},
			},
			professions = {
				order = 5,
				type = 'group',
				name = TRADE_SKILLS,
				args = {
					enableProfessions = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						width = 'full',
						desc = L['Enable the Professions Dashboard.'],
						get = function(info) return E.db.benikui.dashboards.professions[ info[#info] ] end,
						set = function(info, value) E.db.benikui.dashboards.professions[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					sizeGroup = {
						order = 2,
						type = 'group',
						name = ' ',
						guiInline = true,
						disabled = function() return not E.db.benikui.dashboards.professions.enableProfessions end,
						args = {
							width = {
								order = 1,
								type = 'range',
								name = L['Width'],
								desc = L['Change the Professions Dashboard width.'],
								min = 120, max = 520, step = 1,
								get = function(info) return E.db.benikui.dashboards.professions[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.professions[ info[#info] ] = value; BUID:UpdateHolderDimensions(BUI_ProfessionsDashboard, 'professions', BUI.ProfessionsDB); BUID:UpdateProfessionSettings(); end,
							},
							iconPosition = {
								order = 2,
								type = 'select',
								name = L['Icon Position'],
								get = function(info) return E.db.benikui.dashboards.professions[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.professions[ info[#info] ] = value; BUID:UpdateProfessions(); BUID:UpdateProfessionSettings(); end,
								values = iconOrientationValues,
							},
							barHeight = {
								order = 3,
								type = 'range',
								name = L['Bar Height'],
								desc = L['Change the Bar Height.'],
								min = 1, max = 20, step = 1,
								get = function(info) return E.db.benikui.dashboards.professions[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.professions[ info[#info] ] = value; BUID:BarHeight('professions', BUI.ProfessionsDB); end,
							},
						},
					},
					layoutOptions = {
						order = 3,
						type = 'multiselect',
						name = L['Layout'],
						disabled = function() return not E.db.benikui.dashboards.professions.enableProfessions end,
						get = function(_, key) return E.db.benikui.dashboards.professions[key] end,
						set = function(_, key, value) E.db.benikui.dashboards.professions[key] = value; BUID:ToggleStyle(BUI_ProfessionsDashboard, 'professions') BUID:ToggleTransparency(BUI_ProfessionsDashboard, 'professions') end,
						values = {
							style = L['BenikUI Style'],
							transparency = L['Panel Transparency'],
							backdrop = L['Backdrop'],
						}
					},
					variousGroup = {
						order = 4,
						type = 'group',
						name = ' ',
						guiInline = true,
						disabled = function() return not E.db.benikui.dashboards.professions.enableProfessions end,
						args = {
							capped = {
								order = 1,
								name = L['Filter Capped'],
								desc = L['Show/Hide Professions that are skill capped'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.professions[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.professions[ info[#info] ] = value; BUID:UpdateProfessions(); BUID:UpdateProfessionSettings(); end,
							},
							combat = {
								order = 2,
								name = L['Combat Fade'],
								desc = L['Show/Hide Professions Dashboard when in combat'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.professions[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.professions[ info[#info] ] = value; BUID:EnableDisableCombat(BUI_ProfessionsDashboard, 'professions'); end,
							},
							mouseover = {
								order = 3,
								name = L['Mouse Over'],
								desc = L['The frame is not shown unless you mouse over the frame.'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.professions[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.professions[ info[#info] ] = value; BUID:UpdateProfessions(); BUID:UpdateProfessionSettings(); end,
							},
						},
					},
					spacer = {
						order = 10,
						type = 'header',
						name = '',
					},
				},
			},
			reputations = {
				order = 6,
				type = 'group',
				name = REPUTATION,
				childGroups = 'select',
				args = {
					enableReputations = {
						order = 1,
						type = 'toggle',
						name = L["Enable"],
						width = 'full',
						desc = L['Enable the Professions Dashboard.'],
						get = function(info) return E.db.benikui.dashboards.reputations[ info[#info] ] end,
						set = function(info, value) E.db.benikui.dashboards.reputations[ info[#info] ] = value; E:StaticPopup_Show('PRIVATE_RL'); end,
					},
					sizeGroup = {
						order = 2,
						type = 'group',
						name = ' ',
						guiInline = true,
						disabled = function() return not E.db.benikui.dashboards.reputations.enableReputations end,
						args = {
							width = {
								order = 1,
								type = 'range',
								name = L['Width'],
								desc = L['Change the Professions Dashboard width.'],
								min = 120, max = 520, step = 1,
								get = function(info) return E.db.benikui.dashboards.reputations[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.reputations[ info[#info] ] = value; BUID:UpdateHolderDimensions(BUI_ReputationsDashboard, 'reputations', BUI.FactionsDB); BUID:UpdateReputationSettings(); BUID:UpdateReputations(); end,
							},
							textAlign ={
								order = 2,
								name = L['Text Alignment'],
								type = 'select',
								values = textAlignValues,
								get = function(info) return E.db.benikui.dashboards.reputations[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.reputations[ info[#info] ] = value; BUID:UpdateReputations(); end,
							},
							barHeight = {
								order = 3,
								type = 'range',
								name = L['Bar Height'],
								desc = L['Change the Bar Height.'],
								min = 1, max = 20, step = 1,
								get = function(info) return E.db.benikui.dashboards.reputations[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.reputations[ info[#info] ] = value; BUID:BarHeight('reputations', BUI.FactionsDB); end,
							},
						},
					},
					layoutOptions = {
						order = 3,
						type = 'multiselect',
						name = L['Layout'],
						disabled = function() return not E.db.benikui.dashboards.reputations.enableReputations end,
						get = function(_, key) return E.db.benikui.dashboards.reputations[key] end,
						set = function(_, key, value) E.db.benikui.dashboards.reputations[key] = value; BUID:ToggleStyle(BUI_ReputationsDashboard, 'reputations') BUID:ToggleTransparency(BUI_ReputationsDashboard, 'reputations') end,
						values = {
							style = L['BenikUI Style'],
							transparency = L['Panel Transparency'],
							backdrop = L['Backdrop'],
						}
					},
					factionColors = {
						order = 4,
						type = 'multiselect',
						name = L['Faction Colors'],
						disabled = function() return not E.db.benikui.dashboards.reputations.enableReputations end,
						get = function(_, key) return E.db.benikui.dashboards.reputations[key] end,
						set = function(_, key, value) E.db.benikui.dashboards.reputations[key] = value; BUID:UpdateReputations(); BUID:UpdateReputationSettings(); end,
						values = {
							barFactionColors = L['Use Faction Colors on Bars'],
							textFactionColors = L['Use Faction Colors on Text'],
						}
					},
					variousGroup = {
						order = 5,
						type = 'group',
						name = ' ',
						guiInline = true,
						disabled = function() return not E.db.benikui.dashboards.reputations.enableReputations end,
						args = {
							combat = {
								order = 1,
								name = L['Hide In Combat'],
								desc = L['Show/Hide Reputations Dashboard when in combat'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.reputations[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.reputations[ info[#info] ] = value; BUID:EnableDisableCombat(BUI_ReputationsDashboard, 'reputations'); end,
							},
							mouseover = {
								order = 2,
								name = L['Mouse Over'],
								desc = L['The frame is not shown unless you mouse over the frame.'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.reputations[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.reputations[ info[#info] ] = value; BUID:UpdateReputations(); BUID:UpdateReputationSettings(); end,
							},
							tooltip = {
								order = 3,
								name = L['Tooltip'],
								type = 'toggle',
								get = function(info) return E.db.benikui.dashboards.reputations[ info[#info] ] end,
								set = function(info, value) E.db.benikui.dashboards.reputations[ info[#info] ] = value; BUID:UpdateReputations(); end,
							},
						},
					},
					spacer = {
						order = 20,
						type = 'header',
						name = '',
					},
				},
			},
		},
	}
end

tinsert(BUI.Config, dashboardsTable)
tinsert(BUI.Config, UpdateSystemOptions)
tinsert(BUI.Config, UpdateProfessionOptions)
tinsert(BUI.Config, UpdateReputationOptions)

tinsert(BUI.Config, dashboardsTable)
tinsert(BUI.Config, UpdateSystemOptions)
if E.Wrath then
	tinsert(BUI.Config, injectTokenSettings)
	tinsert(BUI.Config, UpdateTokenOptions)
end
tinsert(BUI.Config, UpdateProfessionOptions)
tinsert(BUI.Config, UpdateReputationOptions)