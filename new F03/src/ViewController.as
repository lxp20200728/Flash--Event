package {
	import flash.display.Sprite;

	public class ViewController
	{
		private static const URL_NAME_PREFIX:String = "paper";
		private static const URL_ID_PREFIX:int = 10001;
		
		private static const CLASS_NAME_PREFIX:String = "mmo.mailbox.letter.LetterPaper";
		private static const CLASS_ID_PREFIX:int = 10001;
		
		private var resLoader:ResLoader = new ResLoader();
	
		private var _view:Sprite;
		private var _container:Sprite;
		public function ViewController()
		{
		}
		public function setView(view:Sprite):void
		{
			this._view = view;
			this._container = this._view.getChildByName("ct") as Sprite;
            initListeners();
		}
		private function clearContainer():void
		{
			var numChildren:int = this._container.numChildren;
			for(var index:int = numChildren -1;index >= 0;index--)
			{
				this._container.removeChildAt(index);
			}
		}
		private function addBigPaperView(content:Sprite):void
		{
			clearContainer();
			_container.addChild(content);
		}
		private function initListeners():void
		{
			/*************************************************************************
			 **任务3：
			 ***监听事件 LoadPageEvent.LOAD_PAGE，根据Id加载大图 （以提供 loadPage方法）
			 *************************************************************************/
            LoadPageEventDispatcher.getInstance().addEventListener(LoadPageEvent.LOAD_PAGE, changePhotos);
		}
        private function changePhotos(evt:LoadPageEvent):void
        {
            this.loadPage(evt.getId());
        }
		
		/**
		 * 根据Id加载大图，异步加载资源
		 * */
		private function loadPage(id:int):void
		{
			var url:String = URL_NAME_PREFIX + (URL_ID_PREFIX + id) + ".swf";
			var clsName:String = CLASS_NAME_PREFIX + (CLASS_ID_PREFIX + id);
			resLoader.load(url,clsName,function(content:Sprite):void
			{
				addBigPaperView(content);
			});
		}
	}
}