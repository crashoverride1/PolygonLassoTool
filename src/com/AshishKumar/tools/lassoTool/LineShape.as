package com.AshishKumar.tools.lassoTool
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class LineShape extends Sprite
	{
		
		private var _control:Point;
		private var _midPoint:Point;
		private var _initPoint:Point;
		private var _finalPoint:Point;
		
		public function LineShape()
		{
			super();
			_control = new Point();
			_midPoint = new Point();
			
			_initPoint = new Point();
			_finalPoint = new Point();
		}
		
		public function set midPoint(point:Point):void
		{
			_midPoint = point;
		}
		
		public function get midPoint():Point
		{
			return _midPoint;
		}
		
		public function get control():Point
		{
			return _control;
		}
		
		public function set control(point:Point):void
		{
			_control = point;
		}
		
		public function set initPoint(point:Point):void
		{
			_initPoint = point;
		}
		
		public function get initPoint():Point
		{
			return _initPoint;
		}
		
		public function set finalPoint(point:Point):void
		{
			_finalPoint = point;
		}
		
		public function get finalPoint():Point
		{
			return _finalPoint;
		}
	}
}