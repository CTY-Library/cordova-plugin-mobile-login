package com.aliqin.mytel;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Build;
//import android.support.annotation.RequiresApi;

import androidx.annotation.RequiresApi;

import com.aliqin.mytel.login.OneKeyLoginActivity;
import com.aliqin.mytel.uitls.PermissionUtils;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;

import static com.aliqin.mytel.Constant.THEME_KEY;

/**
 * Created by noah chen on 2022/2/22.
 */

public class MobileLoginPlugin extends CordovaPlugin {

  private Context mActContext;
  private static CallbackContext mCallbackContext;
  public static String mySECRET_KEY = "";
  public static String myPrivacy_Web = "";

  @RequiresApi(api = Build.VERSION_CODES.M)
  @Override
  public void initialize(CordovaInterface cordova, CordovaWebView webView) {
    super.initialize(cordova, webView);
    mActContext = this.cordova.getActivity().getApplicationContext();
    ApplicationInfo applicationInfo = null;
    try {
      applicationInfo = mActContext.getPackageManager().getApplicationInfo(mActContext.getPackageName(),
        PackageManager.GET_META_DATA);
    } catch (PackageManager.NameNotFoundException e) {
      e.printStackTrace();
    }
    mySECRET_KEY = applicationInfo.metaData.getString("LOGINSECRETKEY");
    myPrivacy_Web = applicationInfo.metaData.getString("LOGINPRIVACTWEB");
  }


  @RequiresApi(api = Build.VERSION_CODES.M)
  @Override
  public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
    String video_url = args.getString(0);
    //初始化
    if (action.equals("onekey_init")) {

      if (Build.VERSION.SDK_INT >= 23) {
        PermissionUtils.checkAndRequestPermissions(this.cordova.getActivity(), 10001, Manifest.permission.WRITE_EXTERNAL_STORAGE,
          Manifest.permission.READ_PHONE_STATE);
      }
      return true;
    }
    //一键登录
    else if (action.equals("onekey_login")) {
      mCallbackContext = callbackContext;    //拿到回调对象并保存
      Intent pIntent = new Intent(this.cordova.getActivity(), OneKeyLoginActivity.class);
      pIntent.putExtra(THEME_KEY, 0);
     // pIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
      OneKeyLoginActivity._this_context = this.cordova.getContext();
      OneKeyLoginActivity._this_activity = this.cordova.getActivity();
      //this.cordova.getActivity().startActivity(pIntent); // .getBaseContext()
      this.cordova.getActivity().startActivity(pIntent);
      return true;
    }

    return false;
  }

  public static void callJS(String message) {
    if (mCallbackContext != null) {
      PluginResult dataResult = new PluginResult(PluginResult.Status.OK, message);
      dataResult.setKeepCallback(true);// 非常重要
      mCallbackContext.sendPluginResult(dataResult);
    }
  }



}
