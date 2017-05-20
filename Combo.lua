--[[
Wisent - a framework for free positioning of buffs.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to:
	
Free Software Foundation, I.,
51 Franklin Street, Fifth Floor,
Boston, MA  02110-1301, USA.
--]]

local MAJOR = "combo"

local Addon  = LibStub( "AceAddon-3.0"):GetAddon( "Wisent")
local L      = LibStub( "AceLocale-3.0"):GetLocale( "Wisent")
local AceGUI = LibStub( "AceGUI-3.0")

local NOTHING = {}
local UPDATE_TIME = 0.2
local MAX_BUTTON  = 5

local Module = Addon:NewBarModule( MAJOR)
Module.filter  = "HELPFUL"
Module.color   = { r=0.2, g=0.4, b=0.9 }
Module.proName = "combo"

local args = {
	option = { 
		type = "group", order = 10, name = L.OptionName, inline = true, 
		args = {
			show     = { type = "toggle", order = 10, name = L.ShowName,     desc = L.ShowDesc, width = "full" },
--			sort     = { type = "select", order = 20, name = L.SortName,     desc = L.SortDesc, get = "GetSortType", set = "SetSortType", values = "GetSortDesc" },
			timer    = { type = "select", order = 30, name = L.TimerName,    desc = L.TimerDesc, values = "GetTimerDesc" },
			flashing = { type = "toggle", order = 40, name = L.FlashingName, desc = L.FlashingDesc },
--			spell    = { type = "toggle", order = 50, name = L.SpellName,    desc = L.SpellDesc },
		} 
	},
	layout = { 
		type = "group", order = 20, name = L.BarName, inline = true, 
		args = {
			horizontal = { type = "toggle", order = 10, name = L.HorizontalName, desc = L.HorizontalDesc, width = "full" },
--			number     = { type = "range",  order = 30, name = L.NumberName,     desc = L.NumberDesc,   set = "SetNumber",   min = 1,    max = MAX_BUTTON, step = 1 },
			scale      = { type = "range",  order = 40, name = L.ScaleName,      desc = L.ScaleDesc,    set = "SetScale",    min = 0.01, max = 2,          step = 0.01, isPercent = true },
			cols       = { type = "range",  order = 50, name = L.ColsName,       desc = L.ColsDesc,     set = "SetCols",     min = 1,    max = MAX_BUTTON, step = 1 },
			xPadding   = { type = "range",  order = 60, name = L.XPaddingName,   desc = L.XPaddingDesc, set = "SetXPadding", min = -20,  max = 20,         step = 1 },
			rows       = { type = "range",  order = 70, name = L.RowsName,       desc = L.RowsDesc,     set = "SetRows",     min = 1,    max = MAX_BUTTON, step = 1 },
			yPadding   = { type = "range",  order = 80, name = L.YPaddingName,   desc = L.YPaddingDesc, set = "SetYPadding", min = -50,  max = 50,         step = 1 },
			bigger     = { type = "range",  order = 90, name = L.BiggerName,     desc = L.BiggerDesc,   set = "SetBigger",   min = 1,    max = 2,          step = 0.01, isPercent = true },
		} 
	}
}
local blizzOptions = {
	type = "group", order = 50, name = L.DescProgs, handler = Module, get = "GetProperty", set = "SetProperty", args = args
}
local dialogOptions = {
	type = "group", order = 20, name = L.BarCombo, handler = Module, get = "GetProperty", set = "SetProperty", args = args,
	plugins = {
		p1 = { 
			descr = { type = "description", order = 5, name = L.DescProgs, fontSize = "large" }
		}
	}
}
local comboIcon
local comboSpell
local comboFkt
local comboCount = 5

------------------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------------------
function Module:OnModuleInitialize()
	self:RegisterOptions( blizzOptions, L.BarCombo)
	for i = 1,5 do
		tinsert( self.aura, { id = i, name = "__combo__", count = 1 })
	end
end

function Module:OnModuleEnable()
	self:ACTIVE_TALENT_GROUP_CHANGED()
	self:RegisterEvent( "ACTIVE_TALENT_GROUP_CHANGED")
end

function Module:GetOptionTable()
	return dialogOptions
end

