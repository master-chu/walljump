package  {
  import flash.display.MovieClip;
  public class Block extends MovieClip{
    
    public function Block() {
      this.graphics.beginFill(0, 1);
      this.graphics.drawRect(x - 25, y - 25, 50, 50);
      this.graphics.endFill();
    }
    // obj: object colliding into the block
    // place: index of the array...
    public function checkObj(obj:MovieClip, place:int):void {
      if (obj.x + obj.width / 2 > x - width / 2 && obj.x < x - width / 2 + 7 && Math.abs(obj.y - y) < height/2) {
        // put x of obj at edge of block accounting for its width
        obj.x = x - width / 2 - obj.width / 2;
      }
      if (obj.x - obj.width / 2 < x + width / 2 && obj.x > x + width / 2 - 7 && Math.abs(obj.y - y) < height / 2) {
        obj.x = x + width / 2 + obj.width / 2;
      }
      if (Math.abs(obj.x - x) < width / 2 + obj.width / 2 && obj.y < y -height / 2 && obj.floor > y - height / 2 && obj.onBlock != place) {
        obj.floor = y - height / 2;
        obj.onBlock = place;
      }
      if (Math.abs(obj.x - x) >= width / 2 + obj.width / 2 && obj.onBlock == place) {        
        obj.onBlock = -1;
        obj.floor = 450;
      }
      if (obj.y - obj.height / 2 < y + height / 2 && obj.y > y && Math.abs(obj.x - x) < width / 2 + obj.width / 2) {
        obj.y = y + height / 2 + obj.height / 2;
      }
    }
    
  }

}