package com.AshishKumar.tools.lassoTool{	import flash.display.Sprite;		public class IrregularShape extends Sprite	{		private var _lines:Array;		private var _points:Array;		private var _midPoints:Array;				private var _fillArea:FillArea;				public function IrregularShape()		{			 super();						_lines = new Array();			_points = new Array();			_midPoints = new Array();		}				public function addLine(line:LineShape):void		{			_lines.push(line);		    super.addChild(line);			line.mouseEnabled = false;		}				public function get lines():Array		{			return _lines;		}				public function addPoint(point:PointShape):void		{			_points.push(point);			super.addChild(point);			_points[_points.length-1].id = _points.length-1;		}				public function get points():Array		{			return _points;		}				public function addMidPoint(midPoint:MidPointShape):void		{			_midPoints.push(midPoint);			super.addChild(midPoint);			_midPoints[_midPoints.length-1].id = _midPoints.length-1;		}				public function get midPoints():Array		{			return _midPoints;		}				public function set fillArea(area:FillArea):void		{			_fillArea = area;			addChildAt(_fillArea,0);		}				public function get fillArea():FillArea		{			return _fillArea;		}				public function removeLines():void		{			for(var i:int=0;i<_lines.length;i++)			{				removeChild(_lines[i]);			}						_lines = [];		}				public function removePoints():void		{			for(var i:int=0;i<_points.length;i++)			{				removeChild(_points[i]);			}						_points = [];		}				public function removeMidPoints():void		{			for(var i:int=0;i<_midPoints.length;i++)			{				removeChild(_midPoints[i]);			}						_midPoints = [];		}
		
		public function showPoints():void
		{
			for(var i:int=0;i<_lines.length;i++)
			_lines[i].visible = true;
			
			for(i = 0;i<_points.length;i++)
			{
				_points[i].visible = true;
				_midPoints[i].visible = true;
			}
		}
		
		public function hidePoints():void
		{
			for(var i:int=0;i<_lines.length;i++)
			_lines[i].visible = false;
			
			for(i = 0;i<_points.length;i++)
			{
				_points[i].visible = false;
				_midPoints[i].visible = false;
			}
		}	}}