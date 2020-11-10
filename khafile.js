let project = new Project('HaxePunk');

// TODO: Mimic include.xml more closely

function addAssets( path ){
    project.addAssets(`assets/${path}/**`, {
        nameBaseDir: path,
        destination: '{dir}/{name}',
        name: '{dir}/{name}'
    });
}

project.addSources('haxepunk');
// project.addSources('backend/kha');

addAssets('graphics');
addAssets('font');

project.addParameter('--macro haxepunk.utils.Platform.run()');

resolve(project);