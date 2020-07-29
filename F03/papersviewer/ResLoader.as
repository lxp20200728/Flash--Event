package papersviewer
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class ResLoader
	{
		private var _loader:Loader;
		private var _callBack:Function;
		private var _clsName:String;
		private var _domain:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
		public function ResLoader()
		{
			
		}
		public function load(url:String,clsName:String,callBack:Function):void
		{
			if(this._loader != null)
			{
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
				_clsName = null;
				_callBack = null;
			}
			this._loader = new Loader();
			this._callBack = callBack;
			this._clsName = clsName;
			var urlRequest:URLRequest = new URLRequest(url);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			_loader.load(urlRequest,new LoaderContext(false,_domain));
		}
		private function onComplete(evt:Event):void{
			if(_callBack != null){
				var cls:Class = _domain.getDefinition(_clsName) as Class;
				var content:DisplayObject = new cls() as DisplayObject;
				_callBack.apply(null, [content]);
			}
		}
		public function close():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,onComplete);
			_loader = null;
			_callBack = null;
			_domain = null;
		}
	}
}