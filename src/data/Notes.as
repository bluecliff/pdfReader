package data
{
	import events.LoadedEvent;
	import events.PageChangeEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.net.*;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
	
	[Bindable]
	public class Notes extends EventDispatcher
	{
		public function Notes()
		{
		
			this.addEventListener(PageChangeEvent.PageChange,onPageChange);
		}
		public var shapes:XML;
		public var page:int;
		public var book_id:int;
		public var user_id:int;
		public var host_url:String;
		public function add_line(_thick:int,_color:uint,p1:Point,p2:Point):void
		{
			var newMark:XML=new XML();
			newMark=<mark style="line" thick={_thick} color={_color} fillColor={_color}>
							  <x1>{p1.x}</x1>
	  						  <y1>{p1.y}</y1>
	  						  <x2>{p2.x}</x2>
	  						  <y2>{p2.y}</y2>
							</mark>
			shapes.prependChild(newMark);
			var add_mark_service:HTTPService=new HTTPService();
			add_mark_service.url=host_url+"/addImageTag.php";
			add_mark_service.method="Get";
			add_mark_service.resultFormat="e4x";
			add_mark_service.showBusyCursor=true;
			//add_mark_service.addEventListener(ResultEvent.RESULT,add);
			add_mark_service.addEventListener(FaultEvent.FAULT,erro);
			var add_args:Object=new Object();
			add_args["bookId"]=book_id;
			add_args["userId"]=user_id;
			add_args["pageNum"]=this.page;
			add_args["markInfo"]=newMark;
			add_mark_service.send(add_args);
			
		}
		public function add_rect(_fillcolor:uint,p1:Point,p2:Point):void
		{
			var newMark:XML=new XML()
			newMark=<mark style="rect" thick="0" color="000000" fillColor={_fillcolor}>
							  <x1>{p1.x}</x1>
	  						  <y1>{p1.y}</y1>
	  						  <x2>{p2.x}</x2>
	  						  <y2>{p2.y}</y2>
							</mark>
			shapes.prependChild(newMark);
			var add_mark_service:HTTPService=new HTTPService();
			add_mark_service.url=host_url+"/addImageTag.php";
			add_mark_service.method="Get";
			add_mark_service.resultFormat="e4x";
			add_mark_service.showBusyCursor=true;
			//add_mark_service.addEventListener(ResultEvent.RESULT,add);
			add_mark_service.addEventListener(FaultEvent.FAULT,erro);
			var add_args:Object=new Object();
			add_args["bookId"]=book_id;
			add_args["userId"]=user_id;
			add_args["pageNum"]=this.page;
			add_args["markInfo"]=newMark;
			add_mark_service.send(add_args);
		}
		/*private function add(e:ResultEvent):void
		{
			Alert.show("ok"+e.result.toString(),"");
		}
		*/
		private function erro(e:FaultEvent):void
		{
			Alert.show("erro"+e.message,"");
		}
		public function delete_mark():void
		{
			delete shapes.mark[0];
			var rm_mark_service:HTTPService=new HTTPService();
			rm_mark_service.url=host_url+"/removeBookImageTag.php";
			rm_mark_service.method="Get";
			rm_mark_service.resultFormat="e4x";
			rm_mark_service.showBusyCursor=true;
			//rm_mark_service.addEventListener(ResultEvent.RESULT,add);
			rm_mark_service.addEventListener(FaultEvent.FAULT,erro);
			var rm_args:Object=new Object();
			rm_args["bookId"]=book_id;
			rm_args["userId"]=user_id;
			rm_args["pageNum"]=this.page;
			rm_mark_service.send(rm_args);
		}
		
		public function onPageChange(event:PageChangeEvent):void
		{
		
			shapes=new XML();
			//shapes=<page></page>
			page=event.page;
			
			
			var mark_service:HTTPService=new HTTPService();
			mark_service.url=host_url+"/getImageTag.php";
			mark_service.method="Get";
			mark_service.resultFormat="e4x";
			mark_service.showBusyCursor=true;
			mark_service.addEventListener(ResultEvent.RESULT,xmlLoaded);
			mark_service.addEventListener(FaultEvent.FAULT,xmlErro);
			var args:Object=new Object();
			args["bookId"]=book_id;
			args["userId"]=user_id;
			args["pageNum"]=this.page;
			mark_service.send(args);
		}
	
		
		//public var marks:XML=new XML();
		private function xmlLoaded(e:ResultEvent):void
		{
			shapes=XML(e.result);
			this.dispatchEvent(new LoadedEvent(LoadedEvent.Loaded,page));
		}
		private function xmlErro(e:Event):void
		{	shapes=XML("<page></page>");
			this.dispatchEvent(new LoadedEvent(LoadedEvent.Loaded,page));
		}
	}
}