package haxepunk.utils;

/**
 * This abstract is used to make Lime asset paths usable with Kha based asset paths. 
 * This abstract should already be wrapped within HaxePunk functions that interface with
 * Kha paths.
 */
abstract AssetPath(String) to String
{
    private static var pathConversion = ~/[\/.]/g;
    public inline function new(path:String)
    {
        #if !hxp_lime_asset_paths
        this = path;
        #else
        this = pathConversion.replace(path, "_");
        #end
    }
    
    @:from static inline public function fromString(path:String)
    {
        return new AssetPath(path);
    }
    
    @:from public static inline function fromAssetPath(other:AssetPath)
    {
        return other;
    }
}