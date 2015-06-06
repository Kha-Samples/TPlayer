package;

import kha2d.Animation;
import kha2d.Direction;
import kha.Loader;
import kha.Music;
import kha.Rectangle;
import kha2d.Scene;
import kha.Sound;
import kha2d.Sprite;
import shots.BallShot;

class Turrican extends Sprite {
	static var instance : Turrican;
	public var left : Bool;
	public var right : Bool;
	public var up : Bool;
	var lookRight : Bool;
	var standing : Bool;
	var killed : Bool;
	var jumpcount : Int;
	var lastupcount : Int;
	var walkLeft : Animation;
	var walkRight : Animation;
	var standLeft : Animation;
	var standRight : Animation;
	var jumpLeft : Animation;
	var jumpRight : Animation;
	var landSound : Sound;
	
	public function new() {
		super(Loader.the.getImage("t_b80x80x86"), Std.int(640 / 8), Std.int(860 / 10), 0);
		instance = this;
		x = y = 50;
		standing = false;
		walkLeft = new Animation([13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0], 2);
		walkRight = Animation.createRange(14, 27, 2);
		standLeft = Animation.create(33);
		standRight = Animation.create(43);
		jumpLeft = Animation.create(51);
		jumpRight = Animation.create(49);
		landSound = Loader.the.getSound("T_fall_landing");
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
	
	public static function getInstance() : Turrican {
		return instance;
	}
	
	public function reset() {
		x = y = 50;
		standing = false;
		setAnimation(jumpRight);
	}
	
	public override function update() {
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
	
	public function shot() {
		Scene.the.addProjectile(new BallShot(lookRight ? x + 60 : x - 20, y + 26, lookRight));
	}
	
	public function setUp() {
		up = true;
		lastupcount = 8;
	}
	
	public function reflect() {
		speedy = -8;
		jumpcount = 10;
		standing = false;
	}
	
	public override function hitFrom(dir : Direction) {
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