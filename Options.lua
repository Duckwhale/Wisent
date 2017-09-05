  ----------------------------------------------------------------------------------------------------------------------
    -- This program is free software: you can redistribute it and/or modify
    -- it under the terms of the GNU General Public License as published by
    -- the Free Software Foundation, either version 3 of the License, or
    -- (at your option) any later version.
	
    -- This program is distributed in the hope that it will be useful,
    -- but WITHOUT ANY WARRANTY; without even the implied warranty of
    -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    -- GNU General Public License for more details.

    -- You should have received a copy of the GNU General Public License
    -- along with this program.  If not, see <http://www.gnu.org/licenses/>.
----------------------------------------------------------------------------------------------------------------------

local Addon  = LibStub( "AceAddon-3.0"):GetAddon( "Wisent")
local L      = LibStub( "AceLocale-3.0"):GetLocale( "Wisent")
local Module = Addon:NewModule( "Options", "AceEvent-3.0")

------------------------------------------------------------------------------------
-- Local
------------------------------------------------------------------------------------
local function GetProperty( info)
	local key = info[#info]
	return Module.profile[key]
end

local function SetProperty( info, value)
	Addon:Debug( "SetProperty", Module:GetName())
	local key = info[#info]
	Module.profile[key] = value
	Module:SendMessage( "WISENT_UPDATE")
end

local function SetEnable( info, value) 
	Addon:Debug( "SetEnable", Module:GetName())
	if value ~= Addon:IsEnabled() then
		if value then
			Addon:Enable()
		else
			Addon:Disable()
		end
	end
end

local function SetDebug( info, value) 
	Addon:ToggleDebugLog( value)
	SetProperty(info, value) -- Make sure the changes are persistent, otherwise debug resets after every reloadUI/relog
end

-- LibDebugLog seems to constantly reset it despite the options table having the correct value for debug -> Overwriting their function to make sure the toggle is always set correctly
local function IsDebugLogEnabled(info, value)
	
	-- Load debug from savedVars, instead of relying on the non-persistent state of LibDebugLog
	local isDebug = GetProperty(info, value)
	
	return isDebug
end

local function IsForceDisabled()
	local unitAura = BuffFrame:IsEventRegistered( "UNIT_AURA")
	local buffFrame = BuffFrame:IsVisible()
	local enchantFrame = TemporaryEnchantFrame:IsVisible()
	return unitAura and buffFrame and enchantFrame
end

local function ForceFrames()
	BuffFrame:Show()
	BuffFrame:RegisterEvent( "UNIT_AURA")
	TemporaryEnchantFrame:Show()
	Module:SendMessage( "WISENT_UPDATE")
end

local main = {
	type = "group", order = 10, name = L.DescMain, get = GetProperty, set = SetProperty, handler = Addon, 
	args = {
		release     = { type = "description", order = 20,  name = Addon.version, cmdHidden = true, fontSize = "large" },
		description = { type = "description", order = 30,  name = L.Description, cmdHidden = true, fontSize = "large" },
		space1      = { type = "description", order = 40,  name = " ", cmdHidden = true },
		enabled     = { type = "toggle",      order = 140, name = L.EnabledName,  desc = L.EnabledDesc,  get = "IsEnabled",         set = SetEnable, width = "full" },
		debug       = { type = "toggle",      order = 150, name = L.DebugName,    desc = L.DebugDesc,    get = IsDebugLogEnabled, set = SetDebug,  width = "full" },
		lbf         = { type = "toggle",      order = 160, name = L.LBFName,      desc = L.LBFDesc,   width = "full" },
	-- MOD
		masque = { type = "toggle", order = 165, name = L.MasqueName, desc = L.MasqueDesc, width = "full" },
	-- /MOD
		forceS      = { type = "description", order = 170, name = " ", cmdHidden = true },
		forceT      = { type = "description", order = 171, name = L.ForceWarn,    hidden = IsForceDisabled, fontSize = "large" },
		force       = { type = "execute",     order = 172, name = L.ForceName,    desc = L.ForceDesc, func = ForceFrames, disabled = IsForceDisabled },
		lockedS     = { type = "description", order = 199, name = " ", cmdHidden = true },
		locked      = { type = "toggle",      order = 200, name = L.LockName,     desc = L.LockDesc,  width = "full" },
	}
}

------------------------------------------------------------------------------------
-- Class
------------------------------------------------------------------------------------
function Module:OnInitialize()
	self:WISENT_PROFILE()
	LibStub( "AceConfig-3.0"):RegisterOptionsTable( Addon:GetName(), main)
	LibStub( "AceConfigDialog-3.0"):AddToBlizOptions( Addon:GetName(), Addon:GetName())
end

function Module:OnEnable()
	self:RegisterMessage( "WISENT_PROFILE")
end

function Module:OnDisable()
	self:UnregisterMessage( "WISENT_PROFILE")
end

function Module:WISENT_PROFILE()
	self.profile = Addon.db.profile
end

function Module:GetOptionTable()
	return main
end

