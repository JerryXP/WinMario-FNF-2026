package mikolka.vslice.ui.disclaimer;

import flixel.FlxState;

class OutdatedState extends WarningState
{

	public function new(newVersion:String,nextState:FlxState) {
		final bro:String = #if mobile 'kiddo' #else 'bro' #end;
		final escape:String = (controls.mobileC) ? 'B' : 'ESCAPE';

		var guh = "Sup "+bro+", looks like you're running an   \n
		outdated version of P-Slice Engine (" + MainMenuState.pSliceVersion + "),\n
		please update to " + newVersion + "!\n
		Press "+escape+" to proceed anyway.\n
		\n
		Thank you for using the Engine!";
		super(guh,() ->{
			CoolUtil.browserLoad("https://github.com/Psych-Slice/P-Slice/releases");
			if(onExit != null) onExit();
		},onExit,nextState);
	}
}
class FlashingState extends WarningState{
	public function new(nextState:FlxState) {

		final enter:String = controls.mobileC ? 'A' : 'ENTER';
		final escape:String = controls.mobileC ? 'B' : 'ESCAPE';
		var text = 	"Hey!\n
			This Mod Contains Flashing Lights.\n
			& Thank you for downloading this mod.\n
			All assets have been used from different mods is not mine.\nAll credits to people who made it.\n
			THIS MOD IS NOT CONNECTED TO PIBBY, CORRUPTION, NOR PAPER.\n
			If you're here for that, your in the wrong place.\n
			Anyways... Do you wish to disable flashing lights?\n
			Press " + enter + " to disable them now or go to Options Menu.\n
			Press " + escape + " to ignore this message.\n
			You've been warned!";
		super(text,() ->{
			#if LEGACY_PSYCH
			ClientPrefs.flashing = false;
			#else
			ClientPrefs.data.flashing = false;
			#end
			ClientPrefs.saveSettings();
		},() ->{},nextState);
	}
}
#if ios
class AppleWarning extends WarningState{
	public function new(nextState:FlxState) {

		final enter:String = controls.mobileC ? 'A' : 'ENTER';
		final escape:String = controls.mobileC ? 'B' : 'ESCAPE';
		var text = #if ios	"Uh Oh!\n
			We detected you are using\n
			an iPhone; This Mod Contains\n
			Stuff that might offend Apple Users.\n
			Do you still want to play it?\n
			Press " + enter + " to Continue\n
			Press " + escape + " to Exit this Mod" #end;
		super(text,() ->{
		},() ->{},nextState);
	}
}
#end