function Module:UpdateAnchors( sort)
--	Addon:Debug( self, ":UpdateAnchors", self.profile.show)
	if self.profile.show and comboIcon and PlayerFrame.unit == "player" then
		local combos = comboFkt and comboFkt() or 0
--		Addon:Debug( self, ":UpdateAnchors", combos)
		for i,a in pairs( self.aura) do
			local buff = self:GetUserBuff( "BuffComboButton", a.id)
			local child = self.group.children[i]
			child:SetUserData( "bigger", i == comboCount)
			if child and i <= combos then
				buff:SetScript( "OnEnter", nil)
				a.texture = comboIcon
				self:UpdateLBF( buff)
					-- MOD
			self:UpdateMasque(buff)
			-- /MOD
				buff:Show()
				local icon = _G[buff:GetName().."Icon"]
				if icon then
					icon:SetTexture( a.texture)
				end
--				if GameTooltip:IsOwned( buff) and comboSpell then
--					GameTooltip:SetSpell( comboSpell, "spell")
--				end
				child:SetBuff( buff)
			elseif child then
				a.texture = nil
				buff:Hide()
				child:SetBuff( nil)
			else
				a.texture = nil
				buff:Hide()
			end
		end
	end
end

function Module:UpdateEnchantAnchors()
	self:UpdateAnchors()
end

function Module:MoveTo( offset)
	for i,child in pairs( self.group.children) do
		child:SetBuff( nil)
	end
	for id = 1,#self.aura do
		local buff = self:GetUserBuff( "BuffComboButton", id)
		buff:Hide()
		buff.duration:Hide()
		buff:SetScript( "OnUpdate", nil)
	end
end

------------------------------------------------------------------------------------
-- Local
------------------------------------------------------------------------------------
local function ScanAura( unit, id, filter)
	local name = GetSpellInfo( id)
	local _, _, _, count = UnitAura( unit, name, nil, filter)
	return count or 0
end

local function PointsNothing()
	return 0
end

local function PointsDeathKnight()
	return ScanAura( "pet", 91342, "HELPFUL") -- Shadow Infusion
end

local function PointsDruidBear()
	return ScanAura( "target", 33745, "HARMFUL") -- Lacerate
end

local function PointsDruidCat()
	return GetComboPoints( "player")
end

local function PointsHunterMarksman()
	return ScanAura( "player", 82925, "HELPFUL") -- Ready, Set, Aim...
end

local function PointsHunterBeastMaster()
	return ScanAura( "pet", 19615, "HELPFUL") -- Frenzy Effect
end

local function PointsPaladin()
	return UnitPower( "player", SPELL_POWER_HOLY_POWER)
end

local function PointsPriestShadow()
	return ScanAura( "player", 77487, "HELPFUL") -- Shadow Orbs
end

local function PointsPriestEvangelism()
	return ScanAura( "player", 81661, "HELPFUL") -- Evangelism
end

local function PointsRouge()
	return GetComboPoints( "player")
end

local function PointsShamanElemental()
	local count = ScanAura( "player", 324, "HELPFUL") -- Lightning Shield
	return count > 0 and (4 - count) or 0
end

local function PointsShamanEnhancement()
	return ScanAura( "player", 53817, "HELPFUL") -- Maelstrom Weapon
end

local function PointsWarlock()
	return UnitPower( "player", SPELL_POWER_SOUL_SHARDS)
end

------------------------------------------------------------------------------------
-- Event
------------------------------------------------------------------------------------
function Module:ACTIVE_TALENT_GROUP_CHANGED()
	Addon:Debug( self, ":ACTIVE_TALENT_GROUP_CHANGED")
	local _, class = UnitClass( "player")
	if class == "DEATHKNIGHT" then
		comboFkt   = PointsDeathKnight
		comboIcon  = "Interface\\ICONS\\Spell_Shadow_Requiem"
		comboSpell = 91342
		comboCount = 5
--		self:RegisterEvent( "UNIT_AURA", "UpdateAnchors")
	elseif class == "DRUID" then
		if GetShapeshiftFormID() == BEAR_FORM then
			comboFkt   = PointsDruidBear
			comboIcon  = "Interface\\ICONS\\Ability_Druid_Lacerate"
			comboSpell = 33745
			comboCount = 3
