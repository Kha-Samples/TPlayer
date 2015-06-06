package;

import kha.audio1.Audio;
import kha2d.Animation;
import kha.Loader;
import kha2d.Scene;
import kha.Sound;
import kha2d.Sprite;

class Explosion extends Sprite {
	static var sound : Sound;
	var count : Int;
	
	public static function init() : Void {
		sound = Loader.the.getSound("explo_normal");
	}
	
	public function new(x : Float, y : Float) {
		super(Loader.the.getImage("explo_normal_b5x58x54"), 58, 54, 0);
		this.x = x - 58 / 2;
		this.y = y - 54 / 2;
		setAnimation(Animation.createRange(0, 4, 4));
		count = 4 * 5;
		Audio.playSound(sound);
	}
	
	override public function update() : Void {
		super.update();
		--count;
		if (count <= 0) Scene.the.removeProjectile(this);
	}
}