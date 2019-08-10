/// Haxepunk library khafile

let project = new Project('haxepunk');

// <app preloader="haxepunk.Preloader" unless="hxp_no_preloader" />
//     <app swf-version="11.7" if="flash" />

//     <haxedef name="hxp_debug" if="debug || hxp_debug_console" />
//     <haxedef name="hxp_gl_debug" if="gl_debug" />

//     <section unless="hxp_no_assets">
//         <assets path="assets/graphics" rename="graphics" include="*.png" />
//         <assets path="assets/font" rename="font" include="*.ttf" />
//         <assets path="assets/font" rename="font" include="*.fnt" type="text" />
//         <assets path="assets/font" rename="font" include="*.png" type="image" />
//     </section>
//     <section if="hxp_debug_console">
//         <assets path="assets/font" rename="font" include="*.fnt" type="text" />
//         <assets path="assets/font" rename="font" include="*.png" type="image" />
//     </section>

//     <haxedef name="source-header" value="haxe" />
//     <haxeflag name="--macro" value="haxepunk.utils.Platform.run()" />


project.addSources('haxepunk');

HaxePunkConfig.message = "test"


// // Setup configuration defaults 
// cfg = HaxePunkConfig || {};

// cfg.hxp_no_assets |= false;
// cfg.hxp_debug_console |= false;

// if (!HXP_CFG.hxp_no_assets) {
//     project.addAssets('assets/**');
// }
// if (HXP_CFG.hxp_debug_console)
// {
//     project.addAssets('assets/font/**');
// }


project.addDefine('hxp_test_message_lib');

project.addShaders('shaders/**');

resolve(project);
