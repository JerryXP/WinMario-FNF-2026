function onCreate()
    makeLuaText('difficult', difficultyName .. "", 0, 10, 690); -- You can edit the created by Prisma Text just dont change anything else
    setTextSize('difficult', 20);
    addLuaText('difficult');
end

function onUpdatePost()
    if difficultyName == 'Easy' then
        setTextColor('difficult', '0x00FF00');
    elseif difficultyName == 'Normal' then
        setTextColor('difficult', '0xFFFF00');
    elseif difficultyName == 'Hard' then
        setTextColor('difficult', '0xFF0000');
    elseif difficultyName == 'Insane' then
        setTextColor('difficult', '0xFF00FF');
    elseif difficultyName == 'Finale' then
        setTextColor('difficult', '0xC0C0C0');
    end
end