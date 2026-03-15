--Since I can't get that scoreTxt miss limiter to add that. (because when I add that and changes back to normal
-- So it can do without missing alot. so please don't touch it.

function onCreate()
    if songName == 'danger' and songName == 'defeat' and songName == 'twiddlefinger' then
        makeLuaText('FC', ratingFC .. "", 0, 10, 630); -- You can edit the created by Prisma Text just dont change anything else
        setTextSize('FC', 20);
        addLuaText('FC');
        setTextFont('FC', 'glitch.ttf');
    end
end