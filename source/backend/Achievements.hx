package backend;

#if ACHIEVEMENTS_ALLOWED
import objects.AchievementPopup;
import haxe.Exception;
import haxe.Json;

#if LUA_ALLOWED
import psychlua.FunkinLua;
#end

typedef Achievement =
{
	var name:String;
	var description:String;
	@:optional var hidden:Bool;
	@:optional var maxScore:Float;
	@:optional var maxDecimals:Int;

	//handled automatically, ignore these two
	@:optional var mod:String;
	@:optional var ID:Int; 
}

enum abstract AchievementOp(String)
{
	var GET = 'get';
	var SET = 'set';
	var ADD = 'add';
}

class Achievements {
	public static function init()
	{
		createAchievement('birthday',					{name: "Happy Birthday, WM/LXP!", description: "Play this Mod on August 28", hidden: true});
		createAchievement('1anniversaryDev',			{name: "Happy 1 Year Anniversary of making FNF Mods!", description: "Play this Mod on 2/14/2026", hidden: true});
		createAchievement('5anniversaryDev',			{name: "Happy 5 Year Anniversary of making FNF Mods!", description: "Play this Mod on 2/14/2030", hidden: true});
		createAchievement('10anniversaryDev',			{name: "Happy 10 Year Anniversary of making FNF Mods!", description: "Play this Mod on 2/14/2035", hidden: true});
		createAchievement('good',					{name: "Good Ending/Normal Route", description: "You saved MacOS Wario and Yourself! Thx for playing!", hidden: true});
		createAchievement('bad',					{name: "Bad Ending/Nightmare Route", description: "How about stop cheating next time?\n Oh. just a nightmare.", hidden: true});
		createAchievement('true',					{name: "True Ending/Special Route", description: "Wow! Thank you for the amazing adventure!", hidden: true});
		createAchievement('win-week1',					{name: "What Happend?", description: "Beat Week 1"});
		createAchievement('win-week1_nomiss',					{name: "What Happend? No Miss? Awesome!", description: "Beat Week 1 on Hard or Insane\n without misses"});
		createAchievement('secret1',				{name: "The Old Version", description: "Press 7 in Cob", hidden: true});
		createAchievement('win-week2',					{name: "I will get you... Just you wait!", description: "Beat Week 2"});
		createAchievement('win-week2_nomiss',				{name: "I will ... Oh. no misses.. that's impressive", description: "Beat Week 2 on Hard or Insane\n without misses"});
		createAchievement('secret2',				{name: "You didn't see me yet!", description: "Press 7 in Blue Balled", hidden: true});
		createAchievement('win-week3',					{name: "Nice Round!", description: "Beat Week 3"});
		createAchievement('win-week3_nomiss',					{name: "Nice Round with No Misses!", description: "Beat Week 3 on Hard or Insane\n without misses"});
		createAchievement('secret3',				{name: "What the f*ck.", description: "Press 7 in Java", hidden: true});
		createAchievement('win-week4',					{name: "Halloween Disaster", description: "Beat Week 4"});
		createAchievement('win-week4_nomiss',					{name: "Halloween Disaster but No Miss isn't!", description: "Beat Week 4 on Hard or Insane\n without misses"});
		createAchievement('secret4',				{name: "It's a 'secret' spooky month!", description: "Press 7 in Shiver", hidden: true});
		createAchievement('win-week5',					{name: "Merry Christmas!", description: "Beat Week 5"});
		createAchievement('win-week5_nomiss',					{name: "The New Year Resolution is no Misses!", description: "Beat Week 5 on Hard or Insane\n without misses"});
		createAchievement('secret5',				{name: "I... don't know", description: "Press 7 in Feliz", hidden: true});
		createAchievement('win-week6',					{name: "Hero or Villian?", description: "Beat Week 6"});
		createAchievement('win-week6_nomiss',					{name: "No Misses is a Hero!", description: "Beat Week 6 on Hard or Insane\n without misses"});
		createAchievement('secret6',				{name: "You just love to cheat, don't you?", description: "Press 7 in Detected", hidden: true});
		createAchievement('win-week7',					{name: "CURSE YOU, YOU PURPLE FREAK!!", description: "Beat Week 7"});
		createAchievement('win-week7_nomiss',					{name: "CURSE YOU ALL FOR BEATING ME WITHOUT MISSES!", description: "Beat Week 7 on Hard or Insane\n without misses"});
		createAchievement('secret7',				{name: "F*CK YOU BRO!", description: "Press 7 in Sabotage", hidden: true});
		createAchievement('win-week8',					{name: "Thank You! See you next time!", description: "Beat Week 8"});
		createAchievement('win-week8_nomiss',					{name: "That's impressive with no misses! See you next time!", description: "Beat Week 8 on Hard or Insane\n without misses"});
		createAchievement('secret8',				{name: "Goodbye...", description: "Press 7 in Withered", hidden: true});
		createAchievement('special_1',				{name: "Erect Mode, Complete!", description: "Beat Special 1"});
		createAchievement('special_1_nomiss',				{name: "Erect with No Miss Mode, Complete!", description: "Beat Special 1 on Hard or Insane\n without misses"});
		createAchievement('special_2',				{name: "It's good to see you man!", description: "Beat Special 2"});
		createAchievement('special_2_nomiss',				{name: "It's good to see you without misses man!", description: "Beat Special 2 on Hard or Insane\n without misses"});
		createAchievement('special_3',				{name: "Good Job, I guess.", description: "Beat Special 3"});
		createAchievement('special_3_nomiss',				{name: "No misses, Good Job.", description: "Beat Special 3 on Hard or Insane\n without misses"});
		createAchievement('special_4',				{name: "Great. Sadly it's not made out of paper.", description: "Beat Special 4"});
		createAchievement('special_4_nomiss',				{name: "No Misses, Perfect but it's not paper.", description: "Beat Special 4 on Hard or Insane\n without misses"});
		createAchievement('special_5',				{name: "ALL CORRUPTED OF US HAVE COLLAPSE", description: "Beat Special 5"});
		createAchievement('special_5_nomiss',				{name: "WE'VE BEEN DESTROYED WITH NO MISSES", description: "Beat Special 5 on Hard or Insane\n without misses"});
		createAchievement('special_6',				{name: "Thanks for a Visit!", description: "Beat Special 6"});
		createAchievement('special_6_nomiss',				{name: "No Misses again? Great!", description: "Beat Special 6 on Hard or Insane\n without misses"});
		createAchievement('special_7',				{name: "F*CKING HELL", description: "Beat Special 7"});
		createAchievement('special_7_nomiss',				{name: "GODDAMN YOU TO HELL!", description: "Beat Special 7 without misses"});
		createAchievement('special_8',				{name: "Thank you very much for playing my game!", description: "Beat Special 8"});
		createAchievement('special_8_nomiss',				{name: "You're a cool guy.", description: "Beat Special 8 without misses"});

		//dont delete this thing below
		_originalLength = _sortID + 1;
	}

