let project = new Project('T Player');

project.addLibrary('kha2d');

project.addAssets('Assets/**', {
	background: {
		red: 0,
		green: 0,
		blue: 0
	}
});

project.addSources('Sources');

resolve(project);
