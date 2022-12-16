package handlers;

import lime.tools.AssetType;
import states.menus.TitleState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;

class Files{
    static var file:String;
    
    public static function image(image:String){
        return file = 'assets/images/$image.png';
    }

    public static function sound(sound:String){
        return file = 'assets/sounds/$sound${TitleState.soundExt}';
    }

    public static function music(music:String){
        return file = 'assets/music/$music${TitleState.soundExt}';
    }

    public static function song(song:String){
        return file = 'assets/songs/$song${TitleState.soundExt}';
    }

    public static function video(video:String, extention:String = 'mp4') {
        return file = 'assets/videos/$video.$extention';
    }

    #if !html5
    public static function font(font:String, extention:String = 'ttf') {
        return file = 'assets/fonts/$font.$extention';
    }
    #else
    public static function font(font:String) {
        return file = 'assets/fonts/$font.woff';
    }
    #end

    public static function songJson(songName:String, difficulty:String = 'Normal') {
        //kinda temp
        if (difficulty.toLowerCase() == 'normal') 
            difficulty = "";

        var song:String = songName.toLowerCase();
        var diff:String;
        if (difficulty != "")
            diff = '-' + difficulty.toLowerCase();
        else
            diff = "";
        return file = 'assets/data/$song/$song$diff';
    }

    public static function sparrowAtlas(image:String) {
        return FlxAtlasFrames.fromSparrow('assets/images/$image.png', 'assets/images/$image.xml');
    }

    //public static function packerAtlas

    /*
    public static function fileExists(name:String, type:AssetType) {
        if(OpenFlAssets.exists(getPath(name, type)))
			return true;
        else 
		    return false;
    }
    dumb stuff idk how to do properly*/

    public static function txt(path:String, fileName:String) {
        return file = 'assets/$path/$fileName.txt';
    }

    public static function randomSound(min:Int, max:Int, fileName:String) {
        return file = 'assets/sounds/$fileName' + FlxG.random.int(min, max) + '.ogg';
    }

    public static function songInst(songName:String) {
        var songFolder = songName.toLowerCase();
        return file = 'assets/songs/$songFolder/Inst.ogg';
    }

    public static function songVoices(songName:String) {
        var songFolder = songName.toLowerCase();
        return file = 'assets/songs/$songFolder/Voices.ogg';
    }

    /*
    public static function grabBuildNum() {
        #if sys
        var path:String = '../../../../buildnum.txt';
        return file = Std.parseInt(File.getContent(sys.FileSystem.absolutePath(path))) + 1;
        #else
        return 'sys is not enabled!';
        #end
    }
    */
}