	public static var achievements:Map<String, Achievement> = new Map<String, Achievement>();
	public static var variables:Map<String, Float> = [];
	public static var achievementsUnlocked:Array<String> = [];
	private static var _firstLoad:Bool = true;

	public static function get(name:String):Achievement
		return achievements.get(name);
	public static function exists(name:String):Bool
		return achievements.exists(name);

	public static function load():Void
	{
		if(!_firstLoad) return;

		if(_originalLength < 0) init();

		if(FlxG.save.data != null) {
			if(FlxG.save.data.achievementsUnlocked != null)
				achievementsUnlocked = FlxG.save.data.achievementsUnlocked;

			var savedMap:Map<String, Float> = cast FlxG.save.data.achievementsVariables;
			if(savedMap != null)
			{
				for (key => value in savedMap)
				{
					variables.set(key, value);
				}
			}
			_firstLoad = false;
		}
	}

	public static function save():Void
	{
		FlxG.save.data.achievementsUnlocked = achievementsUnlocked;
		FlxG.save.data.achievementsVariables = variables;
	}
	
	public static function getScore(name:String):Float
		return _scoreFunc(name, GET);

	public static function setScore(name:String, value:Float, saveIfNotUnlocked:Bool = true):Float
		return _scoreFunc(name, SET, value, saveIfNotUnlocked);

