package com.mediafront.display {
  import com.mediafront.utils.Utils;
  import flash.net.*;
  import flash.display.*;
  import flash.geom.*;
  import flash.events.*;

  public class Image extends Sprite {
    public function loadImage( imagePath:String, _boundingRect:Rectangle = null ):void {
      boundingRect=_boundingRect;
      boundingRect=boundingRect?boundingRect:getRect(this);

      // Only load an image who's path is defined.
      if (imagePath) {
        currentLoader=createImageLoader();

        var request:URLRequest=new URLRequest(imagePath);
        request.requestHeaders.push( new URLRequestHeader("pragma", "no-cache") );

        // Try to load the image.
        try {
          currentLoader.load(request);
        } catch (e:Error) {
          Utils.debug( "Error loading image." );
        }
      }
    }

    public function createImageLoader():Loader {
      clearImage();
      var loader:Loader = new Loader();
      loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onImageLoaded );
      loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onError );
      loader.addEventListener( IOErrorEvent.IO_ERROR, onError );
      addChild( loader );
      return loader;
    }

    public function clearImage() {
      var i:int=numChildren;
      while (i--) {
        var field:* =getChildAt(i);
        if (field is Loader) {
          field.unload();
          field.contentLoaderInfo.removeEventListener( Event.COMPLETE, onImageLoaded );
          field.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
          field.removeEventListener( IOErrorEvent.IO_ERROR, onError );
          removeChild( field );
        }
      }
    }

    public function resize( newRect:Rectangle ) {
      if (currentLoader) {
        var imageRect:Rectangle=Utils.getScaledRect(imageRatio,newRect);
        currentLoader.width=imageRect.width;
        currentLoader.height=imageRect.height;
        currentLoader.x=imageRect.x;
        currentLoader.y=imageRect.y;
      }
    }

    private function onImageLoaded( event:Event ) {
      if (boundingRect&&event.target) {
        // Get the image ratio of the loaded image.
        imageRatio=event.target.width/event.target.height;

        // Resize to the image to our bounding rectangle.
        resize( boundingRect );

        // Trigger an event that the image has been added.
        dispatchEvent( new Event( Event.ADDED ) );
      }
    }

    private function onError( e:IOErrorEvent ) {
      // For now, just give out a trace that an error has occured.
      Utils.debug( e.toString() );
    }

    // The current loader variable.
    private var currentLoader:Loader;

    // The bounding rectangle for this image.
    private var boundingRect:Rectangle;

    // The width/height ratio of the loaded image.
    public var imageRatio:Number=1.3333;
  }
}