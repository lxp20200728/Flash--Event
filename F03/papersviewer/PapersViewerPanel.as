package papersviewer
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PapersViewerPanel extends Sprite
	{
		private var barController:BarController =new BarController();
		private var viewController:ViewController = new ViewController();
		public function PapersViewerPanel()
		{
			barController.setBarView(this.bar);
			viewController.setView(this.view);
		}
	}
}