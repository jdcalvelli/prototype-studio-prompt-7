package scenes;

import flixel.FlxSprite;
import flixel.FlxState;
import singletons.GameManager;
import flixel.FlxG;
import flixel.input.mouse.FlxMouseEvent;

class OpenBoxState extends FlxState
{
	var background:FlxSprite = new FlxSprite();
	var openBox:FlxSprite = new FlxSprite();

	var objects:Array<FlxSprite> = [
		new FlxSprite().loadGraphic("assets/images/thing-one.PNG"),
		new FlxSprite().loadGraphic("assets/images/thing-two.PNG"),
		new FlxSprite().loadGraphic("assets/images/thing-three.PNG"),
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

		// set up items
		for (object in objects) {
			object.setPosition(FlxG.width/2, FlxG.height/2 - 115);

			if (object == objects[0])
			{
				object.x = object.x - 80;
			}
			if (object == objects[1])
			{
				object.x = object.x;
			}
			if (object == objects[2])
			{
				object.x = object.x + 80;
			}

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
		FlxG.signals.preStateSwitch.addOnce(() ->
		{
			GameManager.Instance.currentObject = sprite;
			remove(sprite);
		});
		FlxG.switchState(new scenes.TableState());
	}
}
