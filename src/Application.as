package {
  import flash.display.Sprite;
  
  import flash.text.TextField;
  import flash.events.Event;
  import flash.utils.getTimer;

  public class Application extends Sprite {
  	
  	private var _debugText:TextField;
  	private var _lastTime:int;
  	
  	public function Application()
  	{
  		super();
  		
  		_debugText = new TextField();
  		this.addChild(_debugText);
  		this.addEventListener(Event.ENTER_FRAME, eachFrame);
  	}

  	private function eachFrame(event:Event):void {
  	  var currentTime:int = getTimer();
  	  var framesPerSecond:int = 1000 / (currentTime - _lastTime);
  	  _lastTime = currentTime;
  	  
  	  _debugText.text = "FPS: " + String(framesPerSecond);
  	}
  }
}