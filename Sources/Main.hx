package;
import kha.Scheduler;
import kha.System;

class Main {	
	static function main() {
		System.init("T Player", 800, 600, initialized);
	}
	
	private static function initialized(): Void {
		var player = new TPlayer();
		System.notifyOnRender(player.render);
		Scheduler.addTimeTask(player.update, 0, 1 / 60);
	}
}
