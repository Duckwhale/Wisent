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

local MAJOR = "Wisent"

local al = LibStub("AceLocale-3.0")

do
	local L = al:NewLocale( MAJOR, "enUS", true)
	L.BarBuff           = "Buffs" 
	L.BarCombo          = "Combos"
	L.BarDebuff         = "Debuffs"
	L.BarHidden         = "Hidden"
	L.BarName           = "Button Bar Look"
	L.BarWeapon         = "Weapons"
	L.BarProg           = "Progs"
	L.BarSecure         = "Secure"
	L.BarHijack         = "Hijack"
	L.BiggerName        = "Last Combo"
	L.BiggerDesc        = "The last combo point size."
	L.CancelAura        = [[
Wisent Cancel Aura : "%s"

Blizzard changed the call of CancelUnitBuff. Now these function can only be used by secure environment with SecureButtons. The handling of secure buttons is very restricted. I use this workaround for the moment. 

Copy this line and paste it to the chat.]]
	L.ColsDesc          = "Number of columns"
	L.ColsName          = "Columns"
	L.CooldownDesc      = "Show the cooldown animation."
	L.CooldownName      = "Cooldown"
	L.DebugDesc         = "Show debug messages. Only need for testing."
	L.DebugName         = "Debug"
	L.Description       = "Free positioning and presentation of all user buffs, debuffs and weapon enchantments."
	L.DescBuff          = "Helpful Buffs"
	L.DescDebuff        = "Harmful Buffs"
	L.DescHidden        = "Joined Helpful Buffs (tooltip)"
	L.DescProgs         = "Special Helpful Buffs"
	L.DescCombos        = "Combo Buffs"
	L.DescMain          = "Main"
	L.DescSecure        = "Secure Test"
	L.DescWeapon        = "Weapon Enchants"
	L.EnabledDesc       = "Activate the addon and hide the Blizzard standard bars."
	L.EnabledName       = "Button Enabled"
	L.ForceDesc         = "Force the visibility of Blizzards buff frames now."
	L.ForceName         = "Force Buff Frames"
	L.ForceWarn         = "Blizzard buff frames was deactivating by an other addon. You should deactivate this option on your other addons."
	L.FlashingDesc      = "Flashing at end."
	L.FlashingName      = "Enable Flashing"
	L.Help              = "Help"
	L.HorizontalDesc    = "First dirction for display buttons."
	L.HorizontalName    = "Horizontal First"
	L.JoinDesc          = "Join some special buffs."
	L.JoinName          = "Join Buffs"
	L.LBFDesc           = "Enable library Buttonfacade if present."
	L.LBFName           = "Enable LBF"
	L.MasqueName	= "Enable Masque"
	L.MasqueDesc = "Enable interaction with Masque if present"
	L.LockDesc          = "Lock all bars after select there positions."
	L.LockName          = "Button Lock"
	L.NumberDesc        = "Maximal visible number of buttons."
	L.NumberName        = "Size"
	L.OptionName        = "Common Option"
	L.RowsDesc          = "Number of rows"
	L.RowsName          = "Rows"
	L.ScaleDesc         = "Size of the buttons."
	L.ScaleName         = "Scale"
	L.ShowDesc          = "Hide and show buttons."
	L.ShowName          = "Show Button Bar"
	L.SpellDesc         = "The spell ID"
	L.SpellName         = "SpellID"
	L.SortAlpha         = "Name"
	L.SortDec           = "Time left, Descending"
	L.SortDesc          = "Set the sorting of the buff icons"
	L.SortDurationAsc   = "Duration"
	L.SortDurationDesc  = "Duration, Descending"
	L.SortInc           = "Time left"
	L.SortName          = "Sort"
	L.SortNone          = "None (Blizzard order)"
	L.SortRevert        = "Name, Descending"
	L.StyleBlizzard     = "Blizzard Style"
	L.StyleWisent1       = "short time (XXm)"
	L.StyleWisent2       = "always long time (XX:XX)"
	L.TimerDesc         = "Change the time between Wisent or Blizzard style."
	L.TimerName         = "Timer Presentation"
	L.Version           = "Version"
	L.VersionDesc       = "Prints the current version."
	L.XPaddingDesc      = "Horizontal space between buttons (min: -20, max: 20). A negativ value change the direction of the bar."
	L.XPaddingName      = "Horizontal Space"
	L.YPaddingDesc      = "Vertical space between buttons (min: -50, max: 50). A negativ value change the direction of the bar."
	L.YPaddingName      = "Vertical Space"
end

