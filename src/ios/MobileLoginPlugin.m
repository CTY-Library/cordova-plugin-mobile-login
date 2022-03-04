/********* MobileLoginPlugin.m Cordova Plugin Implementation *******/
 
#import <Cordova/CDV.h>
  
#import <AVKit/AVKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
 

#import <ATAuthSDK/ATAuthSDK.h>
#import <PNSNetDetect/PNSNetDetect.h>
#import <YTXMonitor/YTXMonitor.h>
#import <YTXOperators/YTXOperators.h>
 

@interface MobileLoginPlugin : CDVPlugin {
    NSString *webUrlString;
} 
 
- (void)onekey_init:(CDVInvokedUrlCommand*)command;
- (void)onekey_login:(CDVInvokedUrlCommand*)command;

@end

@implementation MobileLoginPlugin

static NSString* myAsyncCallBackId = nil;
static CDVPluginResult *pluginResult = nil;
static MobileLoginPlugin *selfplugin = nil;

- (void)pluginInitialize {
    CDVViewController *viewController = (CDVViewController *)self.viewController;
    webUrlString = [viewController.settings objectForKey:@"loginprivactweb"];//获取插件的 LOGINPRIVACTWEB
   
}

- (void)onekey_init:(CDVInvokedUrlCommand *)command
{
    selfplugin = self;
    myAsyncCallBackId = command.callbackId;
//    以下代码建议搬迁到 appDelegate.m
    
    
    /**
     *  设置 ATAuthSDK 的秘钥信息
     *  建议该信息维护在自己服务器端
     *  放在程序入口处调用效果最佳
     *
     *  1. 首先会从本地沙盒中找
     *  2. 沙盒找不到使用本地最初的秘钥进行初始化
     *  3. 同时发送异步请求从服务端拉取最新秘钥，拉取成功更新到本地沙盒中
     *
     *
     #import <ATAuthSDK/ATAuthSDK.h>
     #import <PNSNetDetect/PNSNetDetect.h>
     #import <YTXMonitor/YTXMonitor.h>
     #import <YTXOperators/YTXOperators.h> 
     *
     */
//    NSString *app_page_name = @"com.xxx.xxxx";
//    NSString *authSDKInfo = [[NSUserDefaults standardUserDefaults] objectForKey: app_page_name];
//    if (!authSDKInfo || authSDKInfo.length == 0) {
//        authSDKInfo = @"xxxxxxxxxxxxxxxxxxxxxxxxx";
//    }
//
//    [[TXCommonHandler sharedInstance] setAuthSDKInfo:authSDKInfo
//                                            complete:^(NSDictionary * _Nonnull resultDic) {
//        //NSLog(@"设置秘钥结果：%@", resultDic);
//    }];
    

    
    pluginResult = [CDVPluginResult resultWithStatus: CDVCommandStatus_NO_RESULT];
    [pluginResult setKeepCallbackAsBool:YES];
    [self.commandDelegate sendPluginResult:pluginResult callbackId: command.callbackId];
}


- (void)onekey_login:(CDVInvokedUrlCommand *)command
{
    selfplugin = self;
    myAsyncCallBackId = command.callbackId;
    
    [self initOneKeyLoginBtn]; 
}
 

