let project = new Project('Testing');

// Add HaxePunk
await project.addProject("./../../../");

project.addAssets('assets/**', {
    nameBaseDir: 'assets',
    destination: '{dir}/{name}',
    name: '{dir}/{name}'
});

project.addShaders('Shaders/**');
project.addSources('Sources');


resolve(project);
