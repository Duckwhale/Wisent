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

local L = {
	Profile           = "Profile",
	ProfileCopied     = "Copied settings from '%s'",
	ProfileCreated    = "Created new profile '%s'",
	ProfileDeleted    = "Deleted profile '%s'",
	ProfileLoaded     = "Set profile to '%s'",
	ProfileReset      = "Reset profile '%s'",
	Version           = "Version",
}
local LOCALE = GetLocale()
if LOCALE == "deDE" then
	L.Profile           = "Profil"
	L.ProfileCopied     = "Kopiere Werte von '%s'"
	L.ProfileCreated    = "Erstellt ein neues Profil '%s'"
	L.ProfileDeleted    = "Lösche Profil '%s'"
	L.ProfileLoaded     = "Setze Profil auf '%s'"
	L.ProfileReset      = "Rücksetzen Profil '%s'"
	L["Version"]           = "Version"
elseif LOCALE == "frFR" then
	L.Profile           = "Profil"
	L.ProfileCopied     = "Paramètres Copies depuis '%s'"
	L.ProfileCreated    = "Nouveau profil '%s' cree"
	L.ProfileDeleted    = "Profil '%s' efface"
	L.ProfileLoaded     = "Profile '%s' charge"
	L.ProfileReset      = "Profile '%s' reinitialise"
elseif LOCALE == "esES" then
-- I need help on this translation
elseif LOCALE == "ruRU" then
	L.Profile           = "Профиль"
	L.ProfileCreated    = "Создание нового профиля '%s'"
	L.ProfileCopied     = "Копирование настроек с '%s'"
	L.ProfileDeleted    = "Удаление профиля '%s'"
	L.ProfileLoaded     = "Установка профиля к '%s'"
	L.ProfileReset      = "Сброс профиля '%s'"
elseif LOCALE == "koKR" then
-- I need help on this translation
elseif LOCALE == "zhCN" then
	L.Profile           = "配置文件"
	L.ProfileCopied     = "从该配置文件复制设置 '%s'"
	L.ProfileCreated    = "生成新的配置文件 '%s'"
	L.ProfileDeleted    = "删除配置文件 '%s'"
	L.ProfileLoaded     = "选择配置文件 '%s'"
	L.ProfileReset      = "重置配置 '%s'"
elseif LOCALE == "zhTW" then
-- I need help on this translation
end

------------------------------------------------------------------------------------
-- Class
------------------------------------------------------------------------------------
local Addon  = LibStub( "AceAddon-3.0"):GetAddon( "Wisent")
local Module = Addon:NewModule( "Profile", "AceEvent-3.0")

function Module:OnInitialize()
	local db = Addon.db
	self.profile = LibStub( "AceDBOptions-3.0"):GetOptionsTable( db)
	LibStub( "AceConfig-3.0"):RegisterOptionsTable( "Wisent_Profile", self.profile)
	LibStub( "AceConfigDialog-3.0"):AddToBlizOptions( "Wisent_Profile", L.Profile, Addon:GetName())
	db.RegisterCallback( self, "OnNewProfile")
	db.RegisterCallback( self, "OnProfileChanged")
	db.RegisterCallback( self, "OnProfileCopied")
	db.RegisterCallback( self, "OnProfileReset")
	db.RegisterCallback( self, "OnProfileDeleted")
end

function Module:GetOptionTable()
	return self.profile
end

------------------------------------------------------------------------------------
-- Profile
------------------------------------------------------------------------------------
function Module:OnNewProfile( event, db, name)
	self:SendMessage( "WISENT_PROFILE")
	Addon:Print( L.ProfileCreated:format( name))
end

function Module:OnProfileChanged( event, db, name)
	self:SendMessage( "WISENT_PROFILE")
	Addon:Print( L.ProfileLoaded:format( name))
end

function Module:OnProfileCopied( event, db, name)
	self:SendMessage( "WISENT_PROFILE")
	Addon:Print( L.ProfileCopied:format( name))
end

function Module:OnProfileReset( event, db)
	self:SendMessage( "WISENT_PROFILE")
	Addon:Print( L.ProfileReset:format( db:GetCurrentProfile()))
end

function Module:OnProfileDeleted( event, db, name)
	Addon:Print( L.ProfileDeleted:format( name))
end
