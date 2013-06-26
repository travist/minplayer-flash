package com.mediafront.display.media {
  import flash.events.*;

  public class MediaEvent extends Event {
    public static const CONNECTED:String="mediaConnected";
    public static const BUFFERING:String="mediaBuffering";
    public static const PAUSED:String="mediaPaused";
    public static const PLAYING:String="mediaPlaying";
    public static const STOPPED:String="mediaStopped";
    public static const COMPLETE:String="mediaComplete";
    public static const META:String="mediaMeta";

    public function MediaEvent( type:String, a:Object = null ) {
      super( type, true );
      args=a;
    }

    override public function toString():String {
      return formatToString( "MediaEvent", "type", "eventPhase" );
    }

    override public function clone():Event {
      return new MediaEvent( type, args );
    }

    public var args:Object;
  }
}