package com.aliqin.mytel.uitls;

import android.util.Log;

import org.json.JSONObject;

import java.util.UUID;

public class MockRequest {
    private static final String TAG = MockRequest.class.getSimpleName();


    /**
     * 开发者自己app的服务端对接阿里号码认证，并提供接口给app调用
     * 此处调用服务接口将本机号码校验token以及手机传递过去
     * 根据返回结果进行处理
     * @return 服务端校验结果
     */
    public static String verifyNumber(String token, String phoneNumber) {
        try {
            //模拟网络请求
            Log.i(TAG, "进行本机号码校验：" + "token: " + token + ", phoneNumber: " + phoneNumber);
            Thread.sleep(500);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "本机号码校验成功";
    }

    /**
     * 开发者自己app的服务端对接阿里号码认证，并提供接口给app调用
     * 1、调用app服务端接口将一键登录token发送过去
     * 2、app服务端拿到token调用阿里号码认证服务端换号接口，获取手机号
     * 3、app服务端拿到手机号帮用户完成注册以及登录的逻辑，返回账户信息给app
     * @return 账户信息
     */
    public static String getPhoneNumber(String token) {
        String result = "";
        try {
            //模拟网络请求
            Log.i(TAG, "一键登录换号：" + "token: " + token );
            Thread.sleep(500);
            JSONObject pJSONObject = new JSONObject();
            pJSONObject.put("account", UUID.randomUUID().toString());
            pJSONObject.put("phoneNumber", "***********");
            pJSONObject.put("token", token);
            result = pJSONObject.toString();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
