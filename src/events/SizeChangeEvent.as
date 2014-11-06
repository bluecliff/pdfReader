package events
{
	import flash.events.Event;

	public class SizeChangeEvent extends Event
	{
		public static const SizeChange:String="sizeChange";
		public function SizeChangeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}