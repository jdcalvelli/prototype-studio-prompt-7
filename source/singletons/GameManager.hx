package singletons;

import flixel.FlxSprite;
class GameManager
{
    // static instance
    public static final Instance:GameManager = new GameManager();

    public var selectedObject:String;

    public var firstObjectUsed:Bool = false;
    public var secondObjectUsed:Bool = false;
    public var thirdObjectUsed:Bool = false;

    // private constructor stops class instantiation elsewhere
    private function new() {}
}
