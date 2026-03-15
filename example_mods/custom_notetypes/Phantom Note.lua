function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is the note it is
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Phantom Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteassetshit/PHANOTE_assets'); --Change texture


			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
                setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true)
                setPropertyFromGroup('unspawnNotes', i, 'lowPriority', true)
			end
		end
	end
	--debugPrint('Script started!')
end