﻿package com.AshishKumar.tools.lassoTool
		
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
		}