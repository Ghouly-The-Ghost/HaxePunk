package haxepunk.assets;

import haxepunk.graphics.hardware.Texture;
import kha.Assets;

/**
 * AssetLoader is used to load a new copy of an asset, bypassing the cache.
 */
class AssetLoader
{
	public static function getText(id:String):String
	{
		return Assets.blobs.get(dataPath(id)).toString();
	}

	public static function getSound(id:String):Dynamic
	{
		throw "Unimplemented";
	}

	public static function getTexture(id:String):Texture
	{
		return Assets.images.get(assetPath(id));
	}

	static function dataPath(id):String
	{
		var r = ~/[\/.]/g;
		return r.replace(id, "_");
	}

	static function assetPath(id):String 
	{
		return dataPath(id.substring(0, id.lastIndexOf(".", id.length)));
	}
}
