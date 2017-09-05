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

local al = LibStub("AceLocale-3.0")

do
	local L = al:NewLocale( MAJOR, "enUS", true)
	L["BuffBar"]          = "Buffs" 
	L["ComboBar"]         = "Combos"
	L["DebuffsBar"]      = "Debuffs"
	L["Hidden"]        = "Hidden"
	L["Appearance and Behaviour"]        = "Button Bar Look"
	L["WeaponEnchants Bar"]         = "Weapons"
	L["SpellProcs Bar"]           = "Progs"
	L["Secure"]        = "Secure"
	L["Hijack"]         = "Hijack"
	L["Maximum stack size indicator"]       = "Last Combo"
	L["When the maximum number of combo points (or spell charges/procs) has been reached, increase the size of the last icon by this amount"]        = "The last combo point size."
	L["CancelAura"]        = [[
Wisent Cancel Aura : "%s"

Blizzard changed the call of CancelUnitBuff. Now these function can only be used by secure environment with SecureButtons. The handling of secure buttons is very restricted. I use this workaround for the moment. 

Copy this line and paste it to the chat.]]
	L["Number of colums"]          = "Number of columns"
	L["Columns"]         = "Columns"
	L["Show cooldown animations"]      = "Show the cooldown animation."
	L["Cooldown"]      = "Cooldown"
	L["Toggle debug mode (not particularly useful unless something has gone terribly wrong)"]         = "Show debug messages. Only need for testing."
	L["Debug Mode"]         = "Debug"
	L["Provides an easily customizable display for buffs, debuffs, and spell procs"]       = "Free positioning and presentation of all user buffs, debuffs and weapon enchantments."
	L["BuffBar Settings"]         = "Helpful Buffs"
	L["DebuffBar Settings"]       = "Harmful Buffs"
	L["Consolidate Buffs"]        = "Joined Helpful Buffs (tooltip)"
	L["SpellProcs Bar Settings"]         = "Special Helpful Buffs"
	L["ComboBar Settings"]        = "Combo Buffs"
	L["Wisent Configuration"]          = "Main"
	L["SecureTest"]        = "Secure Test"
	L["Weapon Enchants"]        = "Weapon Enchants"
	L["Enable the addon (will disable Blizzard's default buff bars)"]       = "Activate the addon and hide the Blizzard standard bars."
	L["Enabled"]      = "Button Enabled"
	L["Show Blizzard's buff bars (regardless of whether or not Wisent is enabled"]        = "Force the visibility of Blizzards buff frames now."
	L["Show Blizzard buff bars"]         = "Force Buff Frames"
	L["It appears that Blizzard's buff bars have been disabled (by another addon). Please check and make sure to disable the respective addon's options to let Wisent handle this."]         = "Blizzard buff frames was deactivating by an other addon. You should deactivate this option on your other addons."
	L["Flash button as the buff duration approaches zero"]      = "Flashing at end."
	L["Enable Flashing"]      = "Enable Flashing"
	L["Help"]              = "Help"
	L["Align buff icons horizontally before moving to a new row"]   = "First dirction for display buttons."
	L["Horizontal Alignment"]    = "Horizontal First"
	L["Consolidate some buffs"]         = "Join some special buffs."
	L["Consolidate Buffs"]         = "Join Buffs"
	L["Enable LibButtonFacade if present"]          = "Enable library Buttonfacade if present."
	L["Enable LBF"]           = "Enable LBF"
	L["Enable Masque Support"]	= "Enable Masque"
	L["Enable styling of the buff icons via Masque addon library if present"] = "Enable interaction with Masque if present"
	L["Lock all bars in place and prevent them from being moved"]          = "Lock all bars after select there positions."
	L["Lock Bars"]         = "Button Lock"
	L["Number of buttons to display on this bar"]        = "Maximal visible number of buttons."
	L["Size"]        = "Size"
	L["General Settings"]       = "Common Option"
	L["Number of rows"]          = "Number of rows"
	L["rows"]          = "rows"
	L["Scale all buff icons by this factor"]         = "Size of the buttons."
	L["Scale Factor"]         = "Scale"
	L["Toggle this bar and all of its icons"]         = "Hide and show buttons."
	L["Enable Bar"]          = "Show Button Bar"
	L["Show each icon's spell ID in its tooltip"]         = "The spell ID"
	L["Show Spell ID"]        = "SpellID"
	L["Sort by name (ascending)"]         = "Name"
	L["Sort by time left (descending)"]          = "Time left, Descending"
	L["Set how the icons should be sorted"]          = "Set the sorting of the buff icons"
	L["Sort by duration (ascending)"]   = "Duration"
	L["Sort by duration (descending)"] = "Duration, Descending"
	L["Sort by time left (ascending)"]           = "Time left"
	L["Sorting Behaviour"]          = "Sort"
	L["Default (Blizzard ordering)"]          = "None (Blizzard order)"
	L["Sort by name (descending)"]        = "Name, Descending"
	L["Default (Blizzard Style"]    = "Blizzard Style"
	L["Short (XXm)"]      = "short time (XXm)"
	L["Full (XX:XX)"]       = "always long time (XX:XX)"
	L["Change the timer format for this bar"]        = "Change the time between Wisent or Blizzard style."
	L["Timer Style"]         = "Timer Presentation"
	L["Version"]           = "Version"
	L["Print the addon's version"]       = "Prints the current version."
	L["Adds additional space between icons. Use negative values to reverse the direction of the bar"]      = "Horizontal space between buttons (min: -20, max: 20). A negativ value change the direction of the bar."
	L["Horizontal Padding"]      = "Horizontal Space"
	L["Adds additional space between icons. Use negative values to reverse the direction of the bar"]      = "Vertical space between buttons (min: -50, max: 50). A negativ value change the direction of the bar."
	L["Vertical Padding"]      = "Vertical Space"
