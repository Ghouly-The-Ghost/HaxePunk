let project = new Project('Testing');

project.addAssets('assets/**', {
    nameBaseDir: 'assets',
    destination: '{dir}/{name}',
    name: '{dir}/{name}'
});

project.addShaders('Shaders/**');
project.addSources('Sources');

resolve(project);
