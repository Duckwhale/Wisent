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

local MAJOR = "Wisent"
local Addon = LibStub( "AceAddon-3.0"):NewAddon( MAJOR, "AceEvent-3.0", "AceConsole-3.0", "AceHook-3.0", "LibDebugLog-1.0")
if not Addon then return end -- already loaded and no upgrade necessary

local L      = LibStub( "AceLocale-3.0"):GetLocale( MAJOR)
local LBF    = LibStub( "LibButtonFacade", true)
-- MOD: TODO: Change "Enable LBF" option to "Use Masque"
local Masque = LibStub("Masque", true)
-- /MOD

Addon.name, Addon.localizedname = GetAddOnInfo( MAJOR)
Addon.version = GetAddOnMetadata( MAJOR, "Version") or "unknown"
Addon.versionString = format( "%s: %s |c003C8C3C(Legion)|r", L["Version"], Addon.version)

local NOTHING = {}
local DEFAULTS = { 
	profile = {
		["*"]  = { xPos = 400, yPos = 300, xPadding = 5, yPadding = 15, scale = 1.0, rows = 1, cols = 16, number = 16, show = true,  horizontal = true, sort = "dec",   timer = 2, flashing = true,  style = {}, },
		buff   = { xPos = 400, yPos = 400, xPadding = 5, yPadding = 15, scale = 1.0, rows = 2, cols = 20, number = 40, show = true,  horizontal = true, sort = "dec",   timer = 2, flashing = true,  style = {}, },
		debuff = { xPos = 400, yPos = 250, xPadding = 5, yPadding = 15, scale = 1.0, rows = 1, cols = 16, number = 16, show = true,  horizontal = true, sort = "dec",   timer = 2, flashing = true,  style = {}, },
		weapon = { xPos = 400, yPos = 200, xPadding = 5, yPadding = 15, scale = 1.0, rows = 1, cols =  3, number =  3, show = true,  horizontal = true, sort = "none",  timer = 2, flashing = true,  style = {}, },
		proc   = { xPos = 400, yPos = 150, xPadding = 5, yPadding = 15, scale = 1.0, rows = 1, cols = 16, number = 16, show = true,  horizontal = true, sort = "alpha", timer = 2, flashing = true,  style = {}, },
		hidden = { xPos = 400, yPos = 100, xPadding = 5, yPadding = 15, scale = 1.0, rows = 2, cols =  8, number = 16, show = true,  horizontal = true, sort = "dec",   timer = 2, flashing = true,  style = {}, },
		combo  = { xPos = 400, yPos = 150, xPadding = 5, yPadding = 15, scale = 1.0, rows = 1, cols =  5, number =  10, show = false, horizontal = true, sort = "none",  timer = 2, flashing = false, style = {}, bigger = 1.0, },
		blizzard = false,
		locked   = true,
		enabled  = true,
		masque = true
	} 
}
local ENCHANT_UPDATE_TIME = 1/7

local auras = {
	buff = {},
	debuff = {},
	weapon = {}
}
local options = {
	type = "group", name = Addon:GetName(), childGroups = "tree", args = {}
}
local updateTime = 0

------------------------------------------------------------------------------------
-- Local
------------------------------------------------------------------------------------
local function InitAuraArray()
	for i = 1,40 do
		tinsert( auras.buff, { id = i })
	end
	for i = 1,16 do
		tinsert( auras.debuff, { id = i })
	end
	for i = 1,3 do
		tinsert( auras.weapon, { id = i })
	end
end

local function UpdateAura( id, aura, filter, now)
	name, rank, texture, count, debuffType, duration, expiration, unitCaster, isStealable, consolidate, spellID = UnitAura( PlayerFrame.unit, id, filter)
	local timeLeft = name and expiration and (expiration - now) or nil
	aura.id      = id
	aura.filter  = filter
	aura.name    = name
	aura.rank    = rank
	aura.texture = texture
	aura.count   = count
	aura.type    = debuffType
	aura.duration    = duration
	aura.expiration  = expiration
	aura.timeLeft    = timeLeft and (timeLeft > 0) and timeLeft or nil
	aura.duration    = duration
	aura.unitCaster  = unitCaster
	aura.isStealable = isStealable
	aura.consolidate = consolidate
	aura.spellID     = spellID
end

local function UpdateWaepon( id, enchant, timeLeft, charges)
	timeLeft    = enchant and timeLeft and (timeLeft / 1000)
	local aura = auras.weapon[id]
	aura.id       = id
	aura.name     = enchant and tostring( id) or nil
	aura.count    = charges 
	aura.texture  = enchant and GetInventoryItemTexture( PlayerFrame.unit, 15 + id) 
	aura.timeLeft = timeLeft and (timeLeft > 0) and timeLeft or nil
end

