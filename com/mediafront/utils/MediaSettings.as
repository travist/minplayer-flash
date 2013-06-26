package com.mediafront.utils {
  public class MediaSettings extends Settings {
    public function MediaSettings( settings:Object ) {
      super( settings );
      loadSettings();
    }

    public var file:String="";
    public var image:String="";
    public var mediaPlayer:String="mediaPlayer";
    public var stream:String=null;
    public var autostart:Boolean=false;
    public var autoload:Boolean=true;
  }
}