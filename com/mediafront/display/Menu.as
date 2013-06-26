package com.mediafront.display {
  import com.mediafront.plugin.SkinablePlugin;
  import com.mediafront.plugin.PluginEvent;
  import com.mediafront.utils.Settings;
  import com.mediafront.utils.MediaSettings;
  import com.mediafront.utils.Utils;

  import flash.display.*;
  import flash.events.*;

  public class Menu extends SkinablePlugin {
    public function Menu() {
      super();
    }

    public override function loadSettings( _settings:Object ):void {
      super.loadSettings( new MenuSettings( _settings ) );
      super.loadSkin( settings.menu );
    }

    public override function setSkin( _skin:MovieClip ):void {
      super.setSkin( _skin );
    }

    public override function onReady():void {
      super.onReady();
    }

    public override function onResize( deltaX:Number, deltaY:Number ):void {
      super.onResize( deltaX, deltaY );
    }
  }
}