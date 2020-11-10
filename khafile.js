let project = new Project('HaxePunk');

function addAssets( path ){
    project.addAssets(`assets/${path}/**`, {
        nameBaseDir: path,
        destination: '{dir}/{name}',
        name: '{dir}/{name}'
    });
}

project.addSources(''); // what?
// project.addSources('backend/kha');

addAssets('graphics');
addAssets('font');

// project.addParameter('--macro haxepunk.utils.Platform.run()');

resolve(project);