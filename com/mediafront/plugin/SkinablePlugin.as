package com.mediafront.plugin {
  import com.mediafront.utils.Utils;
  import com.mediafront.display.Skinable;
  import com.mediafront.utils.Settings;
  import com.mediafront.plugin.PluginEvent;

  import flash.system.Security;
  import flash.display.MovieClip;
  import flash.events.Event;

  public class SkinablePlugin extends Skinable {
    public function SkinablePlugin() {
      super();
      Security.allowDomain("*");
    }

    public function loadSettings( _settings:Object ):void {
      settings=_settings;
    }

    public override function loadSkin( _skinName:String ):void {
      var skinURL:String="";
      info.skin=info.skin.replace('%skin',settings.skin);
      skinURL+=info.skin.match(/^http(s)?\:\/\//) ? '' : settings.baseURL+"/";
      skinURL+=info.skin;
      Utils.debug("Loading Skin: " + skinURL, settings.debug);
      super.loadSkin( skinURL );
    }

    public override function setSkin( _skin:MovieClip ):void {
      dispatchEvent( new Event( PluginEvent.PLUGIN_LOADED ) );
    }

    public function getSettings():Object {
      return settings;
    }

    public function set info( pluginInfo:Object ):void {
      _info=pluginInfo;
    }

    public function get info():Object {
      return _info;
    }

    public function initialize( comps:Object ):void {
      components=comps;
    }

    public function onReady():void {
    }

    protected var components:Object;
    protected var settings:Object;
    private var _info:Object;
  }
}