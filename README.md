cordova 插件, 手机号码一键登录, 集成阿里云的SDK 

``` 
ionic cordova plugin add https://github.com/lounai-chen/cordova-plugin-mobile-login --variable LOGINSECRETKEY=xxxx --variable  LOGINPRIVACTWEB=http://xxx
``` 
LOGINSECRETKEY 是安卓的密钥 

LOGINPRIVACTWEB 隐私政策的网站 

 
 




1 安卓: 


1.1 没自动添加成功activity,需要在 AndroidManifest.xml 手动加入
``` 
<activity android:name="com.aliqin.mytel.login.OneKeyLoginActivity" />
<activity android:configChanges="orientation|keyboardHidden|screenSize" android:exported="false" android:launchMode="singleTop" android:name="com.mobile.auth.gatewayauth.LoginAuthActivity" android:theme="@style/authsdk_activity_dialog" />
<activity android:configChanges="orientation|keyboardHidden|screenSize" android:exported="false" android:launchMode="singleTop" android:name="com.mobile.auth.gatewayauth.activity.AuthWebVeiwActivity" android:screenOrientation="behind" />
<activity android:configChanges="orientation|keyboardHidden|screenSize" android:exported="false" android:launchMode="singleTop" android:name="com.cmic.sso.sdk.activity.LoginAuthActivity" />
``` 

2 IOS 

 2.1 设置密钥,建议迁移到 appDelegate.m 
 
 2.2 需手动拷贝src/ios/res/image到xcode的Resources下 ,否则⼀键登录授权⻚⾯的按钮是默认样式 
 
 2.3 添加ATAuthSDK.framework > ATAuthSDK.bundle资源⽂件，否则⼀键登录授权⻚⾯默认的图⽚或icon不可显示 



3 阿里云的参考链接 

https://help.aliyun.com/document_detail/144231.html 

https://help.aliyun.com/document_detail/144186.html 