	public static function addScore(name:String, value:Float = 1, saveIfNotUnlocked:Bool = true):Float
		return _scoreFunc(name, ADD, value, saveIfNotUnlocked);

	static function _scoreFunc(name:String, mode:AchievementOp, addOrSet:Float = 1, saveIfNotUnlocked:Bool = true):Float
	{
		if(!variables.exists(name))
			variables.set(name, 0);

		if(achievements.exists(name))
		{
			var achievement:Achievement = achievements.get(name);
			if(achievement.maxScore < 1) throw new Exception('Achievement has score disabled or is incorrectly configured: $name');

			if(achievementsUnlocked.contains(name)) return achievement.maxScore;

			var val = addOrSet;
			switch(mode)
			{
				case GET: return variables.get(name); //get
				case ADD: val += variables.get(name); //add
				default:
			}

			if(val >= achievement.maxScore)
			{
				unlock(name);
				val = achievement.maxScore;
			}
			variables.set(name, val);

			Achievements.save();
			if(saveIfNotUnlocked || val >= achievement.maxScore) FlxG.save.flush();
			return val;
		}
		return -1;
	}

	static var _lastUnlock:Int = -999;
	public static function unlock(name:String, autoStartPopup:Bool = true):String {
		if(!achievements.exists(name))
		{
			FlxG.log.error('Achievement "$name" does not exists!');
			throw new Exception('Achievement "$name" does not exists!');
			return null;
		}

		if(Achievements.isUnlocked(name)) return null;

		trace('Completed achievement "$name"');
		achievementsUnlocked.push(name);

		// earrape prevention
		var time:Int = openfl.Lib.getTimer();
		if(Math.abs(time - _lastUnlock) >= 100) //If last unlocked happened in less than 100 ms (0.1s) ago, then don't play sound
		{
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.5);
			_lastUnlock = time;
		}

		Achievements.save();
		FlxG.save.flush();

