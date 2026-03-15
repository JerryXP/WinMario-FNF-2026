function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is the note it is
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'halfBlammed Note' then
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.texture', 'noteassetshit/splash/halfBlamSplash'); --Change texture
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteassetshit/HALFBLAMNOTE_assets'); --Change texture
            setPropertyFromGroup('unspawnNotes', i, 'missHealth', '1'); --Change texture


			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
                setPropertyFromGroup('unspawnNotes', i, 'rgbShader.enabled', false)
			end
		end
	end
	--debugPrint('Script started!')
end