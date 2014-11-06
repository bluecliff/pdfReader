package viewer
{
	import mx.containers.VBox;
	import mx.controls.Button;
	import mx.controls.Label;
	import mx.controls.TextArea;
	import mx.containers.Panel;

	public class CommentView extends Panel
	{
		//this.layout="vertical";
		//private var comment_list:XMLList=new XMLList();
		//private var title:String;
		//private var comment:String;
		public function CommentView(comment_list:XML,host_url:String)
		{
			this.title="123";
			this.layout="vertical";
			this.width=600;
			this.height=400;
			var btn:Button=new Button();
			btn.label=comment_list.comment[0].commentId.toString();
			this.addChild(btn);
			for(var i:int=0;i<comment_list.comment.length();i++)
			{
				//var comment_title:Label=new Label();
				//comment_title.text=comment_list.comment[i].commentTitle;
				//this.addChild(comment_title);
				//var comment_content:TextArea=new TextArea();
				//comment_content.text=comment_list.comment[i].commentContent;
				//this.addChild(comment_content);
					var comment_box:Button=new Button();
					comment_box.label=comment_list.comment[i].commentTitle;
					/*title=comment_list.comment[i].commentTitle;
					var comment_box:commentBox=new commentBox();
					comment_box.commentId=comment_list.comment[i].commentId;
					comment_box.commentTitle.text=comment_list.comment[i].commentTitle;
					comment_box.commentContent.text=comment_list.comment[i].commentContent;
					comment_box.delete_url=host_url+"/Timeebo/removeBookComment.php";
					*/this.addChild(comment_box);
					
			}
			super();
		}
	}
}