--			self:RegisterEvent( "UNIT_AURA", "UpdateAnchors")
--			self:UnRegisterEvent( "UNIT_COMBO_POINTS", "UpdateAnchors")
		elseif GetShapeshiftFormID() == CAT_FORM then
			comboFkt   = PointsDruidCat
			comboIcon  = "Interface\\ICONS\\Ability_DualWield"
			comboSpell = nil
			comboCount = 5
--			self:UnRegisterEvent( "UNIT_AURA", "UpdateAnchors")
--			self:RegisterEvent( "UNIT_COMBO_POINTS", "UpdateAnchors")
		else
			comboFkt   = PointsNothing
			comboCount = 5
		end
--		self:RegisterEvent( "PLAYER_TARGET_CHANGED", "UpdateAnchors")
		self:RegisterEvent( "UPDATE_SHAPESHIFT_FORM")
	elseif class == "HUNTER" then
		if IsSpellKnown( 19434) then		-- Aimed Shot
			comboFkt   = PointsHunterMarksman
			comboIcon  = "Interface\\ICONS\\Ability_Hunter_MasterMarksman"
			comboSpell = 82925
--			self:RegisterEvent( "UNIT_AURA", "UpdateAnchors")
		elseif IsSpellKnown( 19577) then	-- Intimidation
			comboFkt   = PointsHunterBeastMaster
			comboIcon  = "Interface\\ICONS\\INV_Misc_MonsterClaw_03"
			comboSpell = 19615
--			self:RegisterEvent( "UNIT_AURA", "UpdateAnchors")
		end
		comboCount = 5
--	elseif class == "MAGE" then
	elseif class == "PALADIN" then
		comboFkt   = PointsPaladin
		comboIcon = "Interface\\ICONS\\Spell_Holy_HolyBolt"
--		comboSpell = 19615
		comboCount = 3
--		self:RegisterEvent( "UNIT_POWER", "UpdateAnchors")
	elseif class == "PRIEST" then
		if IsSpellKnown( 15407) then -- Mind Flay
			comboFkt   = PointsPriestShadow
			comboIcon  = "Interface\\ICONS\\Spell_Priest_ShadowOrbs"
			comboSpell = 95740
			comboCount = 3
		else
			comboFkt   = PointsPriestEvangelism
			comboIcon  = "Interface\\ICONS\\Spell_Holy_DivineIllumination"
			comboSpell = 81661
			comboCount = 5
		end
--		self:RegisterEvent( "UNIT_AURA", "UpdateAnchors")
	elseif class == "ROGUE" then
		comboFkt   = PointsRouge
		comboIcon  = "Interface\\ICONS\\Ability_DualWield"
		comboSpell = nil
		comboCount = 5
--		self:RegisterEvent( "UNIT_COMBO_POINTS", "UpdateAnchors")
--		self:RegisterEvent( "PLAYER_TARGET_CHANGED", "UpdateAnchors")
	elseif class == "SHAMAN" then
		if IsSpellKnown( 51490) then -- Thunderstorm
			comboFkt   = PointsShamanElemental
			comboIcon  = "Interface\\ICONS\\Spell_Nature_LightningShield"
			comboSpell = 324
		elseif IsSpellKnown( 51528) then -- Maelstrom Weapon
			comboFkt   = PointsShamanEnhancement
			comboIcon  = "Interface\\ICONS\\Spell_Shaman_MaelstromWeapon"
			comboSpell = 53817
		else
			comboFkt   = PointsNothing
		end
		comboCount = 5
--		self:RegisterEvent( "UNIT_AURA", "UpdateAnchors")
	elseif class == "WARLOCK" then
		comboFkt   = PointsWarlock
		comboIcon  = "Interface\\ICONS\\INV_Misc_Gem_Amethyst_02"
		comboCount = 3
--		self:RegisterEvent( "UNIT_POWER", "UpdateAnchors")
--	elseif class == "WARRIOR" then
	else
		comboFkt   = PointsNothing
		comboCount = 5
	end
end

function Module:UPDATE_SHAPESHIFT_FORM()
	self:ACTIVE_TALENT_GROUP_CHANGED()
end
