package com.AshishKumar.tools.lassoTool
{
	import flash.display.Sprite;

	public class MidPointShape extends Sprite
	{
		private var _id:Number = NaN;
		
		public function MidPointShape(color:uint=0,radius:Number=5,alpha:uint=0)
		{
			super();
			graphics.beginFill(color);
			graphics.drawCircle(0,0,radius);
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