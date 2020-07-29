package {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class LoadPageEventDispatcher extends EventDispatcher
	{
		private static var _instance:LoadPageEventDispatcher = new LoadPageEventDispatcher();
		public function LoadPageEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
		}
		public static function getInstance():LoadPageEventDispatcher
		{
			return _instance;
		}
	}
}