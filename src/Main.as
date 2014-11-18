package {
	import flash.display.Sprite;
	import flash.events.Event;
  import flash.events.KeyboardEvent;

	public class Main extends Sprite {
		
    private var player:Player = new Player();
    private var block:Block = new Block();
    
		public function Main():void {
      player.x = 300;
      player.y = 300;
      addChild(player);
      block.x = 300;
      block.y = 375;
      addChild(block);
      stage.addEventListener(Event.ENTER_FRAME, step);
      stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
      stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		}
    
    // runs on each frame increment
    public function step(e:Event):void {
      player.step();
      block.checkObj(player, 0);
    }
    
    public function keyDown(e:KeyboardEvent):void {
      handleKeyPress(e, true);
    }
    
    public function keyUp(e:KeyboardEvent):void {
      handleKeyPress(e, false);
    }
    
    public function handleKeyPress(e:KeyboardEvent, isPressed:Boolean):void {
      switch (e.keyCode) {        
        // left / a
        case 37:
        case 65:
          player.pressingLeft = isPressed;
          break;
          
        // right / d
        case 39:
        case 68:
          player.pressingRight = isPressed;
          break;
          
        // up / w
        case 38:
        case 87:
          if(isPressed){
            player.jump();
          }
          break;
          
        // down        
        default: break;
      } 
    }

	}
	
}