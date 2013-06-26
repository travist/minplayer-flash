package com.mediafront.utils {
  public class ControlSettings extends Settings {
    public function ControlSettings( settings:Object ) {
      super( settings );
      loadSettings();
    }

    public var controlBar:String="controlBar";
  }
}