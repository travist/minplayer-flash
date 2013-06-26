package com.mediafront.display {
  import com.mediafront.display.media.controls.ControlEvent;

  import flash.events.*;
  import flash.geom.*;
  import flash.display.*;
  import flash.utils.*;

  public class Slider extends Skinable {
    public function Slider( _skin:* ) {
      super();
      setSkin( _skin );
    }

    public override function setSkin( _skin:MovieClip ):void {
      super.setSkin( _skin );

      handle=_skin.handle;
      if (handle) {
        handle.buttonMode=true;
        handle.mouseChildren=false;
        handle.addEventListener( MouseEvent.MOUSE_DOWN, onHandleDown );
        handle.addEventListener( MouseEvent.MOUSE_UP, onHandleUp );
      }

      track=_skin.track;
      if (track) {
        track.buttonMode=true;
        track.addEventListener( MouseEvent.CLICK, onSetValue );
        dragRect = new Rectangle( track.x, track.y, (track.width - handle.width), 0 );
      }

      fullness=_skin.fullness;

      dragTimer=new Timer(250);
      dragTimer.stop();
      dragTimer.addEventListener( TimerEvent.TIMER, onDragTimer );
    }

    public function setValue( newValue:Number ):void {
      setPosition( newValue );
      dispatchEvent( new ControlEvent( ControlEvent.CONTROL_SET ) );
    }

    public function updateValue( newValue:Number, setHandle:Boolean = true ):void {
      setPosition( newValue, setHandle );
      dispatchEvent( new ControlEvent( ControlEvent.CONTROL_UPDATE ) );
    }

    public function setPosition( newValue:Number, setHandle:Boolean = true ):void {
      newValue = (newValue < 0) ? 0 : newValue;
      newValue = (newValue > 1) ? 1 : newValue;
      value=newValue;
      var fullWidth = (value * (track.width - handle.width));

      if (fullness) {
        fullness.width=fullWidth;
      }

      if (handle&&setHandle) {
        handle.x=track.x+fullWidth;
      }
    }

    private function onSetValue( event:MouseEvent ):void {
      setValue( (event.localX * event.currentTarget.scaleX) / (track.width - handle.width) );
    }

    private function onTrackOut( event:MouseEvent ):void {
      dragTimer.stop();
      dragging=false;
      event.target.stopDrag();
      event.target.removeEventListener( MouseEvent.MOUSE_MOVE, onDrag );
    }

    private function onHandleDown( event:MouseEvent ):void {
      dragTimer.start();
      dragging=true;
      event.target.startDrag(false, dragRect);
      event.target.addEventListener( MouseEvent.MOUSE_MOVE, onDrag );
    }

    private function onHandleUp( event:MouseEvent ):void {
      onTrackOut( event );
      setValue( dragValue );
    }

    private function onDragTimer( e:TimerEvent ):void {
      updateValue( dragValue, false );
    }

    private function onDrag(event:MouseEvent):void {
      dragValue = (event.target.x - track.x) / (track.width - handle.width);
    }

    public var value:Number=0;
    public var handle:MovieClip;
    public var track:MovieClip;
    public var fullness:MovieClip;
    public var dragTimer:Timer;
    public var dragRect:Rectangle;
    public var dragValue:Number=0;
    public var dragging:Boolean=false;
  }
}