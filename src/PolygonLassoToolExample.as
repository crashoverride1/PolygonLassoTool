package
{
	import com.AshishKumar.tools.lassoTool.PolygonLassoTool;
	
	import flash.display.Sprite;
	
	public class PolygonLassoToolExample extends Sprite
	{
		private var lassoTool:PolygonLassoTool;
		
		public function PolygonLassoToolExample()
		{
		     lassoTool = new PolygonLassoTool();
			 stage.addChild(lassoTool);
		}
	}
}