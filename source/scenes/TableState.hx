package scenes;

import flixel.FlxState;
import flixel.FlxSprite;
import singletons.GameManager;
import flixel.FlxG;
import flixel.input.mouse.FlxMouseEvent;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;
class TableState extends FlxState
{
    var background:FlxSprite = new FlxSprite();
    var table:FlxSprite = new FlxSprite();

    var person:FlxSprite = new FlxSprite();

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

        // set up person
        person.loadGraphic("assets/images/person-spritesheet.png", true, 640, 360);
        person.screenCenter();
        person.setPosition(person.x - FlxG.width/2 - 100, person.y);

        add(person);

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

        // call the tween for the character to come see the price
        FlxTween.tween(person,
        {
            x:0
        }, 2, {
            ease: FlxEase.sineInOut,
            onComplete: (?_) ->
            {
                person.animation.frameIndex = 1;
                new FlxTimer().start(1, (_)->
                {
                    person.animation.frameIndex = 2;
                    new FlxTimer().start(1, (_)->
                    {
                        person.animation.frameIndex = 0;
                        FlxTween.tween(person,
                        {
                            x:FlxG.width + 100
                        }, 2, {
                            ease:FlxEase.sineInOut,
                            onComplete: (?_)->
                            {
                                FlxG.signals.preStateSwitch.addOnce(() ->
                                {
                                    remove(GameManager.Instance.currentObject);
                                });
                                FlxG.switchState(new scenes.DumpsterState());
                            }
                        }
                        );
                    });
                });
            }
        });
    }
}
