package states.menus;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.input.keyboard.FlxKey;
import handlers.ClientPrefs;
import handlers.Files;
import handlers.MusicBeatState;

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var gtText:FlxText;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'donate'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

	var magenta:FlxSprite;
	var camFollow:FlxObject;

	var funnyToggle:Bool = false;
	var funnyNumber:Int = 0;

	var easterEggKeys:Array<String> = [
		'TRISTAN', 'DDLC'
	];
	var curTristanFunny:Int = 0;
	var curDDLCFunny:Int = 0;

	override function create()
	{
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Files.music('freakyMenu'));
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Files.image('menuBG'));
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic(Files.image('menuDesat'));
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.18;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var tex = FlxAtlasFrames.fromSparrow('assets/images/FNF_main_menu_assets.png', 'assets/images/FNF_main_menu_assets.xml');

		for (i in 0...optionShit.length)
		{
			var menuItem:FlxSprite = new FlxSprite(0, 60 + (i * 160));
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}

		FlxG.camera.follow(camFollow, null, 0.06);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 36.2, 0, "v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		gtText = new FlxText(5, FlxG.height - 18, 0, "", 12);
		gtText.scrollFactor.set();
		gtText.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(gtText);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (ClientPrefs.ghostTapping == true) {
			gtText.text = "Ghost Tapping Is Currently on";
		}
		else
		{
			gtText.text = "Ghost Tapping Is Currently off";
		}

		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play((Files.sound('scrollMenu')));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play((Files.sound('scrollMenu')));
				changeItem(1);
			}

			if (FlxG.keys.justPressed.G)
				{
					if (ClientPrefs.ghostTapping == false) {
						ClientPrefs.ghostTapping = true;
						trace("on");
					}
					else
					{
						ClientPrefs.ghostTapping = false;
						trace("off");
					}
				}

			if (FlxG.keys.justPressed.T) {
				FlxG.sound.play((Files.sound('confirmMenu')));
				if (ClientPrefs.tankmanFloat == false) {
					ClientPrefs.tankmanFloat = true;
					trace("Secret Found!");
				}
				else
				{
					ClientPrefs.tankmanFloat = false;
				}
			}
			if (curTristanFunny == 0 || curTristanFunny == 4) {
				if (FlxG.keys.justPressed.T) {
					curTristanFunny++;
				}
			}
			if (curTristanFunny == 1) {
				if (FlxG.keys.justPressed.R) {
					curTristanFunny++;
				}
			}
			if (curTristanFunny == 2) {
				if (FlxG.keys.justPressed.I) {
					curTristanFunny++;
				}
			}
			if (curTristanFunny == 3) {
				if (FlxG.keys.justPressed.S) {
					curTristanFunny++;
				}
			}
			if (curTristanFunny == 5) {
				if (FlxG.keys.justPressed.A) {
					curTristanFunny++;
				}
			}
			if (curTristanFunny == 6) {
				if (FlxG.keys.justPressed.N) {
					curTristanFunny = 0;
					FlxG.sound.play(Files.sound('confirmMenu'));
					if (ClientPrefs.tristanPlayer == false) {
						ClientPrefs.tristanPlayer = true;
						trace("tristan mode enabled");
					}
					else
					{
						ClientPrefs.tristanPlayer = false;
						trace("tristan mode disabled");
					}
				}
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://ninja-muffin24.itch.io/funkin", "&"]);
					#else
					FlxG.openURL('https://ninja-muffin24.itch.io/funkin');
					#end
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Files.sound('confirmMenu'));

					FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story mode':
										FlxG.switchState(new StoryMenuState());
										trace("Story Menu Selected");
									case 'freeplay':
										FlxG.switchState(new FreeplayState());

										trace("Freeplay Menu Selected");
								}
							});
						}
					});
				}
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}
