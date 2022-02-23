package com.plugin.floatv1.floatingwindow;

import android.content.Context;
import android.os.Build;
import android.support.annotation.RequiresApi;

import com.plugin.floatv1.floatingwindow.FloatingMainActivity;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

/**
 * Created by noah chen on 2022/2/22.
 */

public class MobileLoginPlugin extends CordovaPlugin {
  private FloatingMainActivity fma;
  private Context mActContext;
  private static CallbackContext mCallbackContext;

  @RequiresApi(api = Build.VERSION_CODES.M)
  @Override
  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
    fma = new FloatingMainActivity();
    mActContext = this.cordova.getActivity().getApplicationContext();

  }


  @RequiresApi(api = Build.VERSION_CODES.M)
  @Override
  public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
    String video_url = args.getString(0);
    //初始化
    if (action.equals("onekey_init")) {

      return true;
    }
    //一键登录
    else if (action.equals("onekey_login")) {

      return true;
    }
    
    return false;
  }
 


}
