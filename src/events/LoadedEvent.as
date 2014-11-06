package events
{
	import flash.events.Event;

	public class LoadedEvent extends Event
	{
		public static const Loaded:String="loaded";
		public var page:Number;
		
		public function LoadedEvent(type:String,_page:Number,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			page=_page;
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new LoadedEvent(Loaded,page);
		}
	}
}