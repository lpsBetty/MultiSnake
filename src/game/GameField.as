package game
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.controls.Image;
	import mx.core.FlexGlobals;
	
	import spark.primitives.BitmapImage;
	
	public class GameField extends Sprite
	{
		[Embed(source="../assets/background.jpg")]
		private var background:Class;
		private var backgroundImage:Bitmap = new background;
		private var mywidth:int = FlexGlobals.topLevelApplication.stage.width;
		private var myheight:int = FlexGlobals.topLevelApplication.stage.height;
		private var snake:Snake;
		private var writingPixels:ByteArray;
		
		public static var GAME_END:String = "GAME_END";
		
		public function GameField()
		{
			// rescale background
			var tmp:BitmapData = new BitmapData(mywidth,myheight);		
			var scaleMatrix:Matrix=new Matrix();
			scaleMatrix.scale(mywidth/backgroundImage.width,myheight/backgroundImage.height);
			tmp.draw(backgroundImage.bitmapData,scaleMatrix);
			backgroundImage.bitmapData = tmp;
			
			var bmp:BitmapData = new BitmapData(10,10,false,0xffffff);
			writingPixels = bmp.getPixels(new Rectangle(0,0,10,10));
			addChild(backgroundImage);
			snake = new Snake(1,4,300,300,0x00ff00,false);
			addChild(snake);
			
			addEventListener(Event.ADDED_TO_STAGE, function():void {
				stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			});
		}
		
		public function keyDownHandler(e:KeyboardEvent):void
		{
			if(e.keyCode == 27) //ESC Key
			{
				FlexGlobals.topLevelApplication.endGame();
			}
		}
		
		public function end():void
		{
			snake.update(dt);
		}
		
		public function update(dt:Number):void
		{
			//TODO replace mouse erasing with snake eating the background muhahahah
			var rec:Rectangle = new Rectangle(mouseX,mouseY,10,10);
			writingPixels.position = 0;
			backgroundImage.bitmapData.setPixels(rec,writingPixels);
		}
		
		public function draw():void
		{
		}
	}
}