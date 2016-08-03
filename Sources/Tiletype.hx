package;

class Tiletype {
	static public inline var NORMALTYPE = 0;
	static public inline var ANI_NORMAL = 1;   //solides animiertes Tile
	static public inline var DESTROY_SHOT = 2; //Tile kann abgschossen werden
	static public inline var DESTROY_WALK = 3; //Tile wird beim darueberlaufen zerstoert
	static public inline var CHANGE_WALK = 4;  //Tile aendert sich beim darueberlaufen (Kettenbruecke)
	static public inline var UNVISIBLE = 5;    //unsichtbares Tile
	static public inline var IGNORIEREN = 6;   //Tile stellt kein Hinderniss dar
	static public inline var NOTTOUCH = 7;     //Tile darf nicht beruehrt werden (z.B Spitzen)
	static public inline var ANI_NOTTOUCH = 8; //wie 7, aber animiert
	static public inline var ANI_IGNORE = 9;   //wie 6, aber animiert
	static public inline var SPRITE = 10;      //Platzhalter fuer ein Sprite
}
