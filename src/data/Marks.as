package data
{
	import flash.geom.Point;
	
	public class Marks
	{
		public function Marks()
		{
			shapes=new XML();
			shapes=<page></page>
		}
		public var shapes:XML;
		public function add_line(_thick:int,_color:uint,p1:Point,p2:Point):void
		{
			var newMark:XML=<mark style="line" thick={_thick} color={_color} fillcolor={_color}>
							  <x1>{p1.x}</x1>
	  						  <y1>{p1.y}</y1>
	  						  <x2>{p2.x}</x2>
	  						  <y2>{p2.y}</y2>
							</mark>
			shapes.appendChild(newMark);
		}
		public function add_rect(_fillcolor:uint,p1:Point,p2:Point):void
		{
			var newMark1:XML=<mark style="rect" thick="0" color="0x000000" fillcolor={_fillcolor}>
							  <x1>{p1.x}</x1>
	  						  <y1>{p1.y}</y1>
	  						  <x2>{p2.x}</x2>
	  						  <y2>{p2.y}</y2>
							</mark>
			shapes.appendChild(newMark1);
		}
		public function delete_mark():void
		{
			//delete shapes.mark[0];
		}
	}
}