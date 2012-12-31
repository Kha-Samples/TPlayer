package ;

class Tiletype {
	static public var NORMALTYPE = 0;
	static public var ANI_NORMAL = 1;		//solides animiertes Tile
	static public var DESTROY_SHOT = 2;	//Tile kann abgschossen werden
	static public var DESTROY_WALK = 3;	//Tile wird beim darueberlaufen zerstoert
	static public var CHANGE_WALK = 4;	//Tile aendert sich beim darueberlaufen (Kettenbruecke)
	static public var UNVISIBLE = 5;		//unsichtbares Tile
	static public var IGNORIEREN = 6;		//Tile stellt kein Hinderniss dar
	static public var NOTTOUCH = 7;		//Tile darf nicht beruehrt werden (z.B Spitzen)
	static public var ANI_NOTTOUCH = 8;	//wie 7, aber animiert
	static public var ANI_IGNORE = 9;		//wie 6, aber animiert
	static public var SPRITE = 10;			//Platzhalter fuer ein Sprite
}