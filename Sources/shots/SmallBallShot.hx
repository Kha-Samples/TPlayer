package shots;

import enemy.Enemy;
import kha.audio1.Audio;
import kha2d.Direction;
import kha.Loader;
import kha2d.Scene;
import kha.Sound;
import kha2d.Sprite;

class SmallBallShot extends Sprite {
	static var sound : Sound;
	var reflectCount : Int;
	
	public static function init() : Void {
		sound = Loader.the.getSound("T_shot_kugel_klein");
	}
	
	public function new(x : Float, y : Float, right : Bool, up : Bool) {
		super(Loader.the.getImage("tshot_kugel_klein_b2x16x16"), 16, 16, 0);
		this.x = x - 16 / 2;
		this.y = y - 16 / 2;
		speedx = right ? 5 : -5;
		speedy = up ? 5 : -5;
		accy = 0;
		Audio.playSound(sound);
		reflectCount = 1;
	}
	
	override public function hit(sprite : Sprite) : Void {
		if (Std.is(sprite, Enemy)) {
			Scene.the.removeProjectile(this);
			cast(sprite, Enemy).hitWithShot();
		}
	}
	
	override public function hitFrom(dir : Direction) : Void {
		if (reflectCount <= 0) Scene.the.removeProjectile(this);
		else {
			if (dir == RIGHT || dir == LEFT) speedx = -speedx;
			else speedy = -speedy;
			Audio.playSound(sound);
		}
		Scene.the.addProjectile(new SmallExplosion(x + 8, y + 8));
		--reflectCount;
	}
	
	override public function outOfView() : Void {
		Scene.the.removeProjectile(this);
	}
}