		if(autoStartPopup) startPopup(name);
		return name;
	}

	inline public static function isUnlocked(name:String)
		return achievementsUnlocked.contains(name);

	@:allow(objects.AchievementPopup)
	private static var _popups:Array<AchievementPopup> = [];

	public static var showingPopups(get, never):Bool;
	public static function get_showingPopups()
		return _popups.length > 0;

	public static function startPopup(achieve:String, endFunc:Void->Void = null) {
		for (popup in _popups)
		{
			if(popup == null) continue;
			popup.intendedY += 150;
		}

		var newPop:AchievementPopup = new AchievementPopup(achieve, endFunc);
		_popups.push(newPop);
		//trace('Giving achievement ' + achieve);
	}

	// Map sorting cuz haxe is physically incapable of doing that by itself
	static var _sortID = 0;
	static var _originalLength = -1;
	public static function createAchievement(name:String, data:Achievement, ?mod:String = null)
	{
		data.ID = _sortID;
		data.mod = mod;
		achievements.set(name, data);
		_sortID++;
	}

	#if MODS_ALLOWED
	public static function reloadList()
	{
		// remove modded achievements
		if((_sortID + 1) > _originalLength)
			for (key => value in achievements)
				if(value.mod != null)
					achievements.remove(key);

		_sortID = _originalLength-1;

		var modLoaded:String = Mods.currentModDirectory;
		Mods.currentModDirectory = null;
		loadAchievementJson(Paths.mods('data/achievements.json'));
		for (i => mod in Mods.parseList().enabled)
		{
			Mods.currentModDirectory = mod;
			loadAchievementJson(Paths.mods('$mod/data/achievements.json'));
		}
		Mods.currentModDirectory = modLoaded;
	}

	inline static function loadAchievementJson(path:String, addMods:Bool = true)
	{
		var retVal:Array<Dynamic> = null;
		if(NativeFileSystem.exists(path)) {
			try {
				var rawJson:String = File.getContent(path).trim();
				if(rawJson != null && rawJson.length > 0) retVal = tjson.TJSON.parse(rawJson); //Json.parse('{"achievements": $rawJson}').achievements;
				
				if(addMods && retVal != null)
				{
					for (i in 0...retVal.length)
					{
						var achieve:Dynamic = retVal[i];
						if(achieve == null)
						{
							var errorTitle = 'Mod name: ' + Mods.currentModDirectory != null ? Mods.currentModDirectory : "None";
							var errorMsg = 'Achievement #${i+1} is invalid.';
							CoolUtil.showPopUp(errorMsg, errorTitle);
							trace('$errorTitle - $errorMsg');
							continue;
						}

						var key:String = achieve.save;
						if(key == null || key.trim().length < 1)
						{
							var errorTitle = 'Error on Achievement: ' + (achieve.name != null ? achieve.name : achieve.save);
							var errorMsg = 'Missing valid "save" value.';
							CoolUtil.showPopUp(errorMsg, errorTitle);
							trace('$errorTitle - $errorMsg');
							continue;
						}
						key = key.trim();
						if(achievements.exists(key)) continue;

						createAchievement(key, achieve, Mods.currentModDirectory);
					}
				}
			} catch(e:Dynamic) {
				var errorTitle = 'Mod name: ' + Mods.currentModDirectory != null ? Mods.currentModDirectory : "None";
				var errorMsg = 'Error loading achievements.json: $e';
				CoolUtil.showPopUp(errorMsg, errorTitle);
				trace('$errorTitle - $errorMsg');
			}
		}
		return retVal;
	}
	#end

	#if LUA_ALLOWED
	public static function addLuaCallbacks(lua:State)
	{
		Lua_helper.add_callback(lua, "getAchievementScore", function(name:String):Float
		{
			if(!achievements.exists(name))
			{
				FunkinLua.luaTrace('getAchievementScore: Couldnt find achievement: $name', false, false, FlxColor.RED);
				return -1;
			}
			return getScore(name);
		});
		Lua_helper.add_callback(lua, "setAchievementScore", function(name:String, ?value:Float = 0, ?saveIfNotUnlocked:Bool = true):Float
		{
			if(!achievements.exists(name))
			{
				FunkinLua.luaTrace('setAchievementScore: Couldnt find achievement: $name', false, false, FlxColor.RED);
				return -1;
			}
			return setScore(name, value, saveIfNotUnlocked);
		});
		Lua_helper.add_callback(lua, "addAchievementScore", function(name:String, ?value:Float = 1, ?saveIfNotUnlocked:Bool = true):Float
		{
			if(!achievements.exists(name))
			{
				FunkinLua.luaTrace('addAchievementScore: Couldnt find achievement: $name', false, false, FlxColor.RED);
				return -1;
			}
			return addScore(name, value, saveIfNotUnlocked);
		});
		Lua_helper.add_callback(lua, "unlockAchievement", function(name:String):Dynamic
		{
			if(!achievements.exists(name))
			{
				FunkinLua.luaTrace('unlockAchievement: Couldnt find achievement: $name', false, false, FlxColor.RED);
				return null;
			}
			return unlock(name);
		});
		Lua_helper.add_callback(lua, "isAchievementUnlocked", function(name:String):Dynamic
		{
			if(!achievements.exists(name))
			{
				FunkinLua.luaTrace('isAchievementUnlocked: Couldnt find achievement: $name', false, false, FlxColor.RED);
				return null;
			}
			return isUnlocked(name);
		});
		Lua_helper.add_callback(lua, "achievementExists", function(name:String) return achievements.exists(name));
	}
	#end
}
#end