-- Function to format milliseconds into "M:SS"
function formatTime(millisecond)
    local seconds = math.floor(millisecond / 1000)
    -- string.format("%01d:%02d", minutes, remaining_seconds)
    return string.format("%01d:%02d", math.floor(seconds / 60), seconds % 60)
end

function onCreatePost()
    -- Create a new text object. Adjust position (x, y) and font properties as needed.
    makeNewText("timeTxt", "0:00 / 0:00", 10, 10)
    setTextSize("timeTxt", 20)
    -- Optional: set the color or change the font
    -- setTextFont("timeTxt", "vcr.ttf") 
end

function onUpdatePost(elapsed)
    -- Get current song position and total song length from the engine
    local currentPos = getSongPosition()
    local totalLength = songLength -- songLength is a built-in variable in Psych Engine

    -- Format the times and set the text string
    setTextString('timeTxt', "" .. formatTime(currentPos) .. " / " .. formatTime(totalLength) .. "")
end