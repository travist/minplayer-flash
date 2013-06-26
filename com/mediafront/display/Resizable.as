package com.mediafront.display {
  import flash.display.DisplayObjectContainer;

  public class Resizable extends DisplayObjectContainer {
    public var resizeX:Boolean=false;
    public var resizeY:Boolean=false;
    public var resizeW:Boolean=false;
    public var resizeH:Boolean=false;

    public function onResize( deltaX:Number, deltaY:Number ) {
      if (resizeX) {
        x=x+deltaX;
      }
      if (resizeY) {
        y=y+deltaY;
      }
      if (resizeW) {
        width=width+deltaX;
      }
      if (resizeH) {
        height=height+deltaY;
      }

      var i=numChildren;
      while ( i-- ) {
        getChildAt(i) as Resizable.onResize( deltaX, deltaY );
      }
    }
  }
}