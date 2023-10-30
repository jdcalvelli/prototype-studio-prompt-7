package scenes;

import flixel.FlxSprite;
import flixel.FlxState;
import singletons.GameManager;
import flixel.FlxG;
import flixel.input.mouse.FlxMouseEvent;
import singletons.GameManager;
class OpenBoxState extends FlxState
{
	var background:FlxSprite = new FlxSprite();
	var openBox:FlxSprite = new FlxSprite();
	var overlay:FlxSprite = new FlxSprite();
	var objects = [
		"item1" => new FlxSprite().loadGraphic("assets/images/thing-one.PNG"),
		"item2" => new FlxSprite().loadGraphic("assets/images/thing-two.PNG"),
		"item3" => new FlxSprite().loadGraphic("assets/images/thing-three.PNG"),
	];

	override public function create()
	{
		super.create();

		// setup background
		background.loadGraphic("assets/images/Background.PNG");
		background.screenCenter();
		add(background);

		// setup box
		openBox.loadGraphic("assets/images/box-opened.PNG");
		openBox.screenCenter();
		add(openBox);

		// set up overlay
		overlay.loadGraphic("assets/images/item-holder.PNG");
		overlay.screenCenter();
		add(overlay);

		// set up items
		for (object in objects) {
			add(object);
			FlxMouseEvent.add(object, onMouseDown);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function onMouseDown(sprite:FlxSprite)
	{
		// send to table scene with object
		GameManager.Instance.currentObject = sprite;
		FlxG.switchState(new scenes.TableState());
	}
}
