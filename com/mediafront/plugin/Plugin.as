package com.mediafront.plugin {
  import com.mediafront.utils.Settings;
  import com.mediafront.plugin.PluginEvent;

  import flash.display.Sprite;
  import flash.system.Security;
  import flash.events.Event;

  public class Plugin extends Sprite {
    public function Plugin() {
      super();
      Security.allowDomain("*");
    }

    public function loadSettings( _settings:Object ):void {
      settings=new Settings(_settings);
      dispatchEvent( new Event( PluginEvent.PLUGIN_LOADED ) );
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