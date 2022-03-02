/********* MobileLoginPlugin.m Cordova Plugin Implementation *******/
 
#import <Cordova/CDV.h>
  
#import <AVKit/AVKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
 
 
  
#import <ATAuthSDK/ATAuthSDK.h>
#import <PNSNetDetect/PNSNetDetect.h>
#import <YTXMonitor/YTXMonitor.h>
#import <YTXOperators/YTXOperators.h>

#import "PNSMainController.h"
#import "PNSBaseNavigationController.h"
#import "PNSDelayLoginController.h"
#import "PNSHttpsManager.h"
#import "PNSSmsLoginController.h"

@interface MobileLoginPlugin : CDVPlugin {
    NSString *urlString; 
} 
@property (nonatomic, assign) PNSBuildModelStyle style;

- (void)onekey_init:(CDVInvokedUrlCommand*)command;
- (void)onekey_login:(CDVInvokedUrlCommand*)command;

@end

@implementation MobileLoginPlugin

static NSString* myAsyncCallBackId = nil;
static CDVPluginResult *pluginResult = nil;
static MobileLoginPlugin *selfplugin = nil;

- (void)pluginInitialize {
 
}

- (void)onekey_init:(CDVInvokedUrlCommand *)command
{
    selfplugin = self;
    myAsyncCallBackId = command.callbackId;
//    
//    /**
//     *  设置 ATAuthSDK 的秘钥信息
//     *  建议该信息维护在自己服务器端
//     *  放在程序入口处调用效果最佳
//     *
//     *  1. 首先会从本地沙盒中找
//     *  2. 沙盒找不到使用本地最初的秘钥进行初始化
//     *  3. 同时发送异步请求从服务端拉取最新秘钥，拉取成功更新到本地沙盒中
//     */
//    NSString *app_page_name = @"com.xxx";
//    NSString *authSDKInfo = [[NSUserDefaults standardUserDefaults] objectForKey: app_page_name];
//    if (!authSDKInfo || authSDKInfo.length == 0) {
//        authSDKInfo = @"xxx";
//    }
//    [PNSHttpsManager requestATAuthSDKInfo:^(BOOL isSuccess, NSString * _Nonnull authSDKInfo) {
//        if (isSuccess) {
//            [[NSUserDefaults standardUserDefaults] setObject:authSDKInfo forKey: app_page_name];
//        }
//    }];
//    
//  
//    [[TXCommonHandler sharedInstance] setAuthSDKInfo:authSDKInfo
//                                            complete:^(NSDictionary * _Nonnull resultDic) {
//        NSLog(@"设置秘钥结果：%@", resultDic);
//    }];
//    
//   
    
    pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_NO_RESULT];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}


- (void)onekey_login:(CDVInvokedUrlCommand *)command
{
    selfplugin = self;
    myAsyncCallBackId = command.callbackId;
    
   // PNSDelayLoginController *controller_login = [[PNSDelayLoginController alloc] init];
    //PNSBaseNavigationController *navigationController = [[PNSBaseNavigationController alloc] initWithRootViewController:controller_login];

//    UIWindow *_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    //创建uiview对象
//    UIView *_playerView = [[UIView alloc] init];
//
//    _window.rootViewController = navigationController;
//    [_window addSubview:_playerView];
//
//    [_window makeKeyAndVisible];

    
    
   // self.viewController = navigationController;
    //[self.viewController.init : navigationController];
    
    [self initOneKeyLoginBtn];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"-1" ];
    [pluginResult setKeepCallbackAsBool:YES]; //将 CDVPluginResult.keepCallback 设置为 true ,则不会销毁callback
    [self.commandDelegate sendPluginResult: pluginResult callbackId: command.callbackId];
 
    
}
 

- (void) initOneKeyLoginBtn {
    //if (self.isCanUseOneKeyLogin == NO) {
       // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
       // hud.mode = MBProgressHUDModeText;
       // hud.label.text = @"当前环境不支持一键登录";
        //[hud hideAnimated:YES afterDelay:2.0];
    //} else {
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    PNSDelayLoginController *controller_login = [[PNSDelayLoginController alloc] init];
 
        TXCustomModel *model = [PNSBuildModelUtils buildModelWithStyle:self.style
                                                          button1Title:@"短信登录"
                                                               target1:controller_login
                                                             selector1:@selector(gotoSmsControllerAndShowNavBar)
                                                          button2Title:@"短信登录（隐藏系统导航栏）"
                                                               target2:self
                                                             selector2:@selector(gotoSmsControllerAndHiddenNavBar)];
        
       // __weak typeof(self) weakSelf = self;
        [[TXCommonHandler sharedInstance] getLoginTokenWithTimeout:3.0
                                                        controller:self.viewController
                                                             model:model
                                                          complete:^(NSDictionary * _Nonnull resultDic) {
            NSString *resultCode = [resultDic objectForKey:@"resultCode"];
            if ([PNSCodeLoginControllerPresentSuccess isEqualToString:resultCode]) {
                NSLog(@"授权页拉起成功回调：%@", resultDic);
               // [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            } else if ([PNSCodeLoginControllerClickCancel isEqualToString:resultCode] ||
                       [PNSCodeLoginControllerClickChangeBtn isEqualToString:resultCode] ||
                       [PNSCodeLoginControllerClickLoginBtn isEqualToString:resultCode] ||
                       [PNSCodeLoginControllerClickCheckBoxBtn isEqualToString:resultCode] ||
                       [PNSCodeLoginControllerClickProtocol isEqualToString:resultCode]) {
                NSLog(@"页面点击事件回调：%@", resultDic);
            } else if ([PNSCodeSuccess isEqualToString:resultCode]) {
                NSLog(@"获取LoginToken成功回调：%@", resultDic);
                //NSString *token = [resultDic objectForKey:@"token"];
                NSLog(@"接下来可以拿着Token去服务端换取手机号，有了手机号就可以登录，SDK提供服务到此结束");
                //[weakSelf dismissViewControllerAnimated:YES completion:nil];
                [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil];
            } else {
                NSLog(@"获取LoginToken或拉起授权页失败回调：%@", resultDic);
                //[MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
                //失败后可以跳转到短信登录界面
//                PNSSmsLoginController *controller = [[PNSSmsLoginController alloc] init];
//                controller.isHiddenNavgationBar = NO;
//                UINavigationController *navigationController = self.navigationController;
//                if (self.presentedViewController) {
//                    //如果授权页成功拉起，这个时候则需要使用授权页的导航控制器进行跳转
//                    navigationController = (UINavigationController *)self.presentedViewController;
//                }
                //[navigationController pushViewController:controller animated:YES];
            }
        }];
    //}
}

-  (void)   goMsgPage
{
 
}

-  (void)  sendCmd : (NSString *)video_times
{
    if(myAsyncCallBackId != nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: video_times ];
        //将 CDVPluginResult.keepCallback 设置为 true ,则不会销毁callback
        [pluginResult  setKeepCallbackAsBool:YES];
        [selfplugin.commandDelegate sendPluginResult:pluginResult callbackId: myAsyncCallBackId];

    }
}
 
 
@end

