package enemy;

import kha.Animation;
import kha.Direction;
import kha.Loader;
import kha.Rectangle;
import kha.Scene;
import kha.Sound;
import kha.Sprite;

class Walker extends Enemy {
	static var leftWalk : Animation;
	static var rightWalk : Animation;
	static var leftRun : Animation;
	static var rightRun : Animation;
	static var plattSound : Sound;
	var direction : Direction;
	var running : Bool;
	
	public static function init() : Void {
		rightWalk = Animation.createRange(0, 3, 20);
		rightRun = new Animation([4, 5], 20);
		leftWalk = new Animation([9, 8, 7, 6], 20);
		leftRun = new Animation([11, 10], 20);
		plattSound = Loader.getInstance().getSound("enemy_platt");
	}
	
	public function new(x : Float, y : Float) {
		super(Loader.getInstance().getImage("enemy_walker_b12x48x42.png"), 48, 42, 0);
		this.x = x;
		this.y = y + 32 - 42;
		running = false;
		setAnimation(leftWalk);
		direction = LEFT;
		speedx = -2;
		collider = new Rectangle(8, 8, 32, 34);
	}
	
	override public function hitFrom(dir : Direction) : Void {
		if (running) {
			if ((direction == LEFT && dir == RIGHT) || (direction == RIGHT && dir == LEFT)) {
				Scene.getInstance().removeEnemy(this);
				Scene.getInstance().addProjectile(new Explosion(x + 48 / 2, y + 42 / 2));
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
	
	override public function hit(sprite : Sprite) : Void {
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
				plattSound.play();
			}
		}
	}
}