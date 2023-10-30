package scenes;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.input.mouse.FlxMouseEvent;
import flixel.FlxG;
class ClosedBoxState extends FlxState
{
	var background:FlxSprite = new FlxSprite();
	var closedBox:FlxSprite = new FlxSprite();

	override public function create()
	{
		super.create();

		FlxG.mouse.useSystemCursor = true;

		// setup background
		background.loadGraphic("assets/images/Background.PNG");
		background.screenCenter();
		add(background);

		// setup box
		closedBox.loadGraphic("assets/images/box-unopened.PNG");
		closedBox.screenCenter();
		add(closedBox);

		// mouse down event
		FlxMouseEvent.add(closedBox, onMouseDown);
	}

	// callbacks
	function onMouseDown(sprite:FlxSprite)
	{
		// transition to open box state
		FlxG.switchState(new scenes.OpenBoxState());
	}
}
