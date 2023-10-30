package scenes;
import flixel.FlxState;
import flixel.FlxSprite;
import singletons.GameManager;
import flixel.math.FlxRandom;
import flixel.input.mouse.FlxMouseEvent;
import flixel.util.FlxTimer;
import flixel.FlxG;
class DumpsterState extends FlxState {

    var background:FlxSprite = new FlxSprite();
    var dumpster:FlxSprite = new FlxSprite();

    var objects:Array<FlxSprite> = [
        new FlxSprite().loadGraphic("assets/images/thing-one.PNG"),
        new FlxSprite().loadGraphic("assets/images/thing-two.PNG"),
        new FlxSprite().loadGraphic("assets/images/thing-three.PNG"),
    ];

    override public function create()
    {
        // setup background
        background.loadGraphic("assets/images/Background.PNG");
        background.screenCenter();
        add(background);

        // add dumpster
        dumpster.loadGraphic("assets/images/dumpster.PNG");
        dumpster.screenCenter();
        add(dumpster);

        for (object in objects) {
            object.setPosition(FlxG.width/2, FlxG.height/2);

            if (object == objects[0] && GameManager.Instance.firstObjectUsed && GameManager.Instance.selectedObject != "first")
            {
                object.setPosition(object.x, object.y - 100);
                add(object);
            }
            if (object == objects[1] && GameManager.Instance.secondObjectUsed && GameManager.Instance.selectedObject != "second")
            {
                object.setPosition(object.x + 50, object.y - 100);
                add(object);
            }
            if (object == objects[2] && GameManager.Instance.thirdObjectUsed && GameManager.Instance.selectedObject != "third")
            {
                object.setPosition(object.x + 100, object.y - 100);
                add(object);
            }

            FlxMouseEvent.add(object, onMouseDown);
        }

        FlxMouseEvent.add(dumpster, onMouseDown);
    }

    // callbacks

    function onMouseDown(sprite:FlxSprite)
    {
        switch GameManager.Instance.selectedObject
        {
            case "first":
                objects[0].setPosition(objects[0].x, objects[0].y - 100);
                add(objects[0]);
            case "second":
                objects[1].setPosition(objects[1].x + 50, objects[1].y - 100);
                add(objects[1]);
            case "third":
                objects[2].setPosition(objects[2].x + 100, objects[2].y - 100);
                add(objects[2]);
        }

        new FlxTimer().start(1, (_)->{
            FlxG.switchState(new scenes.OpenBoxState());
        });
    }
}
