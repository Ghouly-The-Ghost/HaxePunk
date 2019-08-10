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


project.addSources('.');

// // Setup configuration defaults 
let cfgDefault = {
    all: {
        meta: {
            title: 'project name',
            package: 'com.project.app',
            version: '0.0.0',
            company: 'company',
            icon: 'HaxePunk-icon.svg'
        },
        window: {
            fps: 60,
            background: '0x333333',
            width: 1280,
            height: 960,
            resizable: true
        },
        assets: [],
        flags: {
            hxp_deubg: false,
            hxp_no_assets: false,
            hxp_debug_console: false,
            hxp_gl_debug: false,
            hxp_loglevel: 'debug'
        }
    }
};

function writeOver(base, ...fillers) {
    for (let fill of fillers) {
        for (let prop in fill) {
            if (typeof fill[prop] === "object") {
                if (!base.hasOwnProperty(prop)) {
                    base[prop] = fill[prop];
                } else {
                    writeOver(base[prop], fill[prop]);
                }
            } else {
                base[prop] = fill[prop];
            }
        }
    }
};

let cfg = cfgDefault;
writeOver(cfg, HaxePunkConfig || {});

let flags = cfg.all.flags;
if (!flags.hxp_no_assets) {
    project.addAssets('assets/**');
    project.addShaders('shaders/**');
}

if (flags.hxp_debug_console) project.addAssets('assets/font/**');
flags.hxp_debug = flags.hxp_debug || flags.hxp_debug_console;

// HaxePunk flags
for (let key in flags) {
    if (flags[key]) project.addDefine(key);
}

// Export utils
HaxePunkConfig.utils = {
    loadAssets: (project) => {
        // ...do asset loading abstraction here...
    }
};

resolve(project);
