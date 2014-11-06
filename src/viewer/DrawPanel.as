package viewer
{
	import data.Notes;
	
	import events.SizeChangeEvent;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.*;
	
	import mx.controls.Image;

	[Bindable]
	public class DrawPanel extends Image
	{
		public var notes:Notes;
		public var lineThick:int=2;
		public var lineColor:uint=0xff0000;
		public var line_rect:Boolean=true;
		private var first:Point=new Point();
		private var second:Point=new Point();
		private var line:Shape;
		private var isDraw:Boolean=false;
		//public var index:int=0;
		public function DrawPanel(_page:int,_book_id:int,_user_id:int,_host_url:String)
		{
			super();
			notes=new Notes();
			notes.book_id=_book_id;
			notes.host_url=_host_url;
			notes.user_id=_user_id;
			notes.page=_page;
			//doDraw();
			//notes.add_line(2,0xffff00,new Point(1,34),new Point(23,67));
			
			//this.addEventListener(,onCompleted);
			this.addEventListener(Event.COMPLETE,onCompleted);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
   			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
   			this.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
   			this.addEventListener(MouseEvent.ROLL_OUT,onMouseOut);
		}
		
		
		private function onCompleted(e:Event):void
		{
			this.doDraw();
			
		}
	
		public function doDraw():void
		{
			var index:int=this.notes.shapes.child("mark").length();
			for(var i:int=index-1;i>=0;i--)
			{
				if(notes.shapes.mark[i].@style=="line")
				{
					line=new Shape();
					this.addChild(line);
   					first.x=notes.shapes.mark[i].x1;
        			first.y=notes.shapes.mark[i].y1;
        			second.x=notes.shapes.mark[i].x2;
        			second.y=notes.shapes.mark[i].y2;
        			line.graphics.lineStyle(this.notes.shapes.mark[i].@thick,this.notes.shapes.mark[i].@color,0.5,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.BEVEL,3); 
   					line.graphics.moveTo(first.x,first.y);
  					line.graphics.lineTo(second.x,second.y);
				}
				else
				{
					line=new Shape();
					this.addChild(line);
					first.x=notes.shapes.mark[i].x1;
        			first.y=notes.shapes.mark[i].y1;
        			second.x=notes.shapes.mark[i].x2;
        			second.y=notes.shapes.mark[i].y2;
					var preX:Number  = Math.min(first.x, second.x);
   					var preY:Number  = Math.min(first.y, second.y);
   					var pWidth:Number = Math.abs(first.x - second.x);
   					var pHeight:Number = Math.abs(first.y - second.y);
   					line.graphics.beginFill(notes.shapes.mark[i].@fillColor,0.4);
   					line.graphics.drawRect(preX,preY,pWidth,pHeight);
   					line.graphics.endFill();
				}
			}
		}
		private function onMouseDown(event:MouseEvent):void 
		{
   			line=new Shape();
   			isDraw=true;
   			this.addChild(line);

   			first.x=this.mouseX;
        	first.y=mouseY;
        	second.x=mouseX;
        	second.y=mouseY; 
			//this.graphics.moveTo(mouseX, mouseY);//定位当前鼠标坐标
   			//this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
 		}
 		internal function onMouseOut(e:MouseEvent):void
   		{
   			
   			//line.graphics.clear();
   			//isDraw=false;
   			if(isDraw)
   			{
   				isDraw=false;
   				if(line_rect)
   				{
   					notes.add_line(lineThick,lineColor,first,second);
   					//isDraw=false;
   				}
   				else
   				{
   					notes.add_rect(lineColor,first,second);
   					//isDraw=false;
   				}
   			}
   		}
 		private function onMouseUp(event:MouseEvent):void 
 		{
  	 		//this.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
  	 		if(!isDraw)
  	 		{
  	 			return ;
  	 		}
  	 		isDraw=false;
   			line.graphics.clear();//清除掉了
   			//line.graphics.lineStyle(lineThick,lineColor,0.5,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.BEVEL,3); 
   			second.x =mouseX;
      		second.y = mouseY;
      		
      		if(((second.x-first.x)*(second.x-first.x)+(second.y-first.y)*(second.y-first.y))<20)
      		{
      			return;
      		}
      		
   			if(line_rect)
   			{
   				
   				line.graphics.lineStyle(lineThick,lineColor,0.5,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.BEVEL,3); 
   				line.graphics.moveTo(first.x,first.y);
  				line.graphics.lineTo(second.x,second.y);
  				notes.add_line(lineThick,lineColor,first,second);
   			}
   			else
   			{
   				var preX:Number  = Math.min(first.x, second.x);
   				var preY:Number  = Math.min(first.y, second.y);
   				var pWidth:Number = Math.abs(first.x - second.x);
   				var pHeight:Number = Math.abs(first.y - second.y);
   				line.graphics.beginFill(lineColor,0.4);
   				line.graphics.drawRect(preX,preY,pWidth,pHeight);
   				line.graphics.endFill();
   				notes.add_rect(lineColor,first,second);
   			}
   			//line=null;
   		}
   		private function onMouseMove(event:MouseEvent):void
   		{
   			if(isDraw)
   			{
   				line.graphics.clear();
   				
   				second.x =mouseX;
      			second.y = mouseY;
      			if(line_rect)
      			{
      				line.graphics.lineStyle(lineThick,lineColor,0.5,false,LineScaleMode.NORMAL,CapsStyle.ROUND,JointStyle.BEVEL,3);
      				line.graphics.moveTo(first.x,first.y);
   					line.graphics.lineTo(second.x,second.y);
      			}
   				else
   				{
   					var preX:Number  = Math.min(first.x, second.x);
   					var preY:Number  = Math.min(first.y, second.y);
   					var pWidth:Number = Math.abs(first.x - second.x);
   					var pHeight:Number = Math.abs(first.y - second.y);
   					line.graphics.beginFill(lineColor,0.4);
   					line.graphics.drawRect(preX,preY,pWidth,pHeight);
   					line.graphics.endFill();
   				}
   			}
   		}
   		public function onDelete():void
   		{
   			var index:int=this.notes.shapes.child("mark").length();
   			if(index>0)
   			{
   				this.removeChildAt(index);
   				notes.delete_mark();
   			}
   		}
	}
}