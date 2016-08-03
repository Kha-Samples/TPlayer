let project = new Project('T Player');

project.addLibrary('kha2d');

project.addAssets('Assets/**');

project.addSources('Sources');

resolve(project);
