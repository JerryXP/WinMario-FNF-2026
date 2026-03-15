function onUpdate()

-- For Health Above 70



if (getProperty("health")*50) > 70 then 

doTweenColor('GoodHealth', 'healthText', '00FF7F', 0.1, 'linear')

end

-- For Health Below 30



if (getProperty("health")*50) < 30 then 

doTweenColor('GoodHealth', 'healthText', 'FF0000', 0.1, 'linear')

end



-- For Health Between 31 and 69(nice)



if (getProperty("health")*50) > 31 and 

(getProperty("health")*50) < 69 then



doTweenColor('GoodHealth', 'healthText', 'FFFFFF', 0.1, 'linear')

end

end