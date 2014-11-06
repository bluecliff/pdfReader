package events
{
	import flash.events.Event;

	public class MarkChangeEvent extends Event
	{
		public static const MarkChange:String="markchange";
		public function MarkChangeEvent(type:String,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		public override function clone():Event
		{
			return new MarkChangeEvent(MarkChange);
		}
	}
}