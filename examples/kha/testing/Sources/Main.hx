import haxepunk.Engine;
import haxepunk.HXP;
import kha.Assets;

class Main extends Engine
{
	override public function init()
	{
		trace("working??");
		HXP.scene = new scenes.GameScene();
		trace("Created the scene");
	}

	public static function main() { 
		Assets.loadEverything(function () {
			new Main();
		});	
	}
}