do
	local L = al:NewLocale( MAJOR, "deDE")
	if L then 
		L.BarBuff           = "Buffs" 
		L.BarCombo          = "Combos"
		L.BarDebuff         = "Debuffs"
		L.BarName           = "Aussehen der Buffleiste"
		L.BarWeapon         = "Waffen"
		L.BarProg           = "Progs"
		L.CancelAura        = [[
Wisent Cancel Aura : "%s"

Blizzard änderte den Aufruf von CancelUnitBuff. Jetzt kann diese Funtion nur noch in einer sicheren Umgebung mit SecureButtons benutzt werden. Die Handhabung der sicheren Buttons ist sehr eingeschränkt. Ich beutze diese Zwischenlösung für den Moment.

Diese Zeile kopieren und in den Chat einfügen.]]
		L.ColsDesc          = "Anzahl Spalten"
		L.ColsName          = "Anzahl Spalten"
		L.DebugDesc         = "Zeige Debug Nachrichten an. Wird nur zum Testen gebraucht."
		L.DebugName         = "Debug"
		L.Description       = "Freie Positionierung und Darstellung aller User Buffs, Debuffs und Waffen Verzauberungen."
		L.EnabledDesc       = "Aktiviert das Addon und versteckt die Standardanzeige von Blizzard."
		L.EnabledName       = "Addon Aktivieren"
		L.FlashingDesc      = "Blinken bei Ablauf des Buffs"
		L.FlashingName      = "Blinken Erlauben"
		L.ForceDesc         = "Erzwingt jetzt die Sichtbarkeit der Blizzards Buffframes."
		L.ForceName         = "Erzwinge Buff Frames"
		L.ForceWarn         = "Blizzard Buffframes sind durch ein anderes Addon deaktiviert worden. Du solltest diese Option in deinen anderen Addons daktivieren."
		L.Help              = "Hilfe"
		L.HorizontalDesc    = "Die Richtung vorgeben, in der die Buttons beginnend angezeigt werden sollen"
		L.HorizontalName    = "Horizontal zuerst"
		L.JoinDesc          = "Bestimmte Buffs zusammenfassen."
		L.JoinName          = "Buffs zusammenfassen"
		L.LBFDesc           = "Erlaube die Bibliothek Buttonfacade, wenn vorhanden."
		L.LBFName           = "LBF erlauben"
		L.LockDesc          = "Nach Anpassung der Positionen der einzelnen Leisten, werden diese verriegelt."
		L.LockName          = "Buttons verriegeln"
		L.NumberDesc        = "Maximal sichtbare Anzahl von Buttons."
		L.NumberName        = "Anzahl"
		L.OptionName        = "allgemeine Optionen"
		L.RowsDesc          = "Anzahl Zeilen"
		L.RowsName          = "Anzahl Zeilen"
		L.ScaleDesc         = "Größe des Buttons"
		L.ScaleName         = "Größe"
		L.ShowDesc          = "Buttons anzeigen oder verstecken"
		L.ShowName          = "Buttons Leiste Anzeigen"
		L.SortAlpha         = "Alphabetisch"
		L.SortDec           = "Restzeit abnehmend"
		L.SortDesc          = "Legt die Sortierung der Bar fest."
		L.SortDurationAsc   = "Dauer zunehmend"
		L.SortDurationDesc  = "Dauer abnehmend"
		L.SortInc           = "Restzeit zunehmend"
		L.SortName          = "Sortierung"
		L.SortNone          = "Keine (Blizzard Reihenfolge)"
		L.SortRevert        = "Alphabetisch absteigend"
		L.TimerDesc         = "Zeit in Wisent- oder Blizzard-Art darstellen"
		L.TimerName         = "Zeitdarstellung"
		L.Version           = "Version"
		L.VersionDesc       = "Druckt die aktuelle Version aus."
		L.XPaddingDesc      = "Den horizontaler Abstand zwischen den Buttons einstellen (Min: -20, Max: 20). Negativer Wert ändert die Richtung der Buttonanzeige"
		L.XPaddingName      = "horizontaler Zwischenraum"
		L.YPaddingDesc      = "Den vertikale Abstand zwischen den Buttons einstellen (Min: -50, Max: 50). Negativer Wert ändert die Richtung der Buttonanzeige"
		L.YPaddingName      = "vertikale Zwischenraum"
	end
end

