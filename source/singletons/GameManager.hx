package singletons;

import flixel.FlxSprite;
class GameManager
{
    // static instance
    public static final Instance:GameManager = new GameManager();

    // properties on instance
    public var currentObject:FlxSprite;

    // private constructor stops class instantiation elsewhere
    private function new() {}
}
