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

local MAJOR = "weapon"

local Addon  = LibStub( "AceAddon-3.0"):GetAddon( "Wisent")
local L      = LibStub( "AceLocale-3.0"):GetLocale( "Wisent")

local UPDATE_TIME = 0.2
local MAX_BUTTON  = 3

local Module = Addon:NewBarModule( MAJOR)
Module.color   = { r=0.2, g=0.2, b=0.2 }
Module.proName = "weapon"

local args = {
	option = { 
		type = "group", order = 10, name = L.OptionName, inline = true, 
		args = {
			show     = { type = "toggle", order = 10, name = L.ShowName,     desc = L.ShowDesc, width = "full" },
			sort     = { type = "select", order = 20, name = L.SortName,     desc = L.SortDesc, get = "GetSortType", set = "SetSortType", values = "GetSortDesc" },
			timer    = { type = "select", order = 30, name = L.TimerName,    desc = L.TimerDesc, values = "GetTimerDesc" },
			flashing = { type = "toggle", order = 40, name = L.FlashingName, desc = L.FlashingDesc },
		} 
	},
	layout = { 
		type = "group", order = 20, name = L.BarName, inline = true, 
		args = {
			horizontal = { type = "toggle", order = 10, name = L.HorizontalName, desc = L.HorizontalDesc, width = "full" },
			number     = { type = "range",  order = 30, name = L.NumberName,     desc = L.NumberDesc,   set = "SetNumber",   min = 1,    max = MAX_BUTTON, step = 1 },
			scale      = { type = "range",  order = 40, name = L.ScaleName,      desc = L.ScaleDesc,    set = "SetScale",    min = 0.01, max = 2,          step = 0.01, isPercent = true },
			cols       = { type = "range",  order = 50, name = L.ColsName,       desc = L.ColsDesc,     set = "SetCols",     min = 1,    max = MAX_BUTTON, step = 1 },
			xPadding   = { type = "range",  order = 60, name = L.XPaddingName,   desc = L.XPaddingDesc, set = "SetXPadding", min = -20,  max = 20,         step = 1 },
			rows       = { type = "range",  order = 70, name = L.RowsName,       desc = L.RowsDesc,     set = "SetRows",     min = 1,    max = MAX_BUTTON, step = 1 },
			yPadding   = { type = "range",  order = 80, name = L.YPaddingName,   desc = L.YPaddingDesc, set = "SetYPadding", min = -50,  max = 50,         step = 1 },
		} 
	}
}
local blizzOptions = {
	type = "group", order = 40, name = L.DescWeapon, handler = Module, get = "GetProperty", set = "SetProperty", args = args
}
local dialogOptions = {
	type = "group", order = 20, name = L.BarWeapon, handler = Module, get = "GetProperty", set = "SetProperty", args = args,
	plugins = {
		p1 = { 
			descr = { type = "description", order = 5, name = L.DescWeapon, fontSize = "large" }
		}
	}
}

------------------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------------------
function Module:OnModuleInitialize()
	self:RegisterOptions( blizzOptions, L.BarWeapon)
	self:CloneAura( "weapon")
end

function Module:GetOptionTable()
	return dialogOptions
end

function Module:UpdateAnchors( sort)
--	Addon:Debug( self, ":UpdateAnchors")
	if self.profile.show then
		self:SortAura()
		for i,child in pairs( self.group.children) do
			local a = self.aura[i]
			local buff = _G["TempEnchant"..a.id]
			self:UpdateLBF( buff)
				-- MOD
			self:UpdateMasque(buff)
			-- /MOD
			child:SetBuff( buff)
		end
	end
end

function Module:UpdateEnchantAnchors()
	self:UpdateAnchors()
end

function Module:MoveTo( offset)
	local count = 1
	local last, first
	for i = 1,#self.aura do
		local buff = _G["TempEnchant"..i]
		if buff then
			buff:ClearAllPoints()
			if last and first then
				buff:SetPoint( "TOPRIGHT", last, "TOPLEFT", -5, 0 )
			elseif first then
				buff:SetPoint( "TOPRIGHT", first, "BOTTOMRIGHT", 0, -BUFF_ROW_SPACING)
				first = buff
			else
				buff:SetPoint( "TOPRIGHT", TemporaryEnchantFrame, "TOPRIGHT", 0, offset)
				first = buff
			end
			last = buff;
			count = count + 1
			if count > BUFFS_PER_ROW then
				count = 1
				last = nil
			end
		end
	end
end
