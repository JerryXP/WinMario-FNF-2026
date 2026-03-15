package mikolka.vslice.ui;

import mikolka.vslice.ui.mainmenu.DesktopMenuState;
import mikolka.compatibility.ui.MainMenuHooks;
import mikolka.compatibility.VsliceOptions;
import mikolka.vslice.ui.title.TitleState;
import mikolka.compatibility.ModsHelper;
import options.OptionsState;

class MainMenuState extends MusicBeatState
{
	#if !LEGACY_PSYCH
	public static var psychEngineVersion:String = '1.0.4'; // This is also used for Discord RPC
	#if windows
	public static var winmarioVersion:String = '2.8.2';
	#elseif (mac || linux)
	public static var winmarioVersion:String = '2.8.1';
	#end
	#else
	public static var psychEngineVersion:String = '0.6.3'; // This is also used for Discord RPC
	public static var winmarioVersion:String = 'DON\'T SUPPORT 0.6.3 BASED.';
	#end
	public static var pSliceVersion:String = '3.4.2';
	public static var funkinVersion:String = '0.7.6'; // Version of funkin' we are emulationg

	var bg:FlxSprite;
	var magenta:FlxSprite;

	var stickerSubState:Bool;

	public function new(?stickers:Bool = false)
	{
		super();
		stickerSubState = stickers;
		
	}

	override function create()
	{
		if(stickerSubState) ModsHelper.clearStoredWithoutStickers();
		else CacheSystem.clearStoredMemory();
		CacheSystem.clearUnusedMemory();
		#if (debug && !LEGACY_PSYCH)
		FlxG.console.registerFunction("dumpCache",CacheSystem.cacheStatus); 
		FlxG.console.registerFunction("dumpSystem",backend.Native.buildSystemInfo);
		#end
		
		ModsHelper.resetActiveMods();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		persistentUpdate = persistentDraw = true;

		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.antialiasing = VsliceOptions.ANTIALIASING;
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.antialiasing = VsliceOptions.ANTIALIASING;
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.color = 0xF800080;
		add(magenta);

		var winVer:FlxText = new FlxText(0, FlxG.height - 18, FlxG.width, "Vs. WinMario " + winmarioVersion, 12);
		var psychVer:FlxText = new FlxText(0, FlxG.height - 720, FlxG.width, "Psych Based: " + psychEngineVersion, 12);
		var psliceVer:FlxText = new FlxText(0, FlxG.height - 702, FlxG.width, "P-Slice Based: " + pSliceVersion, 12);
		var fnfVer:FlxText = new FlxText(0, FlxG.height - 684, FlxG.width, "FNF Based: " + funkinVersion, 12);



		winVer.setFormat(Paths.font("cool.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		psychVer.setFormat(Paths.font("time.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		psliceVer.setFormat(Paths.font("time.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		fnfVer.setFormat(Paths.font("time.ttf"), 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		
		psychVer.scrollFactor.set();
		add(psychVer);

		psliceVer.scrollFactor.set();
		add(psliceVer);

		fnfVer.scrollFactor.set();
		add(fnfVer);

		winVer.scrollFactor.set();
		add(winVer);


		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getMonth() == 7 && leDate.getDate() == 28)
			backend.Achievements.unlock('birthday');

		#if MODS_ALLOWED
		backend.Achievements.reloadList();
		#end
		#end

		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getFullYear() == 2026 && leDate.getMonth() == 1 && leDate.getDate() == 14)
			backend.Achievements.unlock('1anniversaryDev');

		#if MODS_ALLOWED
		backend.Achievements.reloadList();
		#end
		#end

		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getFullYear() == 2030 && leDate.getMonth() == 1 && leDate.getDate() == 14)
			backend.Achievements.unlock('5anniversaryDev');

		#if MODS_ALLOWED
		backend.Achievements.reloadList();
		#end
		#end

		#if ACHIEVEMENTS_ALLOWED
		var leDate = Date.now();
		if (leDate.getFullYear() == 2035 && leDate.getMonth() == 1 && leDate.getDate() == 14)
			backend.Achievements.unlock('10anniversaryDev');

		#if MODS_ALLOWED
		backend.Achievements.reloadList();
		#end
		#end

		super.create();
		#if TOUCH_CONTROLS_ALLOWED
		if (controls.mobileC)
			new mobile.states.MobileMenuState(this);
		else
		#end
		new DesktopMenuState(this);
		
	}

	function goToOptions()
	{
		MusicBeatState.switchState(new OptionsState());
		#if !LEGACY_PSYCH OptionsState.onPlayState = false; #end
		if (PlayState.SONG != null)
		{
			PlayState.SONG.arrowSkin = null;
			PlayState.SONG.splashSkin = null;
			#if !LEGACY_PSYCH PlayState.stageUI = 'normal'; #end
		}
	}

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume += 0.5 * elapsed;
		super.update(elapsed);
	}
}
