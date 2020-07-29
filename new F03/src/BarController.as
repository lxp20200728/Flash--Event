package {
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
	import flash.text.TextField;

	public class BarController
	{
		private static const PAGESIZE:int = 4;
		private static const PAGEMAX:int = 10;
		private static const INITX:Number = 64.55;
		private static const INITY:Number = 40.5;
		private static const GAP:Number = 137.3;
		
		private var _barView:Sprite;
		private var _pageNum:int = 0;//当前的页数
		private var _totalPage:int;//总页数
		private var smallPaperList:Array = [];
		private var _container:Sprite;//加载小图的容器
		private var _id:int = 0;
		public function BarController()
		{	
			this._totalPage = Math.ceil(PAGEMAX/PAGESIZE);
		}
		public function setBarView(barView:Sprite):void
		{
			this._barView = barView;
			this._container = this._barView.getChildByName("ct") as Sprite;
			initSmallPaperList();
			this._pageNum = 0;
			this._id = 0;
			freshPage();
			selectPageById();
			/*************************************************************************
			**任务1：监听鼠标事件 MouseEvent.CLICK,处理向前翻页，向后翻页
			**以及点击小图后加载大图
			*************************************************************************/
			this._barView.addEventListener(MouseEvent.CLICK, changePages);
		}

        private function changePages(evt:Event):void{
            switch(evt.target.name)
            {
                case "btnPrev":
                    this._pageNum = this._pageNum - 1 ;
                    break;
                case "btnNext":
                    this._pageNum = this._pageNum + 1 ;
                    break;
				case "smallPaper0":
					this._id = this._pageNum * PAGESIZE + 0;
					break;
				case "smallPaper1":
					this._id = this._pageNum * PAGESIZE + 1;
					break;
				case "smallPaper2":
					this._id = this._pageNum * PAGESIZE + 2;
					break;
				case "smallPaper3":
					this._id = this._pageNum * PAGESIZE + 3;
					break;
            }
			selectPageById();
            freshPage();
        }

		private function initSmallPaperList():void
		{
			for(var index:int = 0;index < PAGEMAX;index++)
			{
				var smallPaper:SmallPaper = new SmallPaper(index);
				smallPaper.x = INITX + GAP * (index % PAGESIZE);
				smallPaper.y = INITY;
				this.smallPaperList.push(smallPaper);
			}
		}
		/**
		 * 根据_pageNum刷新页面
		 * **/
		private function freshPage():void
		{
			clearContainer();
			for(var index:int = 0;index < PAGESIZE;index++)
			{
				var viewIndex:int = this._pageNum * PAGESIZE + index;
				if(viewIndex >= this.smallPaperList.length)
				{
					break;	
				}
				var view:SmallPaper = this.smallPaperList[viewIndex] as SmallPaper;
				view.name = "smallPaper" + index;
				_container.addChild(view);
			}
			var txtPage:TextField = this._barView.getChildByName("txtpage") as TextField;
			txtPage.text = (this._pageNum+1) + "/" + this._totalPage;
			freshButton();
			freshSelectPageFlag();
		}
		private function freshButton():void
		{
			var buttonNext:SimpleButton = this._barView.getChildByName("btnNext") as SimpleButton;
			var buttonPrev:SimpleButton = this._barView.getChildByName("btnPrev") as SimpleButton;
			buttonNext.mouseEnabled = this._pageNum < this._totalPage - 1;
			buttonPrev.mouseEnabled = this._pageNum > 0;
		}
		private function clearContainer():void
		{
			var numChildren:int = this._container.numChildren;
			for(var index:int = numChildren - 1;index >= 0;index--)
			{
				this._container.removeChildAt(index);
			}
		}
		/**
		 * 选择某一个小图，发送事件通知ViewController加载大图
		 * */
		private function selectPageById():void
		{
            /*************************************************************************
			**任务2：
			***通过LoadPageEventDispatcher 发送事件 LoadPageEvent.LOAD_PAGE 通知ViewController加载大图
        *************************************************************************/
			LoadPageEventDispatcher.getInstance().dispatchEvent(new LoadPageEvent(LoadPageEvent.LOAD_PAGE, this._id));
            freshSelectPageFlag();
			
		}
        private function sendMessage(evt:LoadPageEvent):void{
            //var myViewController:ViewController = new ViewController();
        }
		private function freshSelectPageFlag():void
		{
			for(var index:int = 0;index < PAGESIZE;index++)
			{
				var child:DisplayObject = this._barView.getChildByName("paper" + index);
				var isSameLocation:Boolean = index == this._id % PAGESIZE;
				var isSamePage:Boolean = int(this._id / PAGESIZE) == this._pageNum;
				child.visible = isSameLocation && isSamePage;
			}
		}
	}
}