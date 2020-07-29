package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PapersViewerPanel extends Sprite
	{
		private var barController:BarController = new BarController();
		private var viewController:ViewController = new ViewController();
		public function PapersViewerPanel()
		{
            viewController.setView(this.getChildByName("view") as Sprite);
			barController.setBarView(this.getChildByName("bar") as Sprite);
		}
	}
}