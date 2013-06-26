package com.mediafront.display.media {
  import com.mediafront.utils.Utils;

  public class MediaFile {
    public var path:String="";
    public var stream:String=null;
    public var extension:String="";
    public var mediaType:String="";
    public var loaded:Boolean=false;

    public function MediaFile( file:Object ) {
      path=file.path;
      stream=file.stream;
      loaded=false;
      extension=file.extension?file.extension:Utils.getFileExtension(path);
      mediaType=file.mediaType?file.mediaType:getMediaType();
    }

    public function isValid():Boolean {
      return (mediaType != "");
    }

    private function getMediaType():String {
      switch ( extension ) {
        case "swf" :
          return "swf";

        case "flv" :
        case "f4v" :
        case "mp4" :
        case "m4v" :
        case "mov" :
        case "3g2" :
        case "ogg" :
        case "ogv" :
          return "video";

        case "mp3" :
        case "m4a" :
        case "aac" :
        case "wav" :
        case "aif" :
        case "wma" :
        case "oga" :
          return "audio";

        default :
          return "video";
      }
    }
  }
}