package
{
	import flash.display.MovieClip;
	
	public class Player extends MovieClip
	{
		public var fallSpeed:int = 0;
    public var fallAcceleration:int = 1;
    public var moveSpeed:int = 5;
    public var floor:int = 450;
    public var stageWidth:int = 800;
    public var onBlock:int = -1;
    
		public function Player()
		{
			this.graphics.beginFill(0, 1);
			this.graphics.drawCircle(this.x, this.y, 25);
			this.graphics.endFill();
		}
    
    /* Movement */
    public function jump():void {
      this.fallSpeed = -15;
    }
    public function moveLeft():void {
      this.x -= moveSpeed;
    }
    public function moveRight():void {
      this.x += moveSpeed;
    }
    
    /* State */
    public function isMidAir():Boolean {
      return this.y + this.height / 2 < floor;
    }
    public function isFalling():Boolean {
      return this.isMidAir() && this.fallSpeed > 0;
    }
    public function isTouchingLeftWall():Boolean {
      return this.x - this.width / 2 < 0;
    }
    public function isTouchingRightWall():Boolean {
      return this.x + this.width / 2 > stageWidth;
    }
    
    public function step():void {
      this.y += fallSpeed;
      if (this.isMidAir()) {
        fallSpeed += fallAcceleration;
      }
      else {
        fallSpeed = 0;
        this.y = floor - this.height / 2;
      }
      
      if (this.isTouchingLeftWall()) {
        this.x = this.width / 2;
      }
      if (this.isTouchingRightWall()) {
        this.x = 800 - this.width / 2;
      }
    }
	
	}

}