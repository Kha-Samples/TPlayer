package ;

import kha.Image;
import kha.Rectangle;

class Tile extends kha2d.Tile {
	public static var tiles : Array<kha2d.Tile>;
	var type : Int;
	var data1 : Int;
	var data2 : Int;
	var data3 : Int;
	var count : Int;
	var currentType : Int;
	var currentData1 : Int;
	var currentData2 : Int;
	var currentData3 : Int;
	var lines : Array<Int>;
	
	public function new(image : Image, imageIndex : Int, type : Int, data1 : Int, data2 : Int, data3 : Int) {
		super(imageIndex, false);
		currentType = this.type = type;
		currentData1 = this.data1 = data1;
		currentData2 = this.data2 = data2;
		currentData3 = this.data3 = data3;
		count = 0;
		switch (type) {
		case Tiletype.NORMALTYPE: collides = true;
		case Tiletype.ANI_NORMAL: collides = true;
		case Tiletype.DESTROY_SHOT: collides = false;
		case Tiletype.DESTROY_WALK: collides = false;
		case Tiletype.CHANGE_WALK: collides = false;
		case Tiletype.UNVISIBLE: collides = false;
		case Tiletype.IGNORIEREN: collides = false;
		case Tiletype.NOTTOUCH: collides = false;
		case Tiletype.ANI_NOTTOUCH: collides = false;
		case Tiletype.ANI_IGNORE: collides = false;
		case Tiletype.SPRITE: collides = false;
		}
		
		var xmax = Std.int(image.width / 32);
		var ymax = Std.int(image.height / 32);
		var ytile : Int = Std.int(imageIndex / xmax);
		var xtile : Int = imageIndex - ytile * xmax;
		lines = new Array<Int>();
		for (y in 0...32) {
			lines.push(0);
			for (x in 0...32) {
				if (image.isOpaque(xtile * 32 + x, ytile * 32 + y)) lines[y] |= 1;
				lines[y] <<= 1;
			}
		}
	}
	
	function isAnimated(type : Int) {
		return type == Tiletype.ANI_NORMAL || type == Tiletype.ANI_NOTTOUCH || type == Tiletype.ANI_IGNORE;
	}
	
	public function update() {
		if (isAnimated(currentType)) {
			//Data1 = The delay to the next animation frame.
			//Data2 = The tile number of the actual tile.
			//Data3 = The tile number of the next tile in the animation cycle.
			++count;
			if (count >= currentData1) {
				if (data2 == 470) {
					var a = 3;
					++a;
				}
				var newindex = currentData3;
				var tile = cast(tiles[newindex], Tile);
				currentType = tile.type;
				currentData1 = tile.data1;
				currentData2 = tile.data2;
				currentData3 = tile.data3;
				count = 0;
				imageIndex = isAnimated(currentType) ? currentData2 : newindex;
			}
		}
	}
	
	static function bits(from : Int, to : Int, value : Int) : Int {
		return value << from >>> (31 - to + from);
	}
	
	override public function collision(rect: Rectangle): Bool {
		if (collides) {
			var xstart = Std.int(Math.round(Math.max(0.0, rect.x - 1)));
			var xend   = Std.int(Math.round(Math.min(31.0, rect.x + rect.width - 1)));
			var ystart = Std.int(Math.round(Math.max(0.0, rect.y - 1)));
			var yend   = Std.int(Math.round(Math.min(31.0, rect.y + rect.height - 1)));
			if (xend < xstart) return false;
			for (y in ystart...yend + 1) {
				if (bits(xstart, xend, lines[y]) != 0) return true;
			}
			return false;
		}
		else return false;
	}
}