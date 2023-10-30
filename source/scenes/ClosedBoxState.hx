package scenes;

import flixel.FlxState;

import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEvent;
import flixel.FlxG;
import singletons.GameManager;
class ClosedBoxState extends FlxState
{
	var background:FlxSprite = new FlxSprite();
	var closedBox:FlxSprite = new FlxSprite();
	var overlay:FlxSprite = new FlxSprite();

	override public function create()
	{
		super.create();

		// setup background
		background.loadGraphic("assets/images/Background.PNG");
		background.screenCenter();
		add(background);

		// setup box
		closedBox.loadGraphic("assets/images/box-unopened.PNG");
		closedBox.screenCenter();
		add(closedBox);

		// set up overlay
		overlay.loadGraphic("assets/images/item-holder.PNG");
		overlay.screenCenter();
		add(overlay);

		// mouse down event
		FlxMouseEvent.add(closedBox, onMouseDown);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	// callbacks
	function onMouseDown(sprite:FlxSprite)
	{
		// transition to open box state
		trace("switch state");
		FlxG.switchState(new scenes.OpenBoxState());
	}
}
