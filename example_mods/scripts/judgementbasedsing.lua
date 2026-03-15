local lastNoteRating = "unknown"

function goodNoteHit(id, direction, noteType, isSustainNote)
	local rating = getPropertyFromGroup('notes', id, 'rating')
	if isSustainNote then rating = lastNoteRating end
    if rating == 'sick' and direction == 0 then
        characterPlayAnim('boyfriend','singLEFT-alt','true')
    elseif rating == 'sick' and direction == 1 then
        characterPlayAnim('boyfriend','singDOWN-alt','true')
    elseif rating == 'sick' and direction == 2 then
        characterPlayAnim('boyfriend','singUP-alt','true')
    elseif rating == 'sick' and direction == 3 then
        characterPlayAnim('boyfriend','singRIGHT-alt','true')
    end
	lastNoteRating = rating
end