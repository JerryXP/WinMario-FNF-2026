package states;

import flixel.FlxSubState;

import flixel.effects.FlxFlicker;
import lime.app.Application;

//AppleWarning is where that it warns people who uses a Mac or IPhone.
//Because this mod is related to Windows vs. MacOS on the internet
//Which it can trigger Mac or IPhone Users.

class AppleWarning extends MusicBeatState
{
	#if mac
	public static var leftState:Bool = false;

	var isYes:Bool = true;
	var isNo:Bool = true;
	var texts:FlxTypedSpriteGroup<FlxText>;
	var bg:FlxSprite;

	override function create()
	{
		super.create();

		bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		texts = new FlxTypedSpriteGroup<FlxText>();
		texts.alpha = 0.0;
		add(texts);

		var warnText:FlxText = new FlxText(0, 0, FlxG.width,
			#if mac
			"Uh Oh!\n
			We detected you are using\n
			a Mac ; This Mod Contains Stuff that\n
			might offend Apple Users.\n
			Do you still want to play it?\n
			Pick \"No\" to close this game\n
			Pick \"Yes\" to continue (YOU'VE BEEN WARNED!)");
			#end
		warnText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		texts.add(warnText);

		final keys = ["Yes", "No"];
		for (i in 0...keys.length) {
			final button = new FlxText(0, 0, FlxG.width, keys[i]);
			button.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER);
			button.y = (warnText.y + warnText.height) + 24;
			button.x += (128 * i) - 80;
			texts.add(button);
		}

		FlxTween.tween(texts, {alpha: 1.0}, 0.5, {
			onComplete: (_) -> updateItems()
		});
	}

	override function update(elapsed:Float)
	{
		if(leftState) {
			super.update(elapsed);
			return;
		}
		var back:Bool = controls.BACK;
		if (controls.UI_LEFT_P || controls.UI_RIGHT_P) {
			FlxG.sound.play(Paths.sound("scrollMenu"), 0.7);
			isYes = isNo;
			updateItems();
		}
		if (controls.ACCEPT || back) {
			leftState = true;
			FlxTransitionableState.skipNextTransIn = true; 
			FlxTransitionableState.skipNextTransOut = true;
			if(!back) {
				FlxG.sound.play(Paths.sound('confirmMenu'));
				final button = texts.members[isYes ? 1 : 2];
				FlxFlicker.flicker(button, 1, 0.1, false, true, function(flk:FlxFlicker) {
					new FlxTimer().start(0.5, function (tmr:FlxTimer) {
						FlxTween.tween(texts, {alpha: 0}, 0.2, {
							onComplete: (_) -> MusicBeatState.switchState(new IntroVideoState())
						});
					});
				});
			} else {
				FlxG.sound.play(Paths.sound('cancelMenu'));
				final button = texts.members[isNo ? 1 : 2];
				FlxFlicker.flicker(button, 1, 0.1, false, true, function(flk:FlxFlicker) {
				new FlxTimer().start(0.5, function (tmr:FlxTimer) {
				FlxTween.tween(texts, {alpha: 0}, 1, {
					onComplete: (_) -> MusicBeatState.switchState(new AppleCloseGame())
				});
					});
				});
			}
		}
		super.update(elapsed);
	}

	function updateItems() {
		// it's clunky but it works.
		texts.members[1].alpha = isYes ? 1.0 : 0.6;
		texts.members[2].alpha = isNo ? 0.6 : 1.0;
	}
	#end
}