end

do
	local L = al:NewLocale( MAJOR, "deDE")
	if L then 
		L["BuffBar"]          = "Buffs" 
		L["ComboBar"]         = "Combos"
		L["DebuffsBar"]      = "Debuffs"
		L["Appearance and Behaviour"]        = "Aussehen der Buffleiste"
		L["WeaponEnchants Bar"]         = "Waffen"
		L["SpellProcs Bar"]           = "Progs"
		L["CancelAura"]        = [[
Wisent Cancel Aura : "%s"

Blizzard änderte den Aufruf von CancelUnitBuff. Jetzt kann diese Funtion nur noch in einer sicheren Umgebung mit SecureButtons benutzt werden. Die Handhabung der sicheren Buttons ist sehr eingeschränkt. Ich beutze diese Zwischenlösung für den Moment.

Diese Zeile kopieren und in den Chat einfügen.]]
		L["Number of colums"]          = "Anzahl Spalten"
		L["Columns"]         = "Anzahl Spalten"
		L["Toggle debug mode (not particularly useful unless something has gone terribly wrong)"]         = "Zeige Debug Nachrichten an. Wird nur zum Testen gebraucht."
		L["Debug Mode"]         = "Debug"
		L["Provides an easily customizable display for buffs, debuffs, and spell procs"]       = "Freie Positionierung und Darstellung aller User Buffs, Debuffs und Waffen Verzauberungen."
		L["Enable the addon (will disable Blizzard's default buff bars)"]       = "Aktiviert das Addon und versteckt die Standardanzeige von Blizzard."
		L["Enabled"]      = "Addon Aktivieren"
		L["Flash button as the buff duration approaches zero"]      = "Blinken bei Ablauf des Buffs"
		L["Enable Flashing"]      = "Blinken Erlauben"
		L["Show Blizzard's buff bars (regardless of whether or not Wisent is enabled"]        = "Erzwingt jetzt die Sichtbarkeit der Blizzards Buffframes."
		L["Show Blizzard buff bars"]         = "Erzwinge Buff Frames"
		L["It appears that Blizzard's buff bars have been disabled (by another addon). Please check and make sure to disable the respective addon's options to let Wisent handle this."]         = "Blizzard Buffframes sind durch ein anderes Addon deaktiviert worden. Du solltest diese Option in deinen anderen Addons daktivieren."
		L["Help"]              = "Hilfe"
		L["Align buff icons horizontally before moving to a new row"]   = "Die Richtung vorgeben, in der die Buttons beginnend angezeigt werden sollen"
		L["Horizontal Alignment"]    = "Horizontal zuerst"
		L["Consolidate some buffs"]         = "Bestimmte Buffs zusammenfassen."
		L["Consolidate Buffs"]         = "Buffs zusammenfassen"
		L["Enable LibButtonFacade if present"]          = "Erlaube die Bibliothek Buttonfacade, wenn vorhanden."
		L["Enable LBF"]           = "LBF erlauben"
		L["Lock all bars in place and prevent them from being moved"]          = "Nach Anpassung der Positionen der einzelnen Leisten, werden diese verriegelt."
		L["Lock Bars"]         = "Buttons verriegeln"
		L["Number of buttons to display on this bar"]        = "Maximal sichtbare Anzahl von Buttons."
		L["Size"]        = "Anzahl"
		L["General Settings"]       = "allgemeine Optionen"
		L["Number of rows"]          = "Anzahl Zeilen"
		L["rows"]          = "Anzahl Zeilen"
		L["Scale all buff icons by this factor"]         = "Größe des Buttons"
		L["Scale Factor"]         = "Größe"
		L["Toggle this bar and all of its icons"]         = "Buttons anzeigen oder verstecken"
		L["Enable Bar"]          = "Buttons Leiste Anzeigen"
		L["Sort by name (ascending)"]         = "Alphabetisch"
		L["Sort by time left (descending)"]          = "Restzeit abnehmend"
		L["Set how the icons should be sorted"]          = "Legt die Sortierung der Bar fest."
		L["Sort by duration (ascending)"]   = "Dauer zunehmend"
		L["Sort by duration (descending)"] = "Dauer abnehmend"
		L["Sort by time left (ascending)"]           = "Restzeit zunehmend"
		L["Sorting Behaviour"]          = "Sortierung"
		L["Default (Blizzard ordering)"]          = "Keine (Blizzard Reihenfolge)"
		L["Sort by name (descending)"]        = "Alphabetisch absteigend"
		L["Change the timer format for this bar"]        = "Zeit in Wisent- oder Blizzard-Art darstellen"
		L["Timer Style"]         = "Zeitdarstellung"
		L["Version"]           = "Version"
		L["Print the addon's version"]       = "Druckt die aktuelle Version aus."
		L["Adds additional space between icons. Use negative values to reverse the direction of the bar"]      = "Den horizontaler Abstand zwischen den Buttons einstellen (Min: -20, Max: 20). Negativer Wert ändert die Richtung der Buttonanzeige"
		L["Horizontal Padding"]      = "horizontaler Zwischenraum"
		L["Adds additional space between icons. Use negative values to reverse the direction of the bar"]      = "Den vertikale Abstand zwischen den Buttons einstellen (Min: -50, Max: 50). Negativer Wert ändert die Richtung der Buttonanzeige"
		L["Vertical Padding"]      = "vertikale Zwischenraum"
	end
