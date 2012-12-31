package shots;

import enemy.Enemy;
import kha.Direction;
import kha.Loader;
import kha.Scene;
import kha.Sound;
import kha.Sprite;

class SmallBallShot extends Sprite {
	static var sound : Sound;
	var reflectCount : Int;
	
	public static function init() : Void {
		sound = Loader.getInstance().getSound("T_shot_kugel_klein");
	}
	
	public function new(x : Float, y : Float, right : Bool, up : Bool) {
		super(Loader.getInstance().getImage("tshot_kugel_klein_b2x16x16.png"), 16, 16, 0);
		this.x = x - 16 / 2;
		this.y = y - 16 / 2;
		speedx = right ? 5 : -5;
		speedy = up ? 5 : -5;
		accy = 0;
		sound.play();
		reflectCount = 1;
	}
	
	override public function hit(sprite : Sprite) : Void {
		if (Std.is(sprite, Enemy)) {
			Scene.getInstance().removeProjectile(this);
			cast(sprite, Enemy).hitWithShot();
		}
	}
	
	override public function hitFrom(dir : Direction) : Void {
		if (reflectCount <= 0) Scene.getInstance().removeProjectile(this);
		else {
			if (dir == RIGHT || dir == LEFT) speedx = -speedx;
			else speedy = -speedy;
			sound.play();
		}
		Scene.getInstance().addProjectile(new SmallExplosion(x + 8, y + 8));
		--reflectCount;
	}
	
	override public function outOfView() : Void {
		Scene.getInstance().removeProjectile(this);
	}
}