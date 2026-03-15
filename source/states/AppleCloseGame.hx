package states;

#if (mac || ios)
import flixel.FlxState;

// https://gamebanana.com/posts/12920491
class AppleCloseGame extends FlxState {
    override function create() {
        openfl.Lib.application.window.close();
        super.create();
    }
}
#end