end

do
	local L = al:NewLocale( MAJOR, "frFR")
	if L then 
		L["BuffBar"]          = "Barre de Buffs"
		L["DebuffsBar"]      = "Barre de Debuff"
		L["Appearance and Behaviour"]        = "Apparence des barres"
		L["WeaponEnchants Bar"]         = "Barre des Armes"
		L["SpellProcs Bar"]           = "Progs"
		L["Number of colums"]          = "Nombre de colonnes"
		L["Columns"]         = "Colonnes"
		L["Toggle debug mode (not particularly useful unless something has gone terribly wrong)"]         = "Montrer les messages de debugging. Pour tests seulement."
		L["Debug Mode"]         = "Debug"
		L["Provides an easily customizable display for buffs, debuffs, and spell procs"]       = "Positionnement et presentation libres de tout les buffs, debuffs et enchantements d'armes."
		L["Enable the addon (will disable Blizzard's default buff bars)"]       = "Activer l addon et cacher les barres standards de Blizzard."
		L["Enabled"]      = "Activer les Barres"
		L["Flash button as the buff duration approaches zero"]      = "Flash en fin."
		L["Enable Flashing"]      = "Activer le flash"
		L["Align buff icons horizontally before moving to a new row"]   = "Premiere direction pour afficher les boutons."
		L["Horizontal Alignment"]    = "Horizontalement en premier"
		L["Consolidate some buffs"]         = "Regrouper les buffs speciaux."
		L["Consolidate Buffs"]         = "Regrouper les buffs"
		L["Lock all bars in place and prevent them from being moved"]          = "Verrouiller toutes les barres apres selection de leur position."
		L["Lock Bars"]         = "Verouiller les boutons"
		L["Number of buttons to display on this bar"]        = "Nombre maximal de boutons visibles."
		L["Size"]        = "Taille"
		L["General Settings"]       = "Options communes"
		L["Number of rows"]          = "Nombre de lignes"
		L["rows"]          = "Lignes"
		L["Scale all buff icons by this factor"]         = "Taille des boutons."
		L["Scale Factor"]         = "Echelle"
		L["Toggle this bar and all of its icons"]         = "Cacher et montrer les boutons."
		L["Enable Bar"]          = "Afficher la barre de boutons"
		L["Sort by name (ascending)"]         = "Nom"
		L["Sort by time left (descending)"]          = "Temps restant, Decroissant"
		L["Set how the icons should be sorted"]          = "Regler le tri des icones de buffs"
		L["Sort by duration (ascending)"]   = "Duree"
		L["Sort by duration (descending)"] = "Duree, Decroissante"
		L["Sort by time left (ascending)"]           = "Temps restant"
		L["Sorting Behaviour"]          = "Tri"
		L["Default (Blizzard ordering)"]          = "Aucun (Ordre de Blizzard)"
		L["Sort by name (descending)"]        = "Nom, inverse"
		L["Change the timer format for this bar"]        = "Intervertir le temps entre le style Wisent et Blizzard."
		L["Timer Style"]         = "Presentation du temps"
		L["Version"]           = "Version"
		L["Print the addon's version"]       = "Afficher la version courante"
		L["Adds additional space between icons. Use negative values to reverse the direction of the bar"]      = "Espace horizontal entre les boutons (min: -20, max: 20). Une valeur negative change la direction de la barre."
		L["Horizontal Padding"]      = "Espace Horizontal"
		L["Adds additional space between icons. Use negative values to reverse the direction of the bar"]      = "Espace vertical entre les boutons (min: -50, max: 50). Une valeur negative change la direction de la barre."
		L["Vertical Padding"]      = "Espace Vertical"
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
		L["BuffBar"]          = "Иконки баффов" 
		L["DebuffsBar"]      = "Иконки дебаффов"
		L["Appearance and Behaviour"]        = "Вид панели иконок"
		L["WeaponEnchants Bar"]         = "Иконки оружия"
		L["Number of colums"]          = "Количество колонок"
		L["Columns"]         = "Колонки"
		L["Toggle debug mode (not particularly useful unless something has gone terribly wrong)"]         = "Отображение отладочной информации. Требуется только для тестирования."
		L["Debug Mode"]         = "Отладка"
		L["Provides an easily customizable display for buffs, debuffs, and spell procs"]       = "Позволяет свободно размещать и отображать все пользовательские баффы, дебаффы и зачарования оружия."
		L["Enable the addon (will disable Blizzard's default buff bars)"]       = "Активирует аддон и скрывает стандартный фрейм (де)баффов."
		L["Enabled"]      = "Включить"
		L["Flash button as the buff duration approaches zero"]      = "Мигание при заканчивании времени."
		L["Enable Flashing"]      = "Включить мигание"
		L["Align buff icons horizontally before moving to a new row"]   = "Первое направление для отображения иконок."
		L["Horizontal Alignment"]    = "Первое по горизонтали"
		L["Lock all bars in place and prevent them from being moved"]          = "Фиксирует все иконки после определения их позиций."
		L["Lock Bars"]         = "Фиксировать иконки"
