﻿package com.mediafront.display.media {
  import com.mediafront.display.media.MediaPlayer;
  import com.mediafront.display.media.MediaEvent;
  import com.mediafront.display.media.IMedia;
  import com.mediafront.utils.Utils;

  import flash.display.*;
  import flash.events.*;
  import flash.media.*;
  import flash.utils.*;
  import flash.net.*;

  public class AudioPlayer extends Sound implements IMedia {
    public function AudioPlayer( _debug:Boolean, _onMediaEvent:Function ) {
      super();
      debug=_debug;
      onMediaEvent=_onMediaEvent;
      context=new SoundLoaderContext(5*1000,true);
    }

    public function connect( stream:String ):void {
      SoundMixer.stopAll();
      onMediaEvent( MediaEvent.CONNECTED );
    }

    public function loadFile( file:String ):void {
      removeEventListener( Event.SOUND_COMPLETE, audioUpdate );
      removeEventListener( Event.ID3, audioUpdate );
      removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

      addEventListener( Event.SOUND_COMPLETE, audioUpdate );
      addEventListener( Event.ID3, audioUpdate );
      addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

      position=0;
      duration=0;
      vol=0.8;
      loaded=false;
      playing=false;

      Utils.debug( "AudioPlayer: loadFile( " + file + ")", debug );

      var req:URLRequest=new URLRequest(file);
      try {
        super.load(req, context);
        loadInterval=setInterval(loadHandler,200);
      } catch (error:Error) {
        Utils.debug("Unable to load " + file + ": " + error.toString())
      }
    }

    // Make sure we load if they don't have meta data in their audio.
    private function loadHandler() {
      if (bytesLoaded>=bytesTotal&&bytesLoaded>0) {
        onLoaded();
      }
    }

    private function onLoaded():void {
      if (! loaded) {
        loaded=true;
        playMedia();
      }
      clearInterval(loadInterval);
    }

    public function audioUpdate( e:Object ):void {
      switch ( e.type ) {
        case Event.ID3 :
          onMediaEvent( MediaEvent.META );
          onLoaded();
          break;

        case Event.SOUND_COMPLETE :
          playing=false;
          onMediaEvent( MediaEvent.COMPLETE );
          break;
      }
    }

    private function ioErrorHandler(event:Event):void {
    }

    public function getVolume():Number {
      if (channel) {
        return channel.soundTransform.volume;
      }

      return vol;
    }

    public function setVolume(_vol:Number):void {
      Utils.debug( "AudioPlayer: setVolume( " + _vol + ")", debug );
      vol = _vol;
      if (channel) {
        try {
          var transform:SoundTransform=channel.soundTransform;
          transform.volume=_vol;
          channel.soundTransform=transform;
        } catch (e:Error) {
          Utils.debug( "ERROR: setVolume: " + e.toString() );
        }
      }
    }

    private function stopChannel():void {
      if (channel) {
        try {
          channel.stop();
        } catch (e:Error) {
          Utils.debug(e.toString());
        }
      }
      playing=false;
      SoundMixer.stopAll();
    }

    public function playMedia(setPos:Number = -1):void {
      // Only play if we are not playing or are seeking to a new position.
      if (!playing || (setPos >= 0)) {
      
        // Get the new position to play.
        var newPos = (setPos >= 0) ? setPos : position;
        Utils.debug( "AudioPlayer: playMedia( " + newPos + ")", debug );

        try {
          stopChannel();
          playing=true;
          channel=super.play(newPos);
        } catch (e:Error) {
          Utils.debug(e.toString());
        }

        if (channel) {
          channel.removeEventListener( Event.SOUND_COMPLETE, audioUpdate );
          channel.addEventListener( Event.SOUND_COMPLETE, audioUpdate );
        }

        setVolume(vol);
      }
      
      onMediaEvent(MediaEvent.PLAYING);
    }

    public function pauseMedia():void {
      if (channel) {
        position=channel.position;
      }

      stopChannel();
      Utils.debug( "AudioPlayer: pauseMedia( " + position + ")", debug );
      onMediaEvent( MediaEvent.PAUSED );
    }

    public function stopMedia():void {
      position=0;
      duration=0;
      vol=0.8;
      loaded=false;
      stopChannel();

      // If we are still streaming a audio track, then close it.
      try {
        this.close();
      } catch (e:Error) {
        Utils.debug( e.toString() );
      }

      Utils.debug( "AudioPlayer: stopMedia()", debug );
      onMediaEvent( MediaEvent.STOPPED );
    }

    public function seekMedia( pos:Number ):void {
      if (channel) {
        Utils.debug( "AudioPlayer: seekMedia( " + pos + ")", debug );
        playMedia((pos * 1000));
      }
    }

    public function getDuration():Number {
      return (this.length / 1000);
    }

    public function getCurrentTime():Number {
      return (channel ? (channel.position / 1000) : 0);
    }

    public function getMediaBytesLoaded():Number {
      return bytesLoaded;
    }

    public function getMediaBytesTotal():Number {
      return bytesTotal;
    }

    public function getRatio():Number {
      return 0;
    }

    private var loadInterval:Number;

    public var channel:SoundChannel;
    public var context:SoundLoaderContext;
    public var duration:Number=0;
    public var position:Number=0;
    public var loaded:Boolean=false;
    public var playing:Boolean=false;
    public var debug:Boolean=false;
    public var vol:Number=0.8;
    public var onMediaEvent:Function=null;
  }
}