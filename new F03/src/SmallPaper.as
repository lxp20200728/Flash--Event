package {
	import flash.display.Sprite;
	import flash.system.ApplicationDomain;

	public class SmallPaper extends Sprite
	{
		private static const CLASS_NAME_PREFIX:String = "mmo.mailbox.smallpaper.SmallPaper";
		private static const CLASS_NAME_ID_PREFIX:int = 10001;
		
		private var _id:int;
		
		public function SmallPaper(id:int)
		{
			this._id = id;
			initView();
		}
		private function initView():void
		{
			var clsId:int = CLASS_NAME_ID_PREFIX + _id;
			var clsName:String = CLASS_NAME_PREFIX + clsId;
			var cls:Class = ApplicationDomain.currentDomain.getDefinition(clsName) as Class;
			var view:Sprite = new cls() as Sprite;
			view.mouseChildren = false;
			view.mouseEnabled = false;
			this.addChild(view);
			this.buttonMode = true;
			
		}
		public function getId():int
		{
			return this._id;
		}
	}
}