import haxepunk.Engine;
import haxepunk.HXP;

class Main extends Engine
{

	override public function init()
	{
		HXP.scene = new scenes.GameScene();
	}

	public static function main() { new Main(); }
}