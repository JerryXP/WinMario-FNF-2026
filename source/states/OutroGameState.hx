package states;

import flixel.util.typeLimit.OneOfTwo;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import openfl.Assets;
import haxe.xml.Access;
#if hxvlc
import hxvlc.flixel.FlxVideoSprite;
#end

class OutroGameState extends MusicBeatState
{
	var allowMouse:Bool = false;
	var currentFPS:Bool = false;

	#if VIDEOS_ALLOWED
	public var videoCutscene:FlxVideoSprite;
	override public function create():Void
	{
        	startVideo('outro-game'); // change this boi
			FlxG.sound.music.fadeOut();

		super.create();
	}

   	public function startVideo(name:String)
	{
		videoCutscene = new FlxVideoSprite(0, 0);
		add(videoCutscene);
		videoCutscene.load(Paths.video(name));
		videoCutscene.play();
		videoCutscene.alpha = 1;
		videoCutscene.visible = true;
		videoCutscene.bitmap.onEndReached.add(function()
		{
        #if desktop
			openfl.Lib.application.window.close();
		#end
		});
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
	#end
}