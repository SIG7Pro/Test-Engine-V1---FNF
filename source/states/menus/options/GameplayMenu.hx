package states.menus.options;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import handlers.Files;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import handlers.MusicBeatState;
import flixel.FlxG;
import ui.Alphabet;
import handlers.ClientPrefs;

class GameplayMenu extends MusicBeatState{
    var maintextgroup:FlxTypedGroup<Alphabet>;
    var maintext:Alphabet;
    var curSelected:Int = 0;
    var curSubSelected:Int = 0;
    var Items:Array<String> = ['Ghost Tapping', 'Down Scroll', 'FPS', 'Show Combo Txt'];
    var trueorfalsesmthidk:FlxText;
    var isTrue:Bool = false;

    override function create() {
        var bg:FlxSprite = new FlxSprite().loadGraphic(Files.image('menuDesat'));
        bg.color = 0x302D2D;
		add(bg);

        trueorfalsesmthidk = new FlxText(5, FlxG.height - 33.2, 0, "unknown option or null bool", 12);
		trueorfalsesmthidk.scrollFactor.set();
		trueorfalsesmthidk.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(trueorfalsesmthidk);
        
        maintextgroup = new FlxTypedGroup<Alphabet>();
		add(maintextgroup);

    for (i in 0...Items.length)
        {
        maintext = new Alphabet(10, (70 * i) + 41.2, Items[i], true);
        maintext.scale.set(0.8, 0.8);
        maintext.isMenuItem = true;
        maintextgroup.add(maintext);
        }

        changeSelection();
}

    override public function update(elapsed:Float){
        if (FlxG.keys.justPressed.ESCAPE)
        FlxG.switchState(new Options());

        if (FlxG.keys.justPressed.DOWN)
            changeSelection(1);

        if (FlxG.keys.justPressed.UP)
            changeSelection(-1);

        var daSelected:String = Items[curSelected];
        if (daSelected != 'FPS') {
            if (FlxG.keys.justPressed.LEFT) //down
                changeSubSelection(-1);
    
            if (FlxG.keys.justPressed.RIGHT) //up
                changeSubSelection(1);
        }
        else
        {
            if (FlxG.keys.justPressed.LEFT) //down
                changeSubSelection(-10);
    
            if (FlxG.keys.justPressed.RIGHT) //up
                changeSubSelection(10);
        }

        if (curSubSelected == 0 && daSelected == 'FPS')
            curSubSelected = ClientPrefs.framerate;

        if (daSelected == 'Ghost Tapping')
            trueorfalsesmthidk.text = 'Ghost Tapping = $isTrue';
        else if (daSelected == 'Down Scroll')
            trueorfalsesmthidk.text = 'Down Scroll = $isTrue';
        else if (daSelected == 'FPS')
            trueorfalsesmthidk.text = 'FPS = $curSubSelected';
        else
            trueorfalsesmthidk.text == 'unknown option or null bool';

        if (FlxG.keys.justPressed.ENTER){
			switch (daSelected)
			{
				case 'Ghost Tapping':
                    if (!ClientPrefs.ghostTapping)
                        ClientPrefs.ghostTapping = true;
                    else
                        ClientPrefs.ghostTapping = false;
                    isTrue = ClientPrefs.ghostTapping;
                case 'Show Combo Txt':
                    if (!ClientPrefs.showComboText)
                        ClientPrefs.showComboText = true;
                    else
                        ClientPrefs.showComboText = false;
                    isTrue = ClientPrefs.showComboText;
                case 'Down Scroll':
                    if (!ClientPrefs.downscroll)
                        ClientPrefs.downscroll = true;
                    else
                        ClientPrefs.downscroll = false;
                    isTrue = ClientPrefs.downscroll;
			}
        }
    }

    /*
    if (FlxG.keys.justPressed.G)
        {
            if (!ClientPrefs.ghostTapping) {
                ClientPrefs.ghostTapping = true;
                trace("on");
            }
            else
            {
                ClientPrefs.ghostTapping = false;
                trace("off");
            }*/

    function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

        FlxG.sound.play(Files.sound('scrollMenu'), 0.4);

		if (curSelected < 0)
			curSelected = Items.length - 1;
		if (curSelected >= Items.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in maintextgroup.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}

    function changeSubSelection(change:Int) {
        curSubSelected += change;

        var daSelected:String = Items[curSelected];
        switch (daSelected) {
            case 'FPS':
                if (curSubSelected < 60)
                    curSubSelected = 60;
                if (curSubSelected >= 200)
                    curSubSelected = 200;
                ClientPrefs.framerate = curSubSelected;
                onChangeFPS();
            default:
                curSubSelected = 0;
        }
    }

    function onChangeFPS() {
        if(ClientPrefs.framerate > FlxG.drawFramerate)
        {
            FlxG.updateFramerate = ClientPrefs.framerate;
            FlxG.drawFramerate = ClientPrefs.framerate;
        }
        else
        {
            FlxG.drawFramerate = ClientPrefs.framerate;
            FlxG.updateFramerate = ClientPrefs.framerate;
        }
    }
}