--		L["Number of buttons to display on this bar"]        = "Maximal visible number of buttons."
--		L["Size"]        = "Size"
		L["General Settings"]       = "Общие настройки"
		L["Number of rows"]          = "Количество рядов"
		L["rows"]          = "Ряды"
		L["Scale all buff icons by this factor"]         = "Размер иконок."
		L["Scale Factor"]         = "Масштаб"
		L["Toggle this bar and all of its icons"]         = "Отображение/сокрытие иконок."
		L["Enable Bar"]          = "Панель иконок"
		L["Sort by name (ascending)"]         = "Название"
		L["Sort by time left (descending)"]          = "Остаток, Убывание"
		L["Set how the icons should be sorted"]          = "Установка сортировки иконок баффов"
		L["Sort by duration (ascending)"]   = "Длительность"
		L["Sort by duration (descending)"] = "Длительность, Убывание"
		L["Sort by time left (ascending)"]           = "Остаток"
		L["Sorting Behaviour"]          = "Сортировка"
		L["Default (Blizzard ordering)"]          = "Нету (Blizzard order)"
		L["Sort by name (descending)"]        = "Название, Убывание"
		L["Change the timer format for this bar"]        = "Изменение стиля время между Wisentовским или Blizzardским."
		L["Timer Style"]         = "Отображение времени"
		L["Version"]           = "Версия"
		L["Print the addon's version"]       = "Выводит информации о версии."
		L["Adds additional space between icons. Use negative values to reverse the direction of the bar"]      = "Промежуток по горизонтали между иконками (мин: -20, макс: 20). Отрицательное значение изменит направление панели."
		L["Horizontal Padding"]      = "Промежуток - Горизонталь"
		L["Adds additional space between icons. Use negative values to reverse the direction of the bar"]      = "Промежуток по вертикали между иконками (мин: -50, макс: 50). Отрицательное значение изменит направление панели."
		L["Vertical Padding"]      = "Промежуток - Вертикаль"
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
