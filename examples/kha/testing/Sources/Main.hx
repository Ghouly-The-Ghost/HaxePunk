import haxepunk.Engine;
import haxepunk.HXP;
import kha.Assets;

class Main extends Engine
{
	override public function init()
	{
		HXP.scene = new scenes.GameScene();
	}

	public static function main() { 
		// Assets.loadEverything(function () {
			new Main();
		// });	
	}
}