local al = LibStub('AceLocale-3.0')

do
	local L = al:NewLocale('Bison', 'enUS', true)
	L.Description    = 'Free positioning and presentation of all user buffs, debuffs and weapon enchantments.'
	L.Version        = 'Version: %s %s(%s)%s'
	L.VersionDesc    = 'Prints the current version'
	L.BarBuff        = 'Buff Buttons' 
	L.BarDebuff      = 'Debuff Buttons'
	L.BarWeapon      = 'Weapon Buttons'
	L.LockName       = 'Button Lock'
	L.LockDesc       = 'Lock all bars after select there positions.'
	L.DebugName      = 'Debug'
	L.DebugDesc      = 'Show debug messages. Only need for testing.'
	L.EnabledName    = 'Button Enabled'
	L.EnabledDesc    = 'Activate the addon and hide the Blizzard standard bars.'
	L.ShowName       = 'Show Button Bar'
	L.ShowDesc       = 'Hide and show buttons.'
	L.FlashingName   = 'Enable Flashing'
	L.FlashingDesc   = 'Flashing at end.'
	L.TimerName      = 'Timer Presentation'
	L.TimerDesc      = 'Change the time between Bison or Blizzard style.'
	L.ScaleName      = 'Scale'
	L.ScaleDesc      = 'Size of the buttons.'
	L.XPaddingName   = 'Horizontal Space'
	L.XPaddingDesc   = 'Horizontal space between buttons (min: -20, max: 20). A negativ value change the direction of the bar.'
	L.YPaddingName   = 'Verticale Space'
	L.YPaddingDesc   = 'Verticale space between buttons (min: -50, max: 50). A negativ value change the direction of the bar.'
	L.HorizontalName = 'Horizontal First'
	L.HorizontalDesc = 'First dirction for display buttons.'
	L.RowsName       = 'Rows'
	L.RowsDesc       = 'Number of rows'
	L.ColsName       = 'Columns'
	L.ColsDesc       = 'Number of columns'
	L.SortName       = 'Sort'
	L.SortDesc       = 'Set the sorting of the buff icons'
	L.OptionName     = 'Common Option'
	L.BarName        = 'Button Bar Look'
	L.Profile        = 'Profile'
	L.AvailableProfiles = 'Available Profiles'
	L.ProfileCreated    = 'Created new profile "%s"'
	L.ProfileLoaded     = 'Set profile to "%s"'
	L.ProfileDeleted    = 'Deleted profile "%s"'
	L.ProfileCopied     = 'Copied settings from "%s"'
	L.ProfileReset      = 'Reset profile "%s"'
	L.SortNone         = 'None (Blizzard order)'
	L.SortAlpha        = 'Name'
	L.SortRevert       = 'Name, Descending'
	L.SortInc          = 'Time left'
	L.SortDec          = 'Time left, Descending'
	L.SortDurationAsc  = 'Duration'
	L.SortDurationDesc = 'Duration, Descending'
end

do
	local L = al:NewLocale('Bison', 'deDE')
	if L then 
		L.Description    = 'Freie Positionierung und Darstellung aller User Buffs, Debuffs und Waffen Verzauberungen.'
		L.Version        = 'Version: %s %s(%s)%s'
		L.VersionDesc    = 'Druckt die aktuelle Version aus'
		L.BarBuff        = 'Buff Buttons' 
		L.BarDebuff      = 'Debuff Buttons'
		L.BarWeapon      = 'Waffen Verzauberungen'
		L.LockName       = 'Buttons verriegeln'
		L.LockDesc       = 'Nach Anpassung der Positionen der einzelnen Leisten, werden diese verriegelt.'
		L.DebugName      = 'Debug'
		L.DebugDesc      = 'Zeige Debug Nachrichten an. Wird nur zum Testen gebraucht.'
		L.EnabledName    = 'Addon Aktivieren'
		L.EnabledDesc    = 'Aktiviert das Addon und versteckt die Standardanzeige von Blizzard.'
		L.ShowName       = 'Buttons Leiste Anzeigen'
		L.ShowDesc       = 'Buttons anzeigen oder verstecken'
		L.FlashingName   = 'Blinken Erlauben'
		L.FlashingDesc   = 'Blinken bei Ablauf des Buffs'
		L.TimerName      = 'Zeitdarstellung'
		L.TimerDesc      = 'Zeit in Bison- oder Blizzard-Art darstellen'
		L.ScaleName      = 'Größe'
		L.ScaleDesc      = 'Größe des Buttons'
		L.XPaddingName   = 'horizontaler Zwischenraum'
		L.XPaddingDesc   = 'Den horizontaler Abstand zwischen den Buttons einstellen (Min: -20, Max: 20). Negativer Wert ändert die Richtung der Buttonanzeige'
		L.YPaddingName   = 'vertikale Zwischenraum'
		L.YPaddingDesc   = 'Den vertikale Abstand zwischen den Buttons einstellen (Min: -50, Max: 50). Negativer Wert ändert die Richtung der Buttonanzeige'
		L.HorizontalName = 'Horizontal zuerst'
		L.HorizontalDesc = 'Die Richtung vorgeben, in der die Buttons beginnend angezeigt werden sollen'
		L.RowsName       = 'Anzahl Zeilen'
		L.RowsDesc       = 'Anzahl Zeilen'
		L.ColsName       = 'Anzahl Spalten'
		L.ColsDesc       = 'Anzahl Spalten'
		L.SortName       = 'Sortierung'
		L.SortDesc       = 'Legt die Sortierung der Bar fest.'
		L.OptionName     = 'allgemeine Optionen'
		L.BarName        = 'Aussehen der Buffleiste'
		L.Profile        = 'Profil'
		L.AvailableProfiles = 'Verfügbare Profile'
		L.ProfileCreated    = 'Erstellt ein neues Profil "%s"'
		L.ProfileLoaded     = 'Setze Profil auf "%s"'
		L.ProfileDeleted    = 'Lösche Profil "%s"'
		L.ProfileCopied     = 'Kopiere Werte von "%s"'
		L.ProfileReset      = 'Rücksetzen Profil "%s"'
		L.SortNone         = 'Keine (Blizzard Reihenfolge)'
		L.SortAlpha        = 'Alphabetisch'
		L.SortRevert       = 'Alphabetisch absteigend'
		L.SortInc          = 'Restzeit zunehmend'
		L.SortDec          = 'Restzeit abnehmend'
		L.SortDurationAsc  = 'Dauer zunehmend'
		L.SortDurationDesc = 'Dauer abnehmend'
	end
end

do
	local L = al:NewLocale('Bison', 'frFR')
	if L then 
-- I need help on this translation
	end
end

do
	local L = al:NewLocale('Bison', 'esES')
	if L then 
-- I need help on this translation
	end
end

do
	local L = al:NewLocale('Bison', 'ruRU')
	if L then 
-- I need help on this translation
	end
end

do
	local L = al:NewLocale('Bison', 'koKR')
	if L then 
-- I need help on this translation
	end
end

do
	local L = al:NewLocale('Bison', 'zhCN')
	if L then 
-- I need help on this translation
	end
end

do
	local L = al:NewLocale('Bison', 'zhTW')
	if L then 
-- I need help on this translation
	end
end
