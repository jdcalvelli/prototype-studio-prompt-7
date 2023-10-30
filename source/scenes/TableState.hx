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

    var objects:Array<FlxSprite> = [
        new FlxSprite().loadGraphic("assets/images/thing-one.PNG"),
        new FlxSprite().loadGraphic("assets/images/thing-two.PNG"),
        new FlxSprite().loadGraphic("assets/images/thing-three.PNG"),
    ];

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

        switch GameManager.Instance.selectedObject
        {
            case "first":
                objects[0].screenCenter();
                objects[0].y = objects[0].y + 30;
                add(objects[0]);
            case "second":
                objects[1].screenCenter();
                objects[1].y = objects[1].y + 30;
                add(objects[1]);
            case "third":
                objects[2].screenCenter();
                objects[2].y = objects[2].y + 30;
                add(objects[2]);
        }

        // set up tags
        for (tag in priceTags)
        {
            tag.screenCenter();

            if (tag == priceTags[0])
            {
                tag.x = tag.x + 80;
                tag.y = tag.y + 20;
            }
            else if (tag == priceTags[1])
            {
                tag.x = tag.x + 80;
                tag.y = tag.y + 45;
            }
            else if (tag == priceTags[2])
            {
                tag.x = tag.x + 80;
                tag.y = tag.y + 70;
            }

            add(tag);

            FlxMouseEvent.add(tag, OnMouseDown);
        }
    }

    // callbacks
    function OnMouseDown(sprite:FlxSprite)
    {
        sprite.screenCenter();
        sprite.setPosition(sprite.x + 40, sprite.y + 10);

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
