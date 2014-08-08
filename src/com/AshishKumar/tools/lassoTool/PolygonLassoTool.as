﻿package com.AshishKumar.tools.lassoTool{		import flash.display.Bitmap;	import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;	import flash.display.Graphics;	import flash.display.MovieClip;	import flash.display.SimpleButton;	import flash.display.Sprite;	import flash.display.Stage;	import flash.events.Event;	import flash.events.KeyboardEvent;	import flash.events.MouseEvent;	import flash.geom.ColorTransform;	import flash.geom.Matrix;	import flash.geom.Point;	import flash.ui.Keyboard;	import flash.ui.Mouse;
		public class PolygonLassoTool extends Sprite	{		private var _color:uint = 0xff0000;			    private var _mouseDown:Boolean;		private var _fillArea:FillArea;		private var _shapeCompleted:Boolean;		private var _startingPoint:PointShape;		private var _parent:DisplayObjectContainer;		private var _irregularShape:IrregularShape;				public function PolygonLassoTool()		{			super();		    this.addEventListener(Event.ADDED_TO_STAGE,start);		}				private function start(event:Event=null):void		{				_parent = parent;						initialize();			_parent.addEventListener(MouseEvent.CLICK,setStart);		}				private function initialize(event:Event=null):void		{			_shapeCompleted = false;						if(_irregularShape!=null)			{				_irregularShape.removeLines();				_irregularShape.removePoints();				_irregularShape.removeMidPoints();				}						_irregularShape = new IrregularShape();			_parent.addChild(_irregularShape);						_fillArea = new FillArea();			_irregularShape.fillArea = _fillArea;						stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);		}				private function setStart(event:MouseEvent):void		{			if(_shapeCompleted && !(event.target is PointShape) && !(event.target is MidPointShape))			initialize();						if(!(event.target is PointShape) && !(event.target is MidPointShape) && !(event.target is SimpleButton))			{			_irregularShape.addLine(new LineShape());						var point:PointShape = new PointShape();			point.x = mouseX;			point.y = mouseY;			_irregularShape.addPoint(point);						setMidPoint();			_parent.addEventListener(Event.ENTER_FRAME,startDraw);			}						 if(event.target == _irregularShape.points[0] && event.target !=null && !_shapeCompleted)			{									 var line:LineShape = _irregularShape.lines[_irregularShape.lines.length-1];					 point = _irregularShape.points[_irregularShape.points.length-1];					 var point2:PointShape = _irregularShape.points[0];				     drawLine(line,point.x,point.y,point2.x,point2.y);					_parent.removeEventListener(Event.ENTER_FRAME,startDraw);					 setMidPoint(true);					 splitLines();				     addListenersToPoints();					_shapeCompleted = true;					 finalize(_color);				}					}				private function addListenersToPoints():void		{			for(var i:int=0;i<_irregularShape.points.length;i++)			{				_irregularShape.points[i].alpha = 1;				_irregularShape.points[i].addEventListener(MouseEvent.MOUSE_DOWN,onPointMouseDown);							_irregularShape.midPoints[i].alpha = 1;				_irregularShape.midPoints[i].addEventListener(MouseEvent.MOUSE_DOWN,onMidPointMouseDown);							}		}				private function setMidPoint(final:Boolean=false):void		{			var _points:Array = _irregularShape.points;					    var midPoint:MidPointShape = new MidPointShape(0x006600,3.5);			if(!final && _irregularShape.points.length>1)			{				midPoint.x = (_points[_points.length-1].x + _points[_points.length-2].x)/2 ;				midPoint.y = (_points[_points.length-1].y + _points[_points.length-2].y)/2 ;				_irregularShape.addMidPoint(midPoint);			}			else if(final)			{				midPoint.x = (_points[_points.length-1].x + _points[0].x)/2 ;				midPoint.y = (_points[_points.length-1].y + _points[0].y)/2 ;				_irregularShape.addMidPoint(midPoint);			}		}				private function startDraw(event:Event):void		{			var line:LineShape = _irregularShape.lines[_irregularShape.lines.length-1];			var point:PointShape = _irregularShape.points[_irregularShape.points.length-1];			drawLine(line,point.x,point.y,mouseX,mouseY);		}				private function drawLine(line:Sprite,ix:Number,iy:Number,fx:Number,fy:Number,cx:Number=0,cy:Number=0):void		{			if(cx == 0) cx = cx = fx;			if(cy == 0) cy = cy = fy;						var _g:Graphics = line.graphics;			_g.clear();			_g.lineStyle(1,0);			_g.moveTo(ix,iy);			_g.curveTo(cx,cy,fx,fy);		}				private function onPointMouseDown(event:MouseEvent):void		{			_mouseDown = true;			var point:PointShape = event.currentTarget as PointShape;			point.startDrag();			point.addEventListener(Event.ENTER_FRAME,updatePoint);			point.addEventListener(MouseEvent.MOUSE_UP,onPointMouseUp);		}				private function onMidPointMouseDown(event:MouseEvent):void		{			_mouseDown = true;			var midpoint:MidPointShape = event.currentTarget as MidPointShape;			midpoint.startDrag();			midpoint.addEventListener(Event.ENTER_FRAME,updateCurve);			midpoint.addEventListener(MouseEvent.MOUSE_UP,onMidPointMouseUp);		}				private function onPointMouseUp(event:MouseEvent):void		{			_mouseDown = false;			var point:PointShape = event.currentTarget as PointShape;			point.stopDrag();			point.removeEventListener(Event.ENTER_FRAME,updatePoint);			point.removeEventListener(MouseEvent.MOUSE_UP,onPointMouseUp);		}				private function onMidPointMouseUp(event:MouseEvent):void		{			_mouseDown = false;			var midpoint:MidPointShape = event.currentTarget as MidPointShape;			midpoint.stopDrag();			midpoint.removeEventListener(Event.ENTER_FRAME,updateCurve);			midpoint.removeEventListener(MouseEvent.MOUSE_UP,onMidPointMouseUp);		}				private function updatePoint(event:Event):void		{			var point:PointShape = event.currentTarget as PointShape;						var line1:LineShape;			var line2:LineShape;						var midPoint1:MidPointShape;			var midPoint2:MidPointShape;						if(point.id == 0)			{				line1 = _irregularShape.lines[0];				line2 = _irregularShape.lines[_irregularShape.lines.length-1];								midPoint1 = _irregularShape.midPoints[0];				midPoint2 = _irregularShape.midPoints[_irregularShape.midPoints.length-1];			}			else			{				line1 = _irregularShape.lines[(point.id * 2)-1];				line2 = _irregularShape.lines[point.id * 2];								midPoint1 = _irregularShape.midPoints[point.id-1];				midPoint2 = _irregularShape.midPoints[point.id];			}									 drawLine(line1,midPoint1.x,midPoint1.y,point.x,point.y,line1.midPoint.x,line1.midPoint.y);			 drawLine(line2,midPoint2.x,midPoint2.y,point.x,point.y,line2.midPoint.x,line2.midPoint.y);			 			 line1.initPoint = line2.initPoint = new Point(point.x,point.y);			 finalize(_color);		}				private function updateCurve(event:Event):void		{			var mpt:MidPointShape = event.currentTarget as MidPointShape;			var line1:LineShape = _irregularShape.lines[(mpt.id * 2)]			var line2:LineShape = _irregularShape.lines[(mpt.id * 2)+1];			var cx1:Number = mouseX-(line1.finalPoint.x-line1.control.x);			var cy1:Number = mouseY+(line1.control.y-line1.finalPoint.y);			var cx2:Number = mouseX-(line2.finalPoint.x-line2.control.x);			var cy2:Number = mouseY+(line2.control.y-line2.finalPoint.y);			drawLine(line1,line1.initPoint.x,line1.initPoint.y,mpt.x,mpt.y,cx1,cy1);			drawLine(line2,line2.initPoint.x,line2.initPoint.y,mpt.x,mpt.y,cx2,cy2);						line1.midPoint = new Point(cx1,cy1);			line2.midPoint = new Point(cx2,cy2);						finalize(_color);		}				private function splitLines():void		{			var lines:Array = _irregularShape.lines;			var points:Array = _irregularShape.points;			var midPoints:Array = _irregularShape.midPoints;						_irregularShape.removeLines();						for(var i:int=0;i<lines.length;i++)			{				var pt1:PointShape = points[i];				var md:MidPointShape = midPoints[i];								if(pt1.id != points.length-1)					var pt2:PointShape = points[i+1];				else				        pt2 = points[0];							var line:LineShape = new LineShape();				line.initPoint = new Point(pt1.x,pt1.y);				line.finalPoint = new Point(md.x,md.y);				line.control = new Point((md.x+pt1.x)/2,(md.y+pt1.y)/2);				line.midPoint = line.control;								_irregularShape.addLine(line);				drawLine(_irregularShape.lines[_irregularShape.lines.length-1],md.x,md.y,pt1.x,pt1.y);												line = new LineShape();				line.initPoint = new Point(pt2.x,pt2.y);				line.finalPoint = new Point(md.x,md.y);				line.control = new Point((md.x+pt2.x)/2,(md.y+pt2.y)/2);				line.midPoint = line.control;									_irregularShape.addLine(line);				drawLine(_irregularShape.lines[_irregularShape.lines.length-1],md.x,md.y,pt2.x,pt2.y);							}						updateIndex();		}				private function updateIndex():void		{			for(var i:int=0;i<_irregularShape.points.length;i++)			{				_irregularShape.setChildIndex(_irregularShape.points[i],_irregularShape.numChildren-(i+1));				_irregularShape.setChildIndex(_irregularShape.midPoints[i],_irregularShape.numChildren-(i+1));			}		}			public function finalize(color:uint):void		{			var mdp:MidPointShape;						var _lines:Array = _irregularShape.lines;			var _mdps:Array = _irregularShape.midPoints;			var _g:Graphics = _fillArea.graphics;			_g.clear();			_g.moveTo(_lines[0].initPoint.x,_lines[0].initPoint.y);						_g.beginFill(color,1);						for(var i:int=0;i<_lines.length;i++)			{				var line:LineShape = _lines[i];				mdp = _mdps[Math.floor(i/2)];				//_g.lineStyle(1,0);								if(i%2==0)				   _g.curveTo(line.midPoint.x,line.midPoint.y,mdp.x,mdp.y);				else					_g.curveTo(line.midPoint.x,line.midPoint.y,line.initPoint.x,line.initPoint.y);							}		   _g.endFill();						stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyDownHandler);		}				public function setColor(color:uint):void		{			_color = color;			if(_irregularShape!=null)			{			_fillArea.fillColor(color,0.6);			_irregularShape.hidePoints();			}		}				private function keyDownHandler(event:KeyboardEvent):void		{			if(event.keyCode == Keyboard.BACKSPACE)				backspace();		}				private function backspace():void		{			if(_irregularShape.points.length == 0)					return;								if(_irregularShape.points.length == 1)				{				_parent.removeEventListener(Event.ENTER_FRAME,startDraw);				initialize();					}				else				{				_irregularShape.removeChild(_irregularShape.lines.pop());				_irregularShape.removeChild(_irregularShape.points.pop());				_irregularShape.removeChild(_irregularShape.midPoints.pop());								var _line:LineShape = _irregularShape.lines[_irregularShape.lines.length-1];				var _point:PointShape = _irregularShape.points[_irregularShape.points.length-1];								drawLine(_line,_point.x,_point.y,mouseX,mouseY);				}		  }		private function removeListeners():void		  {			  for(var i:int=0;i<_irregularShape.points.length;i++)			{				_irregularShape.points[i].removeEventListener(MouseEvent.MOUSE_DOWN,onPointMouseDown);				_irregularShape.midPoints[i].removeEventListener(MouseEvent.MOUSE_DOWN,onMidPointMouseDown);						}		  }		  		  private function child(c:*):Boolean		  {			  for(var i:int=0;i<_parent.numChildren;i++)			  if(_parent.getChildAt(i) == c)			  return true;			  			  return false;		  }	}}