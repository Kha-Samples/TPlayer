package enemy;

import kha.Assets;
import kha.audio1.Audio;
import kha2d.Animation;
import kha2d.Direction;
import kha2d.Rectangle;
import kha2d.Scene;
import kha.Sound;
import kha2d.Sprite;

class Walker extends Enemy {
	private static var leftWalk: Animation;
	private static var rightWalk: Animation;
	private static var leftRun: Animation;
	private static var rightRun: Animation;
	private static var plattSound: Sound;
	private var direction: Direction;
	private var running: Bool;
	
	public static function init(): Void {
		rightWalk = Animation.createRange(0, 3, 20);
		rightRun = new Animation([4, 5], 20);
		leftWalk = new Animation([9, 8, 7, 6], 20);
		leftRun = new Animation([11, 10], 20);
		plattSound = Assets.sounds.enemy_platt;
	}
	
	public function new(x: Float, y: Float) {
		super(Assets.images.enemy_walker_b12x48x42, 48, 42, 0);
		this.x = x;
		this.y = y + 32 - 42;
		running = false;
		setAnimation(leftWalk);
		direction = LEFT;
		speedx = -2;
		collider = new Rectangle(8, 8, 32, 34);
	}
	
	override public function hitFrom(dir: Direction): Void {
		if (running) {
			if ((direction == LEFT && dir == RIGHT) || (direction == RIGHT && dir == LEFT)) {
				Scene.the.removeEnemy(this);
				Scene.the.addProjectile(new Explosion(x + 48 / 2, y + 42 / 2));
			}
		}
		if (direction == LEFT && dir == RIGHT) {
			setAnimation(rightWalk);
			direction = RIGHT;
			speedx = 2;
		}
		else if (direction == RIGHT && dir == LEFT) {
			setAnimation(leftWalk);
			direction = LEFT;
			speedx = -2;
		}
	}
	
	override public function hit(sprite: Sprite): Void {
		if (collisionRect().y + collisionRect().height > sprite.collisionRect().y + sprite.collisionRect().height + 8) {
			if (Std.is(sprite, Turrican)) {
				running = true;
				if (direction == LEFT) {
					setAnimation(leftRun);
					speedx = -4;
				}
				else {
					setAnimation(rightRun);
					speedx = 4;
				}
				cast(sprite, Turrican).reflect();
				Audio.play(plattSound);
			}
		}
	}
}