- (void) initOneKeyLoginBtn {
 
    [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil]; //关闭授权页面
    
    //自定义拉起授权页面
    TXCustomModel *model = [[TXCustomModel alloc] init];
        model.navColor = UIColor.systemGreenColor;
        model.navTitle = [[NSAttributedString alloc] initWithString:@"一键登录"attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor,NSFontAttributeName : [UIFont systemFontOfSize:20.0]}];
       //选中后的颜色
       model.loginBtnBgImgs = @[[UIImage imageNamed:@"login_btn_normal"],[UIImage imageNamed:@"login_btn_unable"],[UIImage imageNamed:@"login_btn_press"]];
        //model.navIsHidden = NO;
        model.navBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
        //model.hideNavBackItem = NO;
        //UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        //[rightBtn setTitle:@"更多" forState:UIControlStateNormal];
        //model.navMoreView = rightBtn;
        model.privacyNavColor = UIColor.blackColor;
        model.privacyNavBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
        model.privacyNavTitleFont = [UIFont systemFontOfSize:20.0];
        model.privacyNavTitleColor = UIColor.whiteColor;
        model.logoImage = [UIImage imageNamed:@"AppIcon"];
        //model.logoIsHidden = NO;
        //model.sloganIsHidden = NO;
    //一键登录slogan文案
        model.sloganText = [[NSAttributedString alloc] initWithString:@"学习是一种时尚"attributes:@{NSForegroundColorAttributeName : UIColor.grayColor,NSFontAttributeName : [UIFont systemFontOfSize:16.0]}];
        model.numberColor = UIColor.blackColor;
        model.numberFont = [UIFont systemFontOfSize:30.0];
        model.loginBtnText = [[NSAttributedString alloc] initWithString:@"一键登录"attributes:@{  NSForegroundColorAttributeName : UIColor.whiteColor,NSFontAttributeName : [UIFont systemFontOfSize:20.0]}];
        
        //model.autoHideLoginLoading = NO;
        if(webUrlString  != nil){
            model.privacyOne = @[@"《隐私政策》",webUrlString];
        }
    
        //model.privacyTwo = @[@"《隐私2》",@"https://www.taobao.com/"];
        model.privacyColors = @[UIColor.lightGrayColor,UIColor.blackColor];
        model.privacyAlignment = NSTextAlignmentCenter;
        model.privacyFont = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
        model.privacyOperatorPreText = @"《";
        model.privacyOperatorSufText = @"》";
        //model.checkBoxIsHidden = NO;
        model.checkBoxWH = 17.0;
        //model.changeBtnTitle = [[NSAttributedString alloc] initWithString:@"短信登录"attributes:@{NSForegroundColorAttributeName : UIColor.orangeColor,NSFontAttributeName : [UIFont systemFontOfSize:18.0]}];
        model.changeBtnIsHidden = YES;
        model.prefersStatusBarHidden = NO;
        model.preferredStatusBarStyle = UIStatusBarStyleLightContent;
        model.presentDirection = PNSPresentationDirectionBottom;
    
        //添加自定义控件并对自定义控件进行布局
        __block UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:@"切换到短信登录页面" forState:UIControlStateNormal];
        //[customBtn setBackgroundColor:UIColor.redColor];
        [customBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal ];
        customBtn.titleLabel.font = [UIFont systemFontOfSize: 14];
        //设置点击事件
        [customBtn addTarget:self action:@selector(msgButtonClick) forControlEvents:UIControlEventTouchUpInside];
        customBtn.frame = CGRectMake(0, 0, 230, 40);
        model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
             [superCustomView addSubview:customBtn];
        };
        model.customViewLayoutBlock = ^(CGSize screenSize,CGRect contentViewFrame,CGRect navFrame,CGRect titleBarFrame,CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
            CGRect frame = customBtn.frame;
            frame.origin.x = (contentViewFrame.size.width - frame.size.width) * 0.5;
            frame.origin.y = CGRectGetMinY(privacyFrame) / 1.7;// - frame.size.height ;
            frame.size.width = contentViewFrame.size.width - frame.origin.x * 2;
            customBtn.frame = frame;
        };
    
        
       
        // sdk
        [[TXCommonHandler sharedInstance] getLoginTokenWithTimeout:3.0
                                                        controller:self.viewController
                                                             model:model
                                                          complete:^(NSDictionary * _Nonnull resultDic) {
            NSString *resultCode = (NSString *)[resultDic objectForKey:@"resultCode"];
            if ([PNSCodeLoginControllerPresentSuccess isEqualToString:resultCode]) {
                // NSLog(@"授权页拉起成功回调：%@", resultDic);
               // [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            } else if ([PNSCodeLoginControllerClickCancel isEqualToString:resultCode] ||
                       [PNSCodeLoginControllerClickChangeBtn isEqualToString:resultCode] ||
                       [PNSCodeLoginControllerClickLoginBtn isEqualToString:resultCode] ||
                       [PNSCodeLoginControllerClickCheckBoxBtn isEqualToString:resultCode] ||
                       [PNSCodeLoginControllerClickProtocol isEqualToString:resultCode]) {
               // NSLog(@"页面点击事件回调：%@", resultDic);
            } else if ([PNSCodeSuccess isEqualToString:resultCode]) {
                //NSLog(@"获取LoginToken成功回调：%@", resultDic);
                //NSString *token = [resultDic objectForKey:@"token"];
                //NSLog(@"接下来可以拿着Token去服务端换取手机号，有了手机号就可以登录，SDK提供服务到此结束");
                //[weakSelf dismissViewControllerAnimated:YES completion:nil];
               
                NSString *token = (NSString *) [resultDic objectForKey:@"token"];
                //NSLog(@"获取token成功回调：%@", token);
                NSString *json_token = [NSString stringWithFormat:@"%@%@%@",@"{\"token\":\"",token,@"\"}"];
                [self sendCmd:  json_token];
                
                [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil];
            } else {
                //NSLog(@"获取LoginToken或拉起授权页失败回调：%@", resultDic);
                [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil];
                [self sendCmd:  @"0|一键登录失败切换到其他登录方式"];
  
            }
        }];
    //}
}



-  (void)  sendCmd : (NSString *)msg
{
    if(myAsyncCallBackId != nil)
    {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: msg ];
        //将 CDVPluginResult.keepCallback 设置为 true ,则不会销毁callback
        [pluginResult  setKeepCallbackAsBool:YES];
        [selfplugin.commandDelegate sendPluginResult:pluginResult callbackId: myAsyncCallBackId];

    }
}
 

-(void)msgButtonClick{
    [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil];
    [self sendCmd:  @"1|切换到短信登录方式"];
}
 
@end

