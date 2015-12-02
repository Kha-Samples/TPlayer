package;

import kha.Assets;
import kha2d.Animation;
import kha2d.Direction;
import kha2d.Rectangle;
import kha2d.Scene;
import kha.Sound;
import kha2d.Sprite;
import shots.BallShot;

class Turrican extends Sprite {
	private static var instance: Turrican;
	public var left: Bool;
	public var right: Bool;
	public var up: Bool;
	private var lookRight: Bool;
	private var standing: Bool;
	private var killed: Bool;
	private var jumpcount: Int;
	private var lastupcount: Int;
	private var walkLeft: Animation;
	private var walkRight: Animation;
	private var standLeft: Animation;
	private var standRight: Animation;
	private var jumpLeft: Animation;
	private var jumpRight: Animation;
	private var landSound: Sound;
	
	public function new() {
		super(Assets.images.t_b80x80x86, Std.int(640 / 8), Std.int(860 / 10), 0);
		instance = this;
		x = y = 50;
		standing = false;
		walkLeft = new Animation([13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 2);
		walkRight = Animation.createRange(14, 27, 2);
		standLeft = Animation.create(33);
		standRight = Animation.create(43);
		jumpLeft = Animation.create(51);
		jumpRight = Animation.create(49);
		landSound = Assets.sounds.T_fall_landing;
		setAnimation(jumpRight);
		up = false;
		right = false;
		left = false;
		lookRight = true;
		killed = false;
		jumpcount = 0;
		maxspeedy = 7.0;
		collider = new Rectangle(20, 16, 40, 70);
	}
	
	public static function getInstance(): Turrican {
		return instance;
	}
	
	public function reset(): Void {
		x = y = 50;
		standing = false;
		setAnimation(jumpRight);
	}
	
	public override function update(): Void {
		if (lastupcount > 0) --lastupcount;
		if (!killed) {
			if (right) {
				if (standing) setAnimation(walkRight);
				speedx = 3.0;
				lookRight = true;
			}
			else if (left) {
				if (standing) setAnimation(walkLeft);
				speedx = -3.0;
				lookRight = false;
			}
			else {
				if (standing) setAnimation(lookRight ? standRight : standLeft);
				speedx = 0;
			}
			if (up && standing) {
				setAnimation(lookRight ? jumpRight : jumpLeft);
				speedy = -9;
			}
			else if (!standing && !up && speedy < 0 && jumpcount == 0) speedy = 0;
			
			if (!standing) setAnimation(lookRight ? jumpRight : jumpLeft);
			
			standing = false;
		}
		if (jumpcount > 0) --jumpcount;
		super.update();
	}
	
	public function shot(): Void {
		Scene.the.addProjectile(new BallShot(lookRight ? x + 60 : x - 20, y + 26, lookRight));
	}
	
	public function setUp(): Void {
		up = true;
		lastupcount = 8;
	}
	
	public function reflect(): Void {
		speedy = -8;
		jumpcount = 10;
		standing = false;
	}
	
	public override function hitFrom(dir: Direction): Void {
		if (dir == Direction.UP) {
			//if (speedy > 4) {
			//	landSound.play();
			//}
			//speedy = 0;
			standing = true;
			if (lastupcount < 1) up = false;
		}
		else if (dir == Direction.DOWN) speedy = 0;
	}
}
