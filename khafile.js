let project = new Project('T Player');

project.addLibrary('Kha2D');

project.addAssets('Assets/**', {
	background: {
		red: 0,
		green: 0,
		blue: 0
	},
	readable: true
});

project.addSources('Sources');

resolve(project);
