package com.AshishKumar.tools.lassoTool
{
	import flash.display.Sprite;
	
	public class PointShape extends Sprite
	{
		private var _id:Number = NaN;
		
		public function PointShape(color:uint=0,width:Number=7,height:Number=7,alpha:uint=1)
		{
			super();
	        graphics.beginFill(color);
			graphics.drawRect(-width/2,-height/2,width,height);
			graphics.endFill();
		}
		
		public function set id(value:Number):void
		{
			_id = value;
		}
		
		public function get id():Number
		{
			return _id;
		}
	}
}