package states.creditsSource;

import mikolka.funkin.custom.mobile.MobileScaleMode;
import objects.AttachedSprite;

class WinMarioCreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:FlxColor;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		var defaultList:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color.
			["Vs. WinMario Owner"],
			["WM/LXP",		        "win",		        "The one who made this Mod",					       "https://www.youtube.com/@WinMario_YT",	"8000FF"],
			["Support Friends"],
			["DinoEvan.21",		        "missing_icon",		     "Originally Made Mr. Glitch's Final Form",	  "https://www.youtube.com/@Dinoevan.21",	"FF0000"],
			["Paxton",		        "pinky",		        "Special Thanks for no reason",					      "https://www.youtube.com/@um.anoptx",	"B0609F"],
			[""],
			["Windows Mario's Discord"],
			["Join My Discord!",    "windiscord",    "if you are under 13, ignore it.",                             "https://discord.gg/p5kd2sExBN",    "400080"],
			[""],
			#if mac
			["MacOS Port"],
			["WM/LXP",		        "win",		        "Used VMware",					       "https://www.youtube.com/@WinMario_YT",	"8000FF"],
			[""],
			#end
			#if ios
			["iOS Port"],
			["???",    "missing_icon",    "Helped Port iOS",                                "",    				"808080"],
			[""],
			#end
			#if linux
			["Linux Port"],
			["WM/LXP",    "win",    "Port Linux by using WSL Command",                          "https://www.youtube.com/@WinMario_YT",    				"8000FF"],
			[""],
			#end
			#if android
			["Android Port"],
			["???",    "missing_icon",    "Helped Port Android",                                "",    			"808080"],
			[""],
			#end
			["Songs"],
			["Tsuraran",		        "missing_icon",		        "Salty's Sunday Night",					       "https://www.youtube.com/@Tsuraran",	"808080"],
			["YingYang48",		        "missing_icon",		        "Vs. Hex",					       			"https://www.youtube.com/@YingYang48",	"808080"],
			["joolie",		        "missing_icon",		        "Vs. Bambi Strident Crisis",				"https://www.youtube.com/@joolieiscool",	"808080"],
			["Keymo",		        "missing_icon",		        "Friday Night Funkin: Pibby Corrupted",					"https://x.com/SmokeDeveloper",	"808080"],
			["Rareblin",		        "missing_icon",		        "Vs. Imposter ; Vs. Him",					   "https://www.youtube.com/@Rareblin",	"808080"],
			["punkett",		        "missing_icon",		        "Vs. Imposter",					       				"https://www.youtube.com/@punkett",	"808080"],
			["Rozebud",		        "missing_icon",		        "Friday Night Funkin B-Side Remix",					"https://www.youtube.com/@Rozebud",	"808080"],
			["JADS",		        "missing_icon",		        "Shiver",				"https://www.youtube.com/@JADSCastle",							"808080"],
			["fluffyhairs",		        "missing_icon",		        "Corruption",					       "https://www.youtube.com/@fluffyhairsmusic",	"808080"],
			["bb-panzu",			"bb",				"Holiday Mod (p2) ; Vs. Carol ; Date Week",					"https://x.com/bbsub3",				"3E813A"],
			["Biddle3",		        "missing_icon",		        "Chaos Nightmare ; FNF B3 Remix",				"https://www.youtube.com/@therealb3",	"808080"],
			["Penguin 123-452",		        "missing_icon",	"Confronting Yourself (vocals)",				"https://www.youtube.com/@Penguin123452ac",	"808080"],
			["Saster",		        "missing_icon",	          "Confronting Yourself (inst)",				"https://www.youtube.com/@Penguin123452ac",	"808080"],
			["Vruzzen",		        "missing_icon",		        "Vs. Imposter",					       "",												"808080"],
			["Jhaix",		        "missing_icon",		        "Wednesday's Infidelity",							"https://www.youtube.com/@Jhaix",	"808080"],
			["Cynda/Jade",		        "missing_icon",		"Dave and Bambi: Golden Apple Edition",				"https://www.youtube.com/@jaduplex",	"808080"],
			["JellyFish!",		        "missing_icon",		        "Friday NIght Funkin Neo",				"https://www.youtube.com/@JellyFish-Music",	"808080"],
			["Saruky",		        "missing_icon",		        "Friday Night Funkin (duh :/) ; Corruption",	"https://www.youtube.com/c/Saruky",		"808080"],
			["EthanTheDoodler",		        "missing_icon",		     "Vs. Imposter",					"https://x.com/D00dlerEthan",					"808080"],
			["wildy",		        "missing_icon",		"literally every fnf mod ever (Bob Onslaught)",			"https://www.youtube.com/@wildy1233",	"808080"],
			["Sky!",		        "missing_icon",		"Dave and Bambi: Golden Apple Edition",				"https://www.youtube.com/@SkyFactorial",	"808080"],
			["Savestate Corrupted",	"missing_icon",		  "VS Carol: Expanded",								"https://gamebanana.com/members/1914394",	"808080"],
			["GRYSCL ._.",		        "missing_icon",		        "Corruption",				"https://www.youtube.com/@GRYSCL",						"808080"],
			["MAXPROLOVER988",		        "missing_icon",		        "TWIDDLEFINGER",		"https://x.com/maxprolover988?lang=en",					"808080"],
			["Kohta Takahashi",		        "missing_icon",		     "Friday Night Funkin (duh :/)",			"https://twitter.com/kohta09",			"808080"],
			["AadstaPinwheel",		    "missing_icon",	 "Dave and Bambi: Golden Apple Edition",			"https://www.youtube.com/c/AadstaPinwheel",	"808080"],
			["Hazardous 24",		        "missing_icon",		        "Vs. QT Mod",				"https://www.youtube.com/@hazard2463",				"808080"],
			["Taluen",		        "missing_icon",		     "Vs. Imposter B-Side",				"",														"808080"],
			["Sandi",		    "missing_icon",	 	"Wednesday's Infidelity",				"https://www.youtube.com/@Sandi334_",						"808080"],
			["Tenzu/T\"zalt",		        "missing_icon",		        "Vs. Tabi",				"https://www.youtube.com/@Tenzalt",						"808080"],
			["KyleGFX",		        "missing_icon",		     "literally every fnf mod ever (Bob Onslaught)",	"https://www.youtube.com/@KyleGFX",		"808080"],
			["MarStarBro",		    "missing_icon",	 				"Vs. Sonic.EXE",			"https://www.youtube.com/c/MarStarBro",					"808080"],
			["DatDavi",		        "missing_icon",		     "Corruption",				"https://www.youtube.com/@datdavi",								"808080"],
			["SimplyCrispy",		        "missing_icon",		      "Corruption",				"https://gamebanana.com/members/1716639",				"808080"],
			["CheeseWithCake",		    "missing_icon",	 	"Velma Meets the Original Velma:\nRemembrance",		"https://gamebanana.com/members/2044033",	"808080"],
			["myakish.",		        "missing_icon",		     "Remembrance Final Mix",		"https://www.youtube.com/@myakiYeY",   "808080"],
			[""],
			["Scripts"],
			["Uhard999",		        "missing_icon",		        "Watermark and Health",					  "https://gamebanana.com/members/1872659",	"808080"],
			["DaPootisBirdYT",		        "missing_icon",		        "Winning Icon",					  "https://gamebanana.com/members/2031145",		"808080"],
			["daBlowBoi",		        "missing_icon",		        "Judgemental Script (edit by me)",	"https://gamebanana.com/members/1872659",		"808080"],
			["The blobby man13",		        "missing_icon",		  "opponent note color script",		"https://gamebanana.com/members/2723067",		"808080"],
			["Gabio",		        "missing_icon",	   			"ending image",	 							"",											"808080"],
			["Stilic",		        "missing_icon",		        "Note Combo",					  "https://gamebanana.com/members/1893262",				"808080"],
			["Rodney~ An Imaginative Furball",		    "missing_icon",		  "Stage Changer",	"https://gamebanana.com/members/1729833",				"808080"],
			["Pf0r",		        "missing_icon",		        "Another Stage Changer",		"https://gamebanana.com/members/1823815",				"808080"],
			["JoLteon:D",		        "missing_icon",	   "Opponent Note Fade",	 "https://gamebanana.com/members/1919640",							"808080"],
			["BlueColorsin",		    "missing_icon",	   			"Modchart Bounce (Detected)",	 		"",											"808080"],
			["Super_Hugo",	 "missing_icon",		 "Blammed Lights & Philly Glow Recreation",		"https://gamebanana.com/members/2151945",			"808080"],
			["Unholywanderer04",	 "missing_icon",	   "End Dialogue Script (not videos)\n(kind of? i don't think so)",	 "https://gamebanana.com/members/1919640",	"808080"],
			["RamenDominoes",		        "missing_icon",		        "Cinematics",					  "https://gamebanana.com/members/2135195",		"808080"],
			["Ledonic",		        "missing_icon",		    "Events for Win-Eggnog II & Special Week 1", "https://gamebanana.com/members/3574043",		"808080"],
			["Blu Day Studios",		        "missing_icon",		 "Note Offset Pop-up (edit by me)",		"https://gamebanana.com/members/1787581",		"808080"],
			["SonicTheFunker",		        "missing_icon",	   "Miss Limiter",	 "https://gamebanana.com/members/2377937",								"808080"],
			["TintGox",		 "tintgox",	   "Stop People from pressing 7 (Week 7 and Load Secret Song)",	 "https://gamebanana.com/members/2451343",		"008080"],
			["Saltyboii",		 "missing_icon",	   "Skip Countdown",	 "https://gamebanana.com/members/1948626",									"808080"],
			["Sebbat",		 "missing_icon",	   "Lua WaterMark",	 		"https://gamebanana.com/members/1995181",									"808080"],
			["vCherry.kAI.16",		 "missing_icon",	   "Combo break = gf cry",	 "https://gamebanana.com/members/1921624",							"808080"],
			["TimoshaForever",		 "missing_icon",	   "Timebar Color Gradient (like DDLC)",	 "https://gamebanana.com/members/2874958",			"808080"],
			[""],
			["Characters"],
			["ChazbillYT",		        "missing_icon",		        "BF alt animations",					  "https://gamebanana.com/members/2151108",	"808080"],
			["B Side Corruption Bf",		        "missing_icon",	 "glitched corrupt bf (edit by me)",	"https://gamebanana.com/members/2603529",	"808080"],
			["FrancoFunk",		        "missing_icon",		        "'angry' gf port",				"https://gamebanana.com/members/2023275",			"808080"],
			["Ito Saihara",		        "missing_icon",		        "'angry' gf og",					   "https://gamebanana.com/members/1792555",	"808080"],
			["TopazowyGolem",		        "missing_icon",		        "faceless bf",					"https://gamebanana.com/members/2488080",		"808080"],
			["Obvious_pyro_lol",		        "missing_icon",		   "corrupt glitch bf 2 (edit by me)",	"https://gamebanana.com/members/1792555",	"808080"],
			["LeoroyX",		        "missing_icon",	 "Made Halloween Skins for BF and GF",	"https://gamebanana.com/members/1984189",					"808080"],
			["Mickle Pickle",		        "missing_icon",		        "Pico Reskin (edit by me)",		"https://gamebanana.com/members/2023275",		"808080"],
			["This is fine",		        "missing_icon",		        "Made Erect BF & GF",				"https://gamebanana.com/members/1800297",	"808080"],
			["BarcaTripleLM10",		        "missing_icon",		        "Made Oliver Sprites",			"https://gamebanana.com/members/2343718",		"808080"],
			["chibisprinklez",		        "missing_icon",		   "Made GF (playable)",	"https://gamebanana.com/members/2551278",					"808080"],
			["Lc1230",		        "missing_icon",		        "Cool BF",				"https://gamebanana.com/members/1839921",						"808080"],
			["Paulcrew1077",		        "missing_icon",		        "Hoodie GF",				"https://gamebanana.com/members/1958648",			"808080"],
			["DylanTails876",		        "missing_icon",		  "Character Slect BF Speaker",			"https://gamebanana.com/members/1920694",		"808080"],
			["NoLime",		        "missing_icon",		   "Christmas GF & BF",				"https://gamebanana.com/members/1762727",					"808080"],
			["FNF Pibby Corrupted",	"missing_icon",	"Glitched Characters for\nSpecial Week 5 (this is NOT CANON)",	"https://gamebanana.com/mods/344757",	"808080"],
			[""],
			["Shaders"],
			["TheZoroForce240",		        "missing_icon",		        "RTX Shader",					  "https://gamebanana.com/members/1708748",		"808080"],
			["Whj1",		        "missing_icon",	 		"Lights Shader (Blue Balled + Oversight)",			"",										"808080"],
			["Boysx",	"missing_icon",      "Glitch Shader\n(Terminal, Ejected, Week 6, & Special Week 5)",		"",									"808080"],
			[""],
			["Sprites/Assets"],
			["Kaechii",		        "missing_icon",		        "Week 1 & Special 1 Sprites",			"https://gamebanana.com/members/1826252",		"808080"],
			["NoLime",		        "missing_icon",	 		"Week 5 Sprites (vibin)",			"https://gamebanana.com/members/1762727",				"808080"],
			["OliverGamingAtPaperSchool",	"missing_icon",      "Tabi for Older Noteskin\n(+Special Thanks)",		"https://www.youtube.com/@OliverGamingAtPaperSchool",	"808080"],
			["Olivier99",		"missing_icon",	"Step Mania (Future One) & Metal (Chip One)",			"https://gamebanana.com/members/1860941",		"808080"],
			["ShapeShifty",		        "missing_icon",	 		"Pibby For Week 7 + Pibby Hurt Note\n(same function as poison note)",		"https://gamebanana.com/members/2062860",	"808080"],
			["BloomEld",	"missing_icon",      "New Noteskin (entity + edit by me)\nOld noteskin (shiny) Note RGB Support",		"https://gamebanana.com/members/2951815",	"808080"],
			["Ghost1906081",	"missing_icon",      "Original for Shiny Note",		"https://gamebanana.com/members/1906081",							"808080"],
			["te-agmaat032", "missing_icon",		"Special Note Mechanics Pack (edit by me)",			"https://gamebanana.com/members/1769584",		"808080"],
			["Punkinator7",	"missing_icon",	 "Special Note Mechanics Pack (edit by me)",			"https://gamebanana.com/members/1687904",			"808080"],
			["TreyTM",	"missing_icon",      "Darkened Stage",										"https://gamebanana.com/members/1810603",			"808080"],
			["obvious_pyro_lol",		"missing_icon",			"deathmatch stage for psych engine",	"https://gamebanana.com/members/1858522",		"808080"],
			["GeistGaming",		"missing_icon",			"Stage RTX (for Trouble (SP))",						"https://gamebanana.com/members/1940560",		"808080"],
			["Corruption Mod Recreation",	"missing_icon",	 	"Lament & Dusk Stage",			"https://gamebanana.com/mods/490400",					"808080"],
			["Dave and Bambi",	"missing_icon",      "Healthbar (edit by me)",						"https://gamebanana.com/mods/43201",				"808080"],
			["Marked Engine",		"missing_icon",			"'TitleEnter' Sprite",				"https://gamejolt.com/games/markedengine/915932",		"808080"],
			["Indie Cross",		"missing_icon",			"Note Splash",						"https://gamejolt.com/games/indiecross/643540",					"808080"],
			["ENTITY",		"missing_icon",			"Noteskin",									"https://gamebanana.com/mods/284934",					"808080"],
			[""],
			["Other/Misc"],
			["Ranified",		        "missing_icon",		        "BF UTAU Soundfont Pack",			"https://gamebanana.com/members/2068912",		"808080"],
			["ChessyCessy",		        "missing_icon",	 		"CYS Chart (Hard)",			"https://gamebanana.com/members/1817227",					"808080"],
			["BunnyDeimos",	"missing_icon",      "Detected Chart (Insane)",		"https://gamebanana.com/members/2045451",								"808080"],
			["Booify",		"missing_icon",			"High Effort Chart on Final Mix Remembrance",		"https://gamebanana.com/members/1780900",		"808080"],
			["Antreys",		        "missing_icon",	 		"helped with booify's Remembrance FM",		"https://gamebanana.com/members/2137542",		"808080"],
			["Neo",				"missing_icon",      		"gameOverEnd",					"https://gamebanana.com/mods/44230",						"808080"],
			["Sonic.EXE Ring of Despair",	"missing_icon",      "CYS Chart (Insane)",		"https://gamebanana.com/mods/350134",						"808080"],
			["FNF DJX", 	"missing_icon",		"The Origin of The Soundfont for Me and my Evil Clone",			"https://gamebanana.com/mods/412412",	"808080"],
			["High Effort Chart on Final Mix Remembrance",	"missing_icon",	 "Chart for Remebrance Final Mix (SP)",			"https://gamebanana.com/mods/430405",	"808080"],
			["Mix_Mix007",	"missing_icon",	 "Sf2 for UTAU GF",			"https://gamebanana.com/members/1963292",										"808080"],
			["Nintendo",	"missing_icon",	 "Mario Galaxy 1 & 2 & Kirby Dream Land GB\nand etc.",			"https://x.com/NintendoAmerica",			"FF0000"],
			["Sega",	"missing_icon",	 			"Sounds",							"https://x.com/SEGA",											"0000FF"],
			["M*cr*s*ft",	"missing_icon",	 			"Sounds",							"https://x.com/Microsoft",									"00FF00"],
			[""],
			["Code"],
			["MrpoloOfficial",		        "missing_icon",		        "Intro Video (edit by me)",			"https://gamebanana.com/members/2307558",	"808080"],
		];
		
		for(i in defaultList)
			creditsStuff.push(i);
	
		for (i => credit in creditsStuff)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(FlxG.width / 2, 300, credit[0], !isSelectable);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.changeX = false;
			optionText.snapToPosition();
			grpOptions.add(optionText);

			if(isSelectable)
			{
				var str:String = 'credits/missing_icon';
				if(credit[1] != null && credit[1].length > 0)
				{
					var fileName = 'credits/' + credit[1];
					if (Paths.fileExists('images/$fileName.png', IMAGE)) str = fileName;
					else if (Paths.fileExists('images/$fileName-pixel.png', IMAGE)) str = fileName + '-pixel';
				}

				var icon:AttachedSprite = new AttachedSprite(str);
				if(str.endsWith('-pixel')) icon.antialiasing = false;
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);

				if(curSelected == -1) curSelected = i;
			}
			else optionText.alignment = CENTERED;
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		var txtWidthOffset:Float = Math.max(MobileScaleMode.gameCutoutSize.x / 2,50);

		descText = new FlxText(txtWidthOffset, FlxG.height + offsetThing - 25, FlxG.width-(txtWidthOffset*2), "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = CoolUtil.colorFromString(creditsStuff[curSelected][4]);
		intendedColor = bg.color;
		changeSelection();
		#if TOUCH_CONTROLS_ALLOWED
		addTouchPad('UP_DOWN', 'A_B');
		#end
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(controls.ACCEPT && (creditsStuff[curSelected][3] == null || creditsStuff[curSelected][3].length > 4)) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK)
			{
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new options.CreditsChoice());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.bold)
			{
				var lerpVal:Float = Math.exp(-elapsed * 12);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(item.x - 70, lastX, lerpVal);
				}
				else
				{
					item.x = FlxMath.lerp(200 + -40 * Math.abs(item.targetY), item.x, lerpVal);
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do
		{
			curSelected = FlxMath.wrap(curSelected + change, 0, creditsStuff.length - 1);
		}
		while(unselectableCheck(curSelected));

		var newColor:FlxColor = CoolUtil.colorFromString(creditsStuff[curSelected][4]);
		//trace('The BG color is: $newColor');
		if(newColor != intendedColor)
		{
			intendedColor = newColor;
			FlxTween.cancelTweensOf(bg);
			FlxTween.color(bg, 1, bg.color, intendedColor);
		}

		for (num => item in grpOptions.members)
		{
			item.targetY = num - curSelected;
			if(!unselectableCheck(num)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		if(descText.text.trim().length > 0)
		{
			descText.visible = descBox.visible = true;
			descText.y = FlxG.height - descText.height + offsetThing - 60;
	
			if(moveTween != null) moveTween.cancel();
			moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});
	
			descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
			descBox.updateHitbox();
			
		}
		else descText.visible = descBox.visible = false;
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}
