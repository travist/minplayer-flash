package com.mediafront.display.media.controls {
  import com.mediafront.plugin.SkinablePlugin;
  import com.mediafront.display.media.MediaEvent;
  import com.mediafront.display.Image;
  import com.mediafront.plugin.PluginEvent;
  import com.mediafront.utils.Settings;
  import com.mediafront.utils.PlayLoaderSettings;

  import flash.display.*;
  import flash.text.TextField;
  import flash.events.*;

  public class PlayLoader extends SkinablePlugin {
    public override function loadSettings( _settings:Object ):void {
      super.loadSettings( new PlayLoaderSettings( _settings ) );
      super.loadSkin( settings.playLoader );
    }

    public override function initialize( comps:Object ):void {
      super.initialize( comps );
      components.mediaPlayer.addEventListener( MediaEvent.PLAYING, onMediaEvent );
      components.mediaPlayer.addEventListener( MediaEvent.PAUSED, onMediaEvent );
      components.mediaPlayer.addEventListener( MediaEvent.BUFFERING, onMediaEvent );
    }

    public override function setSkin( _skin:MovieClip ):void {
      playButton=_skin.playButton;
      if (playButton) {
        playButton.buttonMode=true;
        playButton.mouseChildren=false;
        playButton.addEventListener( MouseEvent.CLICK, onPlay );
      }

      loader=_skin.loader;
      setPlayLoadState( true, true, false );
      super.setSkin( _skin );
    }

    public function onPlay( event:MouseEvent ) {
      onMediaEvent( new MediaEvent( MediaEvent.PLAYING ) );
      components.mediaPlayer.playMedia();
    }

    public function onMediaEvent( event:* ) {
      if (skin) {
        switch ( event.type ) {
          case MediaEvent.BUFFERING :
            setPlayLoadState( true, true, false );
            break;
          case MediaEvent.PLAYING :
            setPlayLoadState( false, false, false );
            break;
          case MediaEvent.PAUSED :
            setPlayLoadState( true, false, true );
            break;
        }
      }
    }

    public function setPlayLoadState( showSkin:Boolean, showLoader:Boolean, showPlay:Boolean ) {
      if (skin) {
        skin.visible=showSkin;
      }

      if (loader) {
        loader.visible=showLoader;
      }

      if (playButton) {
        playButton.visible=showPlay;
      }
    }

    public var playButton:MovieClip;
    public var loader:MovieClip;
  }
}