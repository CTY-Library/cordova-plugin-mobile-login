package com.aliqin.mytel.login;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
//import android.support.annotation.Nullable;

import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

//import com.aliqin.mytel.MessageActivity;
import androidx.annotation.Nullable;

import com.aliqin.mytel.MobileLoginPlugin;
import com.zhongzilian.chestnutapp.BuildConfig;
import com.zhongzilian.chestnutapp.R;
import com.aliqin.mytel.config.BaseUIConfig;
import com.aliqin.mytel.uitls.ExecutorManager;
import com.mobile.auth.gatewayauth.PhoneNumberAuthHelper;
import com.mobile.auth.gatewayauth.ResultCode;
import com.mobile.auth.gatewayauth.TokenResultListener;
import com.mobile.auth.gatewayauth.model.TokenRet;

import org.apache.cordova.CordovaActivity;

import static com.aliqin.mytel.Constant.THEME_KEY;
import static com.aliqin.mytel.uitls.MockRequest.getPhoneNumber;

/**
 * 进app直接登录的场景
 */
public class OneKeyLoginActivity extends Activity {
    private static final String TAG = OneKeyLoginActivity.class.getSimpleName();

    private TextView mTvResult;
    private PhoneNumberAuthHelper mPhoneNumberAuthHelper;
    private TokenResultListener mTokenResultListener;
    private ProgressDialog mProgressDialog;
    private int mUIType;
    private BaseUIConfig mUIConfig;

    public static Context _this_context;
    public static Activity _this_activity;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mUIType = getIntent().getIntExtra(THEME_KEY, -1);
        setContentView(R.layout.activity_login);
        //mTvResult = findViewById(R.id.tv_result);
         sdkInit();
       mUIConfig = BaseUIConfig.init(mUIType, this, mPhoneNumberAuthHelper);
       oneKeyLogin();
    }


    public  void sdkInit() {
      String secretInfo = MobileLoginPlugin.mySECRET_KEY;// BuildConfig.AUTH_SECRET;

        mTokenResultListener = new TokenResultListener() {
            @Override
            public void onTokenSuccess(String s) {
                hideLoadingDialog();
                TokenRet tokenRet = null;
                try {
                    tokenRet = TokenRet.fromJson(s);
                    if (ResultCode.CODE_START_AUTHPAGE_SUCCESS.equals(tokenRet.getCode())) {
                        Log.i("TAG", "唤起授权页成功：" + s);
                    }

                    if (ResultCode.CODE_SUCCESS.equals(tokenRet.getCode())) {
                        Log.i("TAG", "获取token成功：" + s);
                        getResultWithToken(tokenRet.getToken());
                        mPhoneNumberAuthHelper.setAuthListener(null);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onTokenFailed(String s) {
                Log.e(TAG, "获取token失败：" + s);
                hideLoadingDialog();
                TokenRet tokenRet = null;
                try {
                    tokenRet = TokenRet.fromJson(s);
                    if (ResultCode.CODE_ERROR_USER_CANCEL.equals(tokenRet.getCode())) {
                        //模拟的是必须登录 否则直接退出app的场景
                        finish();
                    } else {
                        MobileLoginPlugin.callJS("0|一键登录失败切换到其他登录方式"); //主动回调cordova,返回JS
                        finish();
                        //Toast.makeText(getApplicationContext(), "一键登录失败切换到其他登录方式", Toast.LENGTH_SHORT).show();
                        //Intent pIntent = new Intent(OneKeyLoginActivity.this, MessageActivity.class);
                        //startActivityForResult(pIntent, 1002);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                mPhoneNumberAuthHelper.setAuthListener(null);
            }
        };
        mPhoneNumberAuthHelper = PhoneNumberAuthHelper.getInstance(this, mTokenResultListener);
        mPhoneNumberAuthHelper.getReporter().setLoggerEnable(true);
        mPhoneNumberAuthHelper.setAuthSDKInfo(secretInfo);


    }

    /**
     * 进入app就需要登录的场景使用
     */
    private void oneKeyLogin() {
        mPhoneNumberAuthHelper = PhoneNumberAuthHelper.getInstance(getApplicationContext(), mTokenResultListener); // getApplicationContext()
        mPhoneNumberAuthHelper.checkEnvAvailable();
        mUIConfig.configAuthPage();
        getLoginToken(5000);
    }

    /**
     * 拉起授权页
     * @param timeout 超时时间
     */
    public void getLoginToken(int timeout) {
        mPhoneNumberAuthHelper.getLoginToken(this, timeout);
        showLoadingDialog("正在唤起授权页");
    }


    public void getResultWithToken(final String token) {
        ExecutorManager.run(new Runnable() {
            @Override
            public void run() {
                final String result = getPhoneNumber(token);
                OneKeyLoginActivity.this.runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                       // mTvResult.setText("登陆成功：" + result);
                        mPhoneNumberAuthHelper.quitLoginPage();
                    }
                });
                MobileLoginPlugin.callJS(result); //主动回调cordova,返回JS
                onBackPressed();
            }
        });
    }

  //调用onBackPressed()方法，点击返回键返回数据给上一个Activity
  public   void onBackPressed() {
    //还是新建一个Intent,只是此时Intent只是作为传递数据使用，并没有其他的意图
    Intent intent = new Intent();
    //需要返回的数据
    String data = "";
    //在intent当中调用putExtra()方法来把数据返回
    intent.putExtra("data",data);
    //setResult()方法是返回数据时必须要使用到的额，这里需要两个参数
    //一个参数来和getStringExtra()方法当中的参数项对应
    //后一个参数和当前Activity中的数据data对应
    setResult(2,intent);
    //返回数据后结束当前活动
    finish();
  }




    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1002) {
            if (resultCode == 1) {
               // mTvResult.setText("登陆成功：" + data.getStringExtra("result"));
            } else {
                //模拟的是必须登录 否则直接退出app的场景
                finish();
            }
        }
        finish();
    }



    public void showLoadingDialog(String hint) {
        if (mProgressDialog == null) {
            mProgressDialog = new ProgressDialog(this);
            mProgressDialog.setProgressStyle(ProgressDialog.STYLE_SPINNER);
        }
        mProgressDialog.setMessage(hint);
        mProgressDialog.setCancelable(true);
        mProgressDialog.show();
    }

    public void hideLoadingDialog() {
        if (mProgressDialog != null) {
            mProgressDialog.dismiss();
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
        mUIConfig.onResume();
    }
}
