local Countdown = -1
local Dodged = 0

function onEvent(name, value1, value2)
    if name == "Custom Dodge Event" then
        local beats = tonumber(value1)
        if beats == nil or beats < 0 then return end

        Countdown = beats + 1  -- gives a full beat window
        Dodged = 0
    end
end

function onBeatHit()
    if Countdown > -1 then
        Countdown = Countdown - 1

        if Countdown > 0 then
            playSound('warningSounds/' .. tostring(Countdown), 1)
        elseif Countdown == 0 then
            -- do nothing yet — input handled in onUpdate
        elseif Countdown == -1 and Dodged == 0 then
            -- player failed to dodge in time
            Dodged = 2
            setHealth(getHealth() - 0.2) -- Change this value to drain health on miss (1 = full healthbar)
            triggerEvent('Screen Shake', '0.2, 0.02', '')
        end
    end
end

function onUpdate()
    if Countdown == 0 and Dodged == 0 then
        if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') or getProperty('cpuControlled') then
            Dodged = 1
            Countdown = -1
            setHealth(getHealth() + 0.1) -- Change this value to add health on hit (1 = full healthbar)
        end
    end


    if Dodged == 1 then
        playAnim('boyfriend', 'dodge', true)
        Dodged = 0
    elseif Dodged == 2 then
        Dodged = 0
    end
end
