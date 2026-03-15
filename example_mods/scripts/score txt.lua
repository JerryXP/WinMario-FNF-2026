--Since I can't get that scoreTxt miss limiter to add that. (because when I add that and changes back to normal
-- So it can do without missing alot. so please don't touch it.

function onCreate()
    if songName == 'danger' and songName == 'defeat' and songName == 'twiddlefinger' then
        makeLuaText('rankTxt', "Rank:" .. rankName .. " - " .. floorDecimal(ratingPercent * 100, 2)..  "", 0, 10, 650); -- You can edit the created by Prisma Text just dont change anything else
        setTextSize('rankTxt', 20);
        addLuaText('rankTxt');
        setTextFont('rankTxt', 'glitch.ttf');
    end
end