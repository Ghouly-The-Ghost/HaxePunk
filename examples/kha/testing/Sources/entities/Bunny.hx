package entities;

import haxepunk.Entity;
import haxepunk.HXP;
import haxepunk.graphics.Image;
import haxepunk.Graphic;
import haxepunk.math.Vector2;

/**
 * ...
 * @author Zaphod
 */
class BunnyImage extends Image
{
	public var velocity:Vector2;
	public var angularVelocity:Float;

	static var bunnyCount:Int = 0;
	var bunnyNum:Int = 0;

	public function new(graphic:ImageType)
	{
		super(graphic);

		trace(graphic);

		velocity = new Vector2(10, 10);
		velocity.x = 10;
		velocity.y = 10;
		angularVelocity = 0;

		maxX = HXP.width;
		maxY = HXP.height;
		active = true;
		bunnyNum = bunnyCount ++;

		trace(maxX);
		trace(maxY);
		// trace('bunny created: ${bunnyNum}');
	}

	override public function update()
	{
		var elapsed = 0.10; // HXP.elapsed;
		x += velocity.x * elapsed;
		velocity.y = gravity * elapsed;
		y += velocity.y * elapsed;
		angle += angularVelocity * elapsed;
		alpha = 0.3 + 0.7 * y / maxY;

		// trace('bunny ${bunnyNum}: updated -> ${x}, ${y}');

		if (x > maxX)
		{
			velocity.x *= -1;
			x = maxX;
		}
		else if (x < 0)
		{
			velocity.x *= -1;
			x = 0;
		}
		if (y > maxY)
		{
			velocity.y *= -0.8;
			y = maxY;
			if (Math.random() > 0.5) velocity.y -= 3 + Math.random() * 4;
			trace('jumped: ${bunnyNum}');
		}
		else if (y < 0)
		{
			velocity.y *= -0.8;
			y = 0;
		}

		super.update();
	}

	// override public function render(camera){
	// 	super(camera);
	// 	trace("drawing me");
	// }

	static var maxX:Int = 320;
	static var maxY:Int = 480;
	static inline var gravity:Int = 5;

}