package com.mediafront.display.media {
  public interface IMedia {
    function connect( stream:String ):void;
    function loadFile( file:String ):void;
    function setVolume(vol:Number):void;
    function getVolume():Number;
    function playMedia( setPos:Number = -1 ):void;
    function pauseMedia():void;
    function stopMedia():void;
    function seekMedia( pos:Number ):void;
    function getMediaBytesLoaded():Number;
    function getMediaBytesTotal():Number;
    function getDuration():Number;
    function getCurrentTime():Number;
    function getRatio():Number;
  }
}