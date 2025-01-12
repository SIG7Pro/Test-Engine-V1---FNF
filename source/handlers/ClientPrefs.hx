package handlers;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

class ClientPrefs {
    public static var ghostTapping:Bool = true;
    public static var showComboText:Bool = true;

	//easter eggs
	public static var tristanPlayer:Bool = false;

    //funny
    public static var tankmanFloat:Bool = false;

	//for modifiers later on lol
	public static var modifiers:Map<String, Dynamic> = [
		'speed' => 1.0,
		'max misses' => 0,
		'fc mode' => false,
		'sfc mode' => false,
		'gfc mode' => false,
	];
    
    //Every key has two binds, add your key bind down here and then add your control on options and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		'note_left'		=> [W, LEFT],
		'note_down'		=> [A, DOWN],
		'note_up'		=> [S, UP],
		'note_right'	=> [D, RIGHT],
		
		'ui_left'		=> [W, LEFT],
		'ui_down'		=> [A, DOWN],
		'ui_up'			=> [S, UP],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R, NONE],
		
		'volume_mute'	=> [ZERO, NONE],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN, NONE],
		'debug_2'		=> [EIGHT, NONE]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static function loadDefaultKeys() {
		defaultKeys = keyBinds.copy();
		//trace(defaultKeys);
	}

    public static function saveSettings() {
        FlxG.save.data.ghostTapping = ghostTapping;
        FlxG.save.data.showComboText = showComboText;
		FlxG.save.data.tristanPlayer = tristanPlayer;
        FlxG.save.data.tankmanFloat = tankmanFloat;

        FlxG.save.flush();

        var save:FlxSave = new FlxSave();
		save.bind('controls_v2', 'ninjamuffin99'); //Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
    }

    public static function loadPrefs() {
        if(FlxG.save.data.ghostTapping != null) {
			ghostTapping = FlxG.save.data.ghostTapping;
		}
        if (FlxG.save.data.showComboText != null) {
            showComboText = FlxG.save.data.showComboText;
        }
		if (FlxG.save.data.tristanPlayer != null) {
			tristanPlayer = FlxG.save.data.tristanPlayable;
		}
        if (FlxG.save.data.tankmanFloat != null) {
            tankmanFloat = FlxG.save.data.tankmanFloat;
        }
    }
}