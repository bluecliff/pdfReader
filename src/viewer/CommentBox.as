package viewer
{
	import mx.containers.Canvas;

	public class CommentBox extends Canvas
	{
		private var commentTitle:String;
		private var commentContent:String;
		private var commentId:int;
		public function CommentBox(title:String,content:String,id:int)
		{
			this.commentId=id;
			this.commentContent=content;
			this.commentTitle=title;
			super();
		}
		
	}
}