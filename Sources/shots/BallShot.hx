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
		sound = Loader.getInstance().getSound("T_shot_kugel_normal");
	}
	
	public function new(x : Float, y : Float, right : Bool) {
		super(Loader.getInstance().getImage("tshot_kugel_normal_b1x32x32.png"), 32, 32, 0);
		this.x = x - 32 / 2;
		this.y = y - 32 / 2;
		speedx = right ? 10 : -10;
		accy = 0;
		sound.play();
	}
	
	override public function hit(sprite : Sprite) : Void {
		if (Std.is(sprite, Enemy)) {
			Scene.getInstance().removeProjectile(this);
			cast(sprite, Enemy).hitWithShot();
		}
	}
	
	override public function hitFrom(dir : Direction) : Void {
		if (dir != LEFT && dir != RIGHT) return;
		Scene.getInstance().removeProjectile(this);
		switch (dir) {
		case RIGHT:
			Scene.getInstance().addProjectile(new SmallExplosion(x + 16, y + 16));
			Scene.getInstance().addProjectile(new SmallBallShot(x + 16, y + 16, true, true));
			Scene.getInstance().addProjectile(new SmallBallShot(x + 16, y + 16, true, false));
		case LEFT:
			Scene.getInstance().addProjectile(new SmallExplosion(x + 16, y + 16));
			Scene.getInstance().addProjectile(new SmallBallShot(x + 16, y + 16, false, true));
			Scene.getInstance().addProjectile(new SmallBallShot(x + 16, y + 16, false, false));
		default:
		}
	}
	
	override public function outOfView() : Void {
		Scene.getInstance().removeProjectile(this);
	}
}