package com.mediafront.display.media.controls {
  import flash.events.*;

  public class ControlEvent extends Event {
    public static const PLAY:String="controlPlay";
    public static const PAUSE:String="controlPause";
    public static const SEEK:String="controlSeek";
    public static const VOLUME:String="controlVolume";
    public static const TOGGLEFULL:String="controlToggleFull";
    public static const MENU:String="controlMenu";
    public static const CONTROL_SET:String="controlSet";
    public static const CONTROL_UPDATE:String="controlUpdate";

    public function ControlEvent( type:String, a:Object = null ) {
      super( type, true );
      args=a;
    }

    override public function toString():String {
      return formatToString( "ControlEvent", "type", "eventPhase" );
    }

    override public function clone():Event {
      return new ControlEvent( type, args );
    }

    public var args:Object;
  }
}