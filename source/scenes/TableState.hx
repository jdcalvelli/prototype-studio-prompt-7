package scenes;

import flixel.FlxState;
import flixel.FlxSprite;
import singletons.GameManager;
import flixel.FlxG;
class TableState extends FlxState
{
    var background:FlxSprite = new FlxSprite();
    var table:FlxSprite = new FlxSprite();
    var overlay:FlxSprite = new FlxSprite();

    var currentObject:FlxSprite;

    var priceTags:Map<String, FlxSprite> = [
        "tag1" => new FlxSprite().loadGraphic("assets/images/one-dollar-tag.PNG"),
        "tag2" => new FlxSprite().loadGraphic("assets/images/two-dollar-tag.PNG"),
        "tag3" => new FlxSprite().loadGraphic("assets/images/three-dollar-tag.PNG"),
    ];

    override public function create()
    {
        // setup background
        background.loadGraphic("assets/images/Background.PNG");
        background.screenCenter();
        add(background);

        // setup table
        table.loadGraphic("assets/images/table.PNG");
        add(table);

        // set up item
        GameManager.Instance.currentObject.setPosition(FlxG.width/2 - 70, FlxG.height/2);
        add(GameManager.Instance.currentObject);

        // set up tags
        for (tag in priceTags)
        {
            add(tag);
        }

        // set up overlay
        overlay.loadGraphic("assets/images/item-holder.PNG");
        overlay.screenCenter();
        add(overlay);
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}