do
	local L = al:NewLocale( MAJOR, "frFR")
	if L then 
		L.BarBuff           = "Barre de Buffs"
		L.BarDebuff         = "Barre de Debuff"
		L.BarName           = "Apparence des barres"
		L.BarWeapon         = "Barre des Armes"
		L.BarProg           = "Progs"
		L.ColsDesc          = "Nombre de colonnes"
		L.ColsName          = "Colonnes"
		L.DebugDesc         = "Montrer les messages de debugging. Pour tests seulement."
		L.DebugName         = "Debug"
		L.Description       = "Positionnement et presentation libres de tout les buffs, debuffs et enchantements d'armes."
		L.EnabledDesc       = "Activer l addon et cacher les barres standards de Blizzard."
		L.EnabledName       = "Activer les Barres"
		L.FlashingDesc      = "Flash en fin."
		L.FlashingName      = "Activer le flash"
		L.HorizontalDesc    = "Premiere direction pour afficher les boutons."
		L.HorizontalName    = "Horizontalement en premier"
		L.JoinDesc          = "Regrouper les buffs speciaux."
		L.JoinName          = "Regrouper les buffs"
		L.LockDesc          = "Verrouiller toutes les barres apres selection de leur position."
		L.LockName          = "Verouiller les boutons"
		L.NumberDesc        = "Nombre maximal de boutons visibles."
		L.NumberName        = "Taille"
		L.OptionName        = "Options communes"
		L.RowsDesc          = "Nombre de lignes"
		L.RowsName          = "Lignes"
		L.ScaleDesc         = "Taille des boutons."
		L.ScaleName         = "Echelle"
		L.ShowDesc          = "Cacher et montrer les boutons."
		L.ShowName          = "Afficher la barre de boutons"
		L.SortAlpha         = "Nom"
		L.SortDec           = "Temps restant, Decroissant"
		L.SortDesc          = "Regler le tri des icones de buffs"
		L.SortDurationAsc   = "Duree"
		L.SortDurationDesc  = "Duree, Decroissante"
		L.SortInc           = "Temps restant"
		L.SortName          = "Tri"
		L.SortNone          = "Aucun (Ordre de Blizzard)"
		L.SortRevert        = "Nom, inverse"
		L.TimerDesc         = "Intervertir le temps entre le style Wisent et Blizzard."
		L.TimerName         = "Presentation du temps"
		L.Version           = "Version"
		L.VersionDesc       = "Afficher la version courante"
		L.XPaddingDesc      = "Espace horizontal entre les boutons (min: -20, max: 20). Une valeur negative change la direction de la barre."
		L.XPaddingName      = "Espace Horizontal"
		L.YPaddingDesc      = "Espace vertical entre les boutons (min: -50, max: 50). Une valeur negative change la direction de la barre."
		L.YPaddingName      = "Espace Vertical"
	end
end

do
	local L = al:NewLocale( MAJOR, "esES")
	if L then 
-- I need help on this translation
	end
end

do
	local L = al:NewLocale( MAJOR, "ruRU")
	if L then 
		L.BarBuff           = "Иконки баффов" 
		L.BarDebuff         = "Иконки дебаффов"
		L.BarName           = "Вид панели иконок"
		L.BarWeapon         = "Иконки оружия"
		L.ColsDesc          = "Количество колонок"
		L.ColsName          = "Колонки"
		L.DebugDesc         = "Отображение отладочной информации. Требуется только для тестирования."
		L.DebugName         = "Отладка"
		L.Description       = "Позволяет свободно размещать и отображать все пользовательские баффы, дебаффы и зачарования оружия."
		L.EnabledDesc       = "Активирует аддон и скрывает стандартный фрейм (де)баффов."
		L.EnabledName       = "Включить"
		L.FlashingDesc      = "Мигание при заканчивании времени."
		L.FlashingName      = "Включить мигание"
		L.HorizontalDesc    = "Первое направление для отображения иконок."
		L.HorizontalName    = "Первое по горизонтали"
		L.LockDesc          = "Фиксирует все иконки после определения их позиций."
		L.LockName          = "Фиксировать иконки"
--		L.NumberDesc        = "Maximal visible number of buttons."
--		L.NumberName        = "Size"
		L.OptionName        = "Общие настройки"
		L.RowsDesc          = "Количество рядов"
		L.RowsName          = "Ряды"
		L.ScaleDesc         = "Размер иконок."
		L.ScaleName         = "Масштаб"
		L.ShowDesc          = "Отображение/сокрытие иконок."
		L.ShowName          = "Панель иконок"
		L.SortAlpha         = "Название"
		L.SortDec           = "Остаток, Убывание"
		L.SortDesc          = "Установка сортировки иконок баффов"
		L.SortDurationAsc   = "Длительность"
		L.SortDurationDesc  = "Длительность, Убывание"
		L.SortInc           = "Остаток"
		L.SortName          = "Сортировка"
		L.SortNone          = "Нету (Blizzard order)"
		L.SortRevert        = "Название, Убывание"
		L.TimerDesc         = "Изменение стиля время между Wisentовским или Blizzardским."
		L.TimerName         = "Отображение времени"
		L.Version           = "Версия"
		L.VersionDesc       = "Выводит информации о версии."
		L.XPaddingDesc      = "Промежуток по горизонтали между иконками (мин: -20, макс: 20). Отрицательное значение изменит направление панели."
		L.XPaddingName      = "Промежуток - Горизонталь"
		L.YPaddingDesc      = "Промежуток по вертикали между иконками (мин: -50, макс: 50). Отрицательное значение изменит направление панели."
		L.YPaddingName      = "Промежуток - Вертикаль"
	end
end

do
	local L = al:NewLocale( MAJOR, "koKR")
	if L then 
-- I need help on this translation
	end
end

do
	local L = al:NewLocale( MAJOR, "zhCN")
	if L then 
-- I need help on this translation
	end
end

do
	local L = al:NewLocale( MAJOR, "zhTW")
	if L then 
-- I need help on this translation
	end
end
