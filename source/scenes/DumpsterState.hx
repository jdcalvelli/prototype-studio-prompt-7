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

        // add current object
        GameManager.Instance.currentObject.screenCenter();
        GameManager.Instance.currentObject.setPosition(
            GameManager.Instance.currentObject.x + new FlxRandom().int(55, 80),
            GameManager.Instance.currentObject.y - new FlxRandom().int(50, 70),
        );
        GameManager.Instance.currentObject.visible = false;
        add(GameManager.Instance.currentObject);

        FlxMouseEvent.add(dumpster, onMouseDown);
    }

    override public function update(elapsed:Float){}

    // callbacks

    function onMouseDown(sprite:FlxSprite)
    {
        GameManager.Instance.currentObject.visible = true;

        new FlxTimer().start(1, (_)->{
            FlxG.signals.preStateSwitch.addOnce(() ->
            {
                GameManager.Instance.discardedObjects.push(GameManager.Instance.currentObject);
                remove(GameManager.Instance.currentObject);
            });
            FlxG.switchState(new scenes.OpenBoxState());
        });
    }
}
