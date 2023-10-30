package scenes;

import flixel.FlxState;
import flixel.FlxSprite;
import singletons.GameManager;
import flixel.FlxG;
import flixel.input.mouse.FlxMouseEvent;
class TableState extends FlxState
{
    var background:FlxSprite = new FlxSprite();
    var table:FlxSprite = new FlxSprite();
    var overlay:FlxSprite = new FlxSprite();

    var currentObject:FlxSprite;

    var priceTags:Array<FlxSprite> = [
        new FlxSprite().loadGraphic("assets/images/one-dollar-tag.PNG"),
        new FlxSprite().loadGraphic("assets/images/two-dollar-tag.PNG"),
        new FlxSprite().loadGraphic("assets/images/three-dollar-tag.PNG"),
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
            tag.screenCenter();

            if (tag == priceTags[0])
            {
                tag.x = tag.x + 80;
                tag.y = tag.y + 20;
            }
            if (tag == priceTags[1])
            {
                tag.x = tag.x + 80;
                tag.y = tag.y + 45;
            }
            if (tag == priceTags[2])
            {
                tag.x = tag.x + 80;
                tag.y = tag.y + 70;
            }

            add(tag);

            FlxMouseEvent.add(tag, OnMouseDown);
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

    // callbacks
    function OnMouseDown(sprite:FlxSprite)
    {
        sprite.setPosition(
            GameManager.Instance.currentObject.x + 50,
            GameManager.Instance.currentObject.y + 10,
        );

        for (tag in priceTags)
        {
            FlxMouseEvent.remove(tag);
        }
    }
}
