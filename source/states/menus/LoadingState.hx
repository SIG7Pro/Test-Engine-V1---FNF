package states.menus;

/*
plz don't mess with this yet.
iss wip.

as of right now, all it does is just set stuff in a data var.
soon ill make it so the states utilize this class.
*/

import flixel.FlxG;
import handlers.MusicBeatState;
import openfl.Assets;
#if desktop
import polymod.Polymod;
#end

using StringTools;

typedef ModDataYee = {
    var titleBar:String;
    var weekList:Array<ModWeekYee>;
}

typedef ModWeekYee = {
    var name:String;
    var spriteImage:String;
    var songs:Array<String>;
    var paths:Array<String>;
    var icons:Array<String>;
    var diffs:Array<String>;
}

class LoadingState extends MusicBeatState {
    public static var modData:ModDataYee = {
        titleBar: "Friday Night Funkin' - Test Engine",
        weekList: []
    }; //It gets set in create so no need to fill this.

    override public function create() {
        modData = {
            titleBar: "Friday Night Funkin' - Test Engine",
            weekList: [
                {
                    name: "Tutorial",
                    spriteImage: "tutorial",
                    songs: ["Tutorial"],
                    paths: ["tutorial"],
                    icons: ["gf"],
                    diffs: ["Easy", "Normal", "Hard"]
                },
                {
                    name: "DADDY DEAREST",
                    spriteImage: "week1",
                    songs: ["Bopeebo", "Fresh", "Dadbattle"],
                    paths: ["bopeebo", "fresh", "dadbattle"],
                    icons: ["dad", "dad", "dad"],
                    diffs: ["Easy", "Normal", "Hard"]
                },
                {
                    name: "Spooky Month",
                    spriteImage: "week2",
                    songs: ["Spookeez", "South", "Monster"],
                    paths: ["spookeez", "south", "monster"],
                    icons: ["spooky", "spooky", "monster"],
                    diffs: ["Easy", "Normal", "Hard"]
                },
                {
                    name: "PICO",
                    spriteImage: "week3",
                    songs: ["Pico", "Philly", "Blammed"],
                    paths: ["pico", "philly", "blammed"],
                    icons: ["pico", "pico", "pico"],
                    diffs: ["Easy", "Normal", "Hard"]
                },
                {
                    name: "MOMMY MUST MURDER",
                    spriteImage: "week4",
                    songs: ["Satin-Panties", "High", "MILF"],
                    paths: ["satin-panties", "high", "milf"],
                    icons: ["mom", "mom", "mom"],
                    diffs: ["Easy", "Normal", "Hard"]
                },
                {
                    name: "RED SNOW",
                    spriteImage: "week5",
                    songs: ["Cocoa", "Eggnog", "Winter-Horrorland"],
                    paths: ["cocoa", "eggnog", "winter-horrorland"],
                    icons: ["parents-christmas", "parents-christmas", "monster"],
                    diffs: ["Easy", "Normal", "Hard"]
                },
                {
                    name: "HATING SIMULATOR FT. MOAWLING",
                    spriteImage: "week6",
                    songs: ["Senpai", "Roses", "Thorns"],
                    paths: ["senpai", "roses", "thorns"],
                    icons: ["senpai", "senpai", "spirit"],
                    diffs: ["Easy", "Normal", "Hard"]
                },
                {
                    name: "TANKMAN",
                    spriteImage: "week7",
                    songs: ["Ugh", "Guns", "Stress"],
                    paths: ["ugh", "guns", "stress"],
                    icons: ["tankman", "tankman", "tankman"],
                    diffs: ["Easy", "Normal", "Hard"]
                }
            ]
        };

        #if desktop
        Polymod.init({modRoot: "mods/", dirs: ["+BASE+"]});
        if (Assets.exists("assets/modData.xml")) {
            var xml:Xml = Xml.parse(Assets.getText("assets/modData.xml")).firstElement();

            if (xml.get("titleBarName") != null) modData.titleBar = xml.get("titleBarName");
            var xmlWeeks = xml.elementsNamed("week");
            if (xmlWeeks != null && xmlWeeks.hasNext()) {
                modData.weekList = [];
                for (week in xmlWeeks) {
                    var modWeek:ModWeekYee = {
                        name: "UNKNOWN WEEK NAME",
                        spriteImage: "week1",
                        songs: ["Test"],
                        paths: ["test"],
                        icons: ["face"],
                        diffs: ["Easy", "Normal", "Hard"]
                    };
                    if (week.get("name") != null) modWeek.name = week.get("name");
                    if (week.get("image") != null) modWeek.spriteImage = week.get("image");
                    if (week.get("songs") != null) modWeek.songs = [for (song in week.get("songs").split(",")) song.trim()];
                    if (week.get("songPaths") != null) modWeek.paths = [for (path in week.get("songPaths").split(",")) path.trim()];
                    if (week.get("icons") != null) modWeek.icons = [for (icon in week.get("icons").split(",")) icon.trim()];
                    if (week.get("diffs") != null) modWeek.diffs = [for (diff in week.get("diffs").split(",")) diff.trim()];

                    modData.weekList.push(modWeek);
                }
            }
        }
        #end
        FlxG.switchState(new states.menus.TitleState());
    }
}