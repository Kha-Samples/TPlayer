package shots;

import enemy.Enemy;
import kha.Direction;
import kha.Loader;
import kha.Scene;
import kha.Sprite;
import kha.Sound;

class BallShot extends Sprite {
	static var sound : Sound;
	
	public static function init() : Void {
		sound = Loader.the.getSound("T_shot_kugel_normal");
	}
	
	public function new(x : Float, y : Float, right : Bool) {
		super(Loader.the.getImage("tshot_kugel_normal_b1x32x32"), 32, 32, 0);
		this.x = x - 32 / 2;
		this.y = y - 32 / 2;
		speedx = right ? 10 : -10;
		accy = 0;
		sound.play();
	}
	
	override public function hit(sprite : Sprite) : Void {
		if (Std.is(sprite, Enemy)) {
			Scene.the.removeProjectile(this);
			cast(sprite, Enemy).hitWithShot();
		}
	}
	
	override public function hitFrom(dir : Direction) : Void {
		if (dir != LEFT && dir != RIGHT) return;
		Scene.the.removeProjectile(this);
		switch (dir) {
		case RIGHT:
			Scene.the.addProjectile(new SmallExplosion(x + 16, y + 16));
			Scene.the.addProjectile(new SmallBallShot(x + 16, y + 16, true, true));
			Scene.the.addProjectile(new SmallBallShot(x + 16, y + 16, true, false));
		case LEFT:
			Scene.the.addProjectile(new SmallExplosion(x + 16, y + 16));
			Scene.the.addProjectile(new SmallBallShot(x + 16, y + 16, false, true));
			Scene.the.addProjectile(new SmallBallShot(x + 16, y + 16, false, false));
		default:
		}
	}
	
	override public function outOfView() : Void {
		Scene.the.removeProjectile(this);
	}
}