package
{
	import flash.display.MovieClip;
	
	public class Player extends MovieClip
	{
		public var fallSpeed:int = 0;
    public const fallAcceleration:int = 1;
    public var moveSpeed:int = 0;
    public const moveAcceleration:int = 1;
    public var topMoveSpeed:int = 10;
    public const friction:int = 1;
    public const jumpStrength:int = 15;
    public const wallJumpStrength:int = 7;
    public var allowedJumps:int = 2;
    public var remainingJumps:int = 2;
    public var wallJumpLeeway:int = 30;
    
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
      if (this.isMidAir()) {
        if (this.canWallJumpRight()) {
          this.wallJumpRight();
          this.remainingJumps = this.allowedJumps;
        }
        else if (this.canWallJumpLeft()) {
          this.wallJumpLeft();
          this.remainingJumps = this.allowedJumps;
        }  
      }
      
      if(this.hasRemainingJumps()){
        this.fallSpeed = 0 - this.jumpStrength;
        this.remainingJumps--;
      }

    }
    public function wallJumpRight():void {
      this.moveSpeed += this.wallJumpStrength;
    }
    public function wallJumpLeft():void {
      this.moveSpeed -= this.wallJumpStrength;
      trace("wall jump left");
    }
    
    public function moveLeft():void {
      var newSpeed:int = this.moveSpeed - moveAcceleration;
      if (Math.abs(newSpeed) > this.topMoveSpeed) {
        newSpeed = 0 - this.topMoveSpeed;
      }
      this.moveSpeed = newSpeed;
    }
    public function moveRight():void {
      var newSpeed:int = this.moveSpeed + moveAcceleration;
      if (Math.abs(newSpeed) > this.topMoveSpeed) {
        newSpeed = this.topMoveSpeed;
      }
      this.moveSpeed = newSpeed;
    }
    public function move():void {
      this.x += this.moveSpeed;
    }
    public function enactFriction():void {
      var newSpeed:int = this.moveSpeed;
      if (this.isMovingLeft()) {
        newSpeed += this.friction;
      }
      else if (this.isMovingRight()) {
        newSpeed -= this.friction;
      }
      
      if (Math.abs(newSpeed) > 0) {
        this.moveSpeed = newSpeed;
      } else {
        this.moveSpeed = 0;
      }
    }
    /* State */
    public function isMidAir():Boolean {
      return this.y + this.height / 2 < floor;
    }
    public function isFalling():Boolean {
      return this.isMidAir() && this.fallSpeed > 0;
    }
    public function isMovingRight():Boolean {
      return this.moveSpeed > 0;
    }
    public function isMovingLeft():Boolean {
      return this.moveSpeed < 0;
    }
    public function isTouchingLeftWall():Boolean {
      var leftEdgeX:int = this.x - this.width / 2;
      return leftEdgeX <= 0;
    }
    public function isTouchingRightWall():Boolean {
      var rightEdgeX:int = this.x + this.width / 2;
      return rightEdgeX >= stageWidth;
    }

    // lots of recomputation
    public function canWallJumpLeft():Boolean {
      var rightEdgeX:int = this.x + this.width / 2;
      var distanceToRightWall:int = this.stageWidth - rightEdgeX;
      return this.isTouchingRightWall()
              || (this.isMovingLeft() && distanceToRightWall <= this.wallJumpLeeway);
    }
    public function canWallJumpRight():Boolean {
      var leftEdgeX:int = this.x - this.width / 2;
      var distanceToLeftWall:int = leftEdgeX;
      return this.isTouchingLeftWall()
              || (this.isMovingRight() && distanceToLeftWall <= this.wallJumpLeeway);
    }
    public function hasRemainingJumps():Boolean {
      return this.remainingJumps > 0;
    }
    
    public function step():void {
      this.move();
      
      this.y += fallSpeed;
      if (this.isMidAir()) {
        fallSpeed += fallAcceleration;
      }
      else {
        fallSpeed = 0;
        this.y = floor - this.height / 2;
        this.remainingJumps = this.allowedJumps;
      }
      
      if (this.isTouchingLeftWall()) {
        this.x = this.width / 2;
        this.moveSpeed = 0;
      }
      if (this.isTouchingRightWall()) {
        this.x = 800 - this.width / 2;
        this.moveSpeed = 0;
      }
    }
	
	}

}