package enemy;

import kha.Animation;
import kha.Direction;
import kha.Loader;
import kha.Painter;
import kha.Sprite;

class Fly extends Enemy {
	var speedChangeCount : Int;
	
	public function new(x : Float, y : Float) {
		super(Loader.the.getImage("enemy_fliege_b2x44x28"), 44, 28, 0);
		this.x = x + 16 - 44 / 2;
		this.y = y + 16 - 28 / 2;
		accy = 0;
		setAnimation(new Animation([0, 1], 2));
		setRandomSpeed();
	}
	
	override public function update() {
		super.update();
		--speedChangeCount;
		if (speedChangeCount <= 0) setRandomSpeed();
	}
	
	override public function hitFrom(dir : Direction) {
		setRandomSpeed();
	}
	
	function setRandomSpeed() : Void {
		speedx = (Math.random() * 8) - 4;
		speedy = (Math.random() * 8) - 4;
		speedChangeCount = Std.int(Math.random() * 8 * 60);
	}
}