cordova 插件, 手机号码一键登录, 集成阿里云的SDK 

``` 
ionic cordova plugin add https://github.com/lounai-chen/cordova-plugin-mobile-login --variable LOGINSECRETKEY=xxxx --variable  LOGINPRIVACTWEB=http://xxx
``` 

安卓: 
1.需在 build.gradle (app) 的 dependencies { } 中 添加依赖
``` 
    def isLibsMavenDep = (System.getProperty("isMaven") != null)
    implementation(name:'auth_number_product-2.12.3.4-log-online-standard-release', ext:'aar')
    if (!isLibsMavenDep) {
      implementation(name:'crashshield-2.1.3.2-release', ext:'aar')
      implementation(name:'logger-2.1.3.2-release', ext:'aar')
      implementation(name:'main-2.1.3.2-release', ext:'aar')

    }
``` 

2. 
``` 
 
``` 