package;

import kha.Assets;
import kha2d.Animation;
import kha2d.Scene;
import kha.Sound;
import kha2d.Sprite;

class SmallExplosion extends Sprite {
	private var count: Int;
	
	public function new(x: Float, y: Float) {
		super(Assets.images.explo_klein_b4x28x28, 28, 28, 0);
		this.x = x - 28 / 2;
		this.y = y - 28 / 2;
		setAnimation(Animation.createRange(0, 3, 4));
		count = 4 * 4;
	}
	
	override public function update(): Void {
		super.update();
		--count;
		if (count <= 0) Scene.the.removeProjectile(this);
	}
}
