package events
{
	import flash.events.Event;
	
	public class PageChangeEvent extends Event
	{
		public static const PageChange:String="pagechange";
		public var page:Number;
		public function PageChangeEvent(type:String,_page:Number,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.page=_page;
			super(type, bubbles, cancelable);
		}
		public override function clone():Event
		{
			return new PageChangeEvent(PageChange,page);
		}
	}
}