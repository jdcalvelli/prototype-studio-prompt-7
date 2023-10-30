package scenes;

import flixel.FlxSprite;
import flixel.FlxState;
import singletons.GameManager;
import flixel.FlxG;
import flixel.input.mouse.FlxMouseEvent;

import flixel.util.FlxTimer;
import flixel.text.FlxText;
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

			if (object == objects[0] && !GameManager.Instance.firstObjectUsed)
			{
				object.x = object.x - 80;
				add(object);
			}
			else if (object == objects[1] && !GameManager.Instance.secondObjectUsed)
			{
				object.x = object.x;
				add(object);
			}
			else if (object == objects[2] && !GameManager.Instance.thirdObjectUsed)
			{
				object.x = object.x + 80;
				add(object);
			}

			FlxMouseEvent.add(object, onMouseDown);
		}

		if (GameManager.Instance.firstObjectUsed &&
		GameManager.Instance.secondObjectUsed &&
		GameManager.Instance.thirdObjectUsed)
		{
			for (object in objects)
			{
				FlxMouseEvent.remove(object);
			}
			new FlxTimer().start(4, (_)->
			{
				remove(openBox);
				var credits = new FlxText(
					FlxG.width/2,
					FlxG.height/2,
					"entropy\na prototype by jd calvelli",
					16);
				credits.color = 0xFF000000;
				add(credits);
			});
		}

	}

	function onMouseDown(sprite:FlxSprite)
	{
		// send to table scene with object
		FlxG.signals.preStateSwitch.addOnce(() ->
		{
			if (sprite == objects[0])
			{
				GameManager.Instance.selectedObject = "first";
				GameManager.Instance.firstObjectUsed = true;
			}
			else if (sprite == objects[1])
			{
				GameManager.Instance.selectedObject = "second";
				GameManager.Instance.secondObjectUsed = true;
			}
			else if (sprite == objects[2])
			{
				GameManager.Instance.selectedObject = "third";
				GameManager.Instance.thirdObjectUsed = true;
			}

			remove(sprite);
		});
		FlxG.switchState(new scenes.TableState());
	}
}