local function UpdateEnchant()
	if PlayerFrame.unit or PlayerFrame.unit == "player" then
		local mainEnchant, mainTimeLeft, mainCharges, offEnchant, offTimeLeft, offCharges, thrEnchant, thrTimeLeft, thrCharges = GetWeaponEnchantInfo()
		UpdateWaepon( 1, mainEnchant, mainTimeLeft, mainCharges)
		UpdateWaepon( 2, offEnchant,  offTimeLeft,  offCharges)
		UpdateWaepon( 3, thrEnchant,  thrTimeLeft,  thrCharges)
	else
		UpdateWaepon( 1, nil, nil, nil)
		UpdateWaepon( 2, nil, nil, nil)
		UpdateWaepon( 3, nil, nil, nil)
	end
end

local function UpdateAllAuras()
	Addon:Debug( "UpdateAllAuras")
	local now = GetTime()
	for id,aura in pairs( auras.buff) do
		UpdateAura( id, aura, "HELPFUL", now)
	end
	for id,aura in pairs( auras.debuff) do
		UpdateAura( id, aura, "HARMFUL", now)
	end
end

local function DurationString( seconds, timer, color)
	if not seconds then
		return ""
	end
	if timer == 3 then
		local min = math.floor( seconds / 60)
		if seconds < 3600 then 
			return "|c%s%d:%02d|r", color, min, seconds % 60
		end 
		return "|c%s%d:%02d:%02d|r", color, math.floor( min / 60), min % 60, seconds % 60
	end
	if timer == 2 then
		if seconds < 60 then 
			return "|c%s%ds|r", color, seconds 
		end
		local min = math.floor( seconds / 60)
		if seconds < 600 then 
			return "|c%s%d:%02d|r", color, min, seconds % 60 
		end
		if seconds < 3600 then 
			return "|c%s%dm|r",color,  min 
		end
		return "|c%s%d:%02dh|r", color, math.floor( min / 60), min % 60
	end
	return SecondsToTimeAbbrev( seconds)
end

------------------------------------------------------------------------------------
-- Class
------------------------------------------------------------------------------------
function Addon:OnInitialize()
	self.db = LibStub( "AceDB-3.0"):New( "WisentDB", DEFAULTS, "Default")
	self:ToggleDebugLog( self.db.profile.debug )
	InitAuraArray()
	if type( self.db.profile.timer) ~= "number" then
		self.db.profile.timer = self.db.profile.timer and 2 or 1
	end
	self:SetEnabledState( self.db.profile.enabled)
	LibStub( "AceConfig-3.0"):RegisterOptionsTable( "WisentDialog", options)
	self:RegisterChatCommand( "wisent", "ShowDialog")
	self:RegisterChatCommand( "bi", "ShowDialog")
	if LBF then
		LBF:RegisterSkinCallback( "Wisent", self.OnSkin, self)
	end
	-- MOD
	if Masque then
		MasqueGroup = Masque:Group("Wisent", "Buffs");
		MasqueGroup = Masque:Group("Wisent", "Debuffs");
		MasqueGroup = Masque:Group("Wisent", "Weapons"); -- TODO: Remove, as weapon enchants aren't a thing anymore (rogue poisons = regular buff)
		MasqueGroup = Masque:Group("Wisent", "Procs"); 
		MasqueGroup = Masque:Group("Wisent", "Combos") ;
		Masque:Register("Wisent", self.OnSkin, self);
		local buttonData = {
			--Icon = button.ShinyRainbowThing,
			Cooldown = false,
			Flash = false,
			Pushed = false,
			Normal = nil,
			Disabled = nil,
			Checked = false,
			Border = nil,
			AutoCastable = false,
			Highlight = false,
			Hotkey = false,
			Count = false,
			Name = false,
			Duration = false,
			Autocast = false,
		};
		
		--mybutton = CreateFrame("Button","mybutton",UIParent,"UIPanelButtonTemplate")
		--mybutton:SetPoint("CENTER",0,0)
		--mybutton:SetWidth(80)
	--	mybutton:SetHeight(22)
		
		local BuffButton1 = CreateFrame("Button", "WisentBuffButton1", BuffButton1, "UIPanelButtonTemplate");
		--MasqueGroup:AddButton(WisentBuff1.name, buttonData);
	end
	-- /MOD
end

function Addon:OnEnable()
	self:Debug( "OnEnable")
	UpdateAllAuras()
	UpdateEnchant()
	self:SecureHook( "BuffFrame_UpdateAllBuffAnchors", "OnUpdateBuffs")
	self:SecureHook( "DebuffButton_UpdateAnchors", "OnUpdateDebuff")
	self:SecureHook( "AuraButton_UpdateDuration", "OnUpdateDuration")
	self:SecureHookScript( TemporaryEnchantFrame, "OnUpdate", "OnUpdateEnchantFrame")
	self:Print( self.version, "loaded")
end

