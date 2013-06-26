package com.mediafront.utils {
  public class PlayLoaderSettings extends Settings {
    public function PlayLoaderSettings( settings:Object ) {
      super( settings );
      loadSettings();
    }

    public var playLoader:String="playLoader";
  }
}