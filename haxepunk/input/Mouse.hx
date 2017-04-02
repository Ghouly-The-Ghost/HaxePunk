package haxepunk.input;

@:enum
abstract Mouse(Int) from Int to Int
{
	var LeftButton = 1;
	var RightButton = 2;

	public static function init() {}
}