function Addon:OnDisable()
	self:Debug( "OnDisable")
	self:Unhook( "BuffFrame_UpdateAllBuffAnchors")
	self:Unhook( "DebuffButton_UpdateAnchors")
	self:Unhook( "AuraButton_UpdateDuration")
	self:Unhook( TemporaryEnchantFrame, "OnUpdate")
end

function Addon:OnUpdateBuffs()
--	self:Debug( self, ":OnUpdateBuffs")
--	BuffFrame_UpdateAllBuffAnchors()
	UpdateAllAuras()
	for _,mod in self:IterateModules() do
		if mod.UpdateBuffAnchors and mod:IsEnabled() then
			mod:UpdateBuffAnchors()
		end
	end
end

function Addon:OnUpdateDebuff( buttonName, index)
--	self:Debug( self, ":OnUpdateDebuff", buttonName, index)
--	DebuffButton_UpdateAnchors( buttonName, index)
	for _,mod in self:IterateModules() do
		if mod.UpdateDebuffAnchors and mod:IsEnabled() then
			mod:UpdateDebuffAnchors(  buttonName, index)
		end
	end
end

function Addon:OnUpdateEnchantFrame( frame, elapsed)
--	self:Debug( self, ":OnUpdateEnchantFrame", elapsed)
--	TemporaryEnchantFrame_OnUpdate( elapsed)
	if updateTime > 0 then
		updateTime = updateTime - elapsed
	else
		updateTime = updateTime + ENCHANT_UPDATE_TIME
		UpdateEnchant()
		for _,mod in self:IterateModules() do
			if mod.UpdateEnchantAnchors and mod:IsEnabled() then
				mod:UpdateEnchantAnchors( elapsed)
			end
		end
	end
end

function Addon:OnUpdateDuration( buff, timeLeft)
--	self:Debug( self, ":OnUpdateDuration", buff, timeLeft)
--	AuraButton_UpdateDuration( buff, timeLeft)
	if SHOW_BUFF_DURATIONS == "1" and timeLeft then
		local proName = buff.proName
		local profile = proName and self.db.profile[proName] or NOTHING
		buff.duration:SetFormattedText( DurationString( timeLeft, profile.timer or 0, "FFFFFFFF"))
--		buff:SetScale( profile.scale or 1)
		if profile.flashing == false then
			buff:SetAlpha( 1.0)
		end
	end
end


-- MOD: Interaction with Masque instead of the old LBF/BF addons that no longer work
-- function Addon:OnSkin( skin, gloss, backdrop, group, button, colors) SkinID, Gloss, Backdrop, Group, Button, Colors
-- Format: groupName:String, skinName:String, glossIntensity:int (glossPct), isBackdropEnabled:boolean, colorsTable:table, isDisabled
function Addon:OnSkin(group, skin, gloss, backdrop, colors, disabled)


 -- TODO: saved vars notice
	if not group then
		group = "All"
	end
	DEFAULT_CHAT_FRAME:AddMessage("OnSkin event with parameters: "  .. group.. " " .. skin .. " " .. gloss .. " " .. tostring(backdrop) .. " " .. tostring(colors) .. " " .. tostring(disabled) )

	-- Added for 7.1.
	-- TODO: Hide groups when told so by Masque. Which one, though? All of them? 
	if disabled then
	DEFAULT_CHAT_FRAME:AddMessage("Wisent: Received <disabled> notice from Masque after OnSkin event)")
	end
	
	--[[ original code:
	local profile = group and self.db.profile[group]
	if profile then
		if type( profile.style) ~= "table" then
			profile.style = {}
		end
		local style = profile.style
		style.skin     = skin
		style.gloss    = gloss
		style.backdrop = backdrop
		style.colors   = colors
	]]--
	
	-- For now, a Masque update changes ALL groups. What is the point in registering them, then? That should be fixed, or changed to only provide Masque with one catchall group
--	local groups = { "buffs", "debuffs",  "weapon", "proc",  "hidden", "combo"}
--	for i = 0, #groups do
	--	local group = groups[i]  
		local profile = group and self.db.profile[group]
		if profile then
			if type( profile.style) ~= "table" then
				profile.style = {}
			end
			local style = profile.style
			style.skin     = skin
			style.gloss    = gloss
			style.backdrop = backdrop
			style.colors   = colors
--DEFAULT_CHAT_FRAME:AddMessage("skin = " .. skin .. ", gloss = " .. gloss .. ", backdrops = " .. backdrop .. ", colors = " .. colors .. ", group = " .. group .. ", button = " .. button)
		end
--	end
end
-- /MOD

------------------------------------------------------------------------------------
-- Main
------------------------------------------------------------------------------------
function Addon:CloneAura( dst, name)
	for _,aura in pairs( auras[name] or NOTHING) do
		tinsert( dst, aura)
	end 
end

function Addon:ShowDialog()
	for name,mod in self:IterateModules() do
		options.args[name] = mod.GetOptionTable and mod:GetOptionTable() or nil
	end
	LibStub( "AceConfigDialog-3.0"):Open( "WisentDialog")
end
