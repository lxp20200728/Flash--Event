package papersviewer
{
	import flash.events.Event;
	
	public class LoadPageEvent extends Event
	{
		public static const LOAD_PAGE:String = "load_page";
		private var _id:int;
		
		public function LoadPageEvent(type:String, id:int,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._id = id;
		}
		public function getId():int
		{
			return this._id;
		}
		public override function clone():Event
		{
			return new LoadPageEvent(type,this._id,bubbles,cancelable);
		}
	}
}