//
//  PNSReturnCode.h
//  ATAuthSDK
//
//  Created by 刘超的MacBook on 2019/9/4.
//  Copyright © 2019. All rights reserved.
//

#ifndef PNSReturnCode_h
#define PNSReturnCode_h

#import <Foundation/Foundation.h>

#pragma mark - 该返回码为阿里云号码认证SDK⾃身的返回码，请注意600011及600012错误内均含有运营商返回码，具体错误在碰到之后查阅 https://help.aliyun.com/document_detail/85351.html?spm=a2c4g.11186623.6.561.32a7360cxvWk6H


/// 接口成功
static NSString * const PNSCodeSuccess = @"600000";
/// 获取运营商配置信息失败
static NSString * const PNSCodeGetOperatorInfoFailed = @"600004";
/// 未检测到sim卡
static NSString * const PNSCodeNoSIMCard = @"600007";
/// 蜂窝网络未开启或不稳定
static NSString * const PNSCodeNoCellularNetwork = @"600008";
/// 无法判运营商
static NSString * const PNSCodeUnknownOperator = @"600009";
/// 未知异常
static NSString * const PNSCodeUnknownError = @"600010";
/// 获取token失败
static NSString * const PNSCodeGetTokenFailed = @"600011";
/// 预取号失败
static NSString * const PNSCodeGetMaskPhoneFailed = @"600012";
/// 运营商维护升级，该功能不可用
static NSString * const PNSCodeInterfaceDemoted = @"600013";
/// 运营商维护升级，该功能已达最大调用次数
static NSString * const PNSCodeInterfaceLimited = @"600014";
/// 接口超时
static NSString * const PNSCodeInterfaceTimeout = @"600015";
/// AppID、Appkey解析失败
static NSString * const PNSCodeDecodeAppInfoFailed = @"600017";
/// 运营商已切换
static NSString * const PNSCodeCarrierChanged = @"600021";
/// 终端环境检测失败（终端不支持认证 / 终端检测参数错误）
static NSString * const PNSCodeEnvCheckFail = @"600025";

/*************** 号码认证授权页相关返回码 START ***************/

/// 唤起授权页成功
static NSString * const PNSCodeLoginControllerPresentSuccess = @"600001";
/// 唤起授权页失败
static NSString * const PNSCodeLoginControllerPresentFailed = @"600002";
/// 授权页已加载时不允许调用加速或预取号接口
static NSString * const PNSCodeCallPreLoginInAuthPage = @"600026";
/// 点击返回，⽤户取消一键登录
static NSString * const PNSCodeLoginControllerClickCancel = @"700000";
/// 点击切换按钮，⽤户取消免密登录
static NSString * const PNSCodeLoginControllerClickChangeBtn = @"700001";
/// 点击登录按钮事件
static NSString * const PNSCodeLoginControllerClickLoginBtn = @"700002";
/// 点击CheckBox事件
static NSString * const PNSCodeLoginControllerClickCheckBoxBtn = @"700003";
/// 点击协议富文本文字
static NSString * const PNSCodeLoginControllerClickProtocol = @"700004";

/*************** 号码认证授权页相关返回码 FINISH ***************/


/*************** 活体认证相关返回码 START ***************/

/// 点击一键登录拉起授权页二次弹窗
static NSString * const PNSCodeLoginClickPrivacyAlertView = @"700006";
/// 隐私协议二次弹窗关闭
static NSString * const PNSCodeLoginPrivacyAlertViewClose = @"700007";
/// 隐私协议二次弹窗点击确认并继续
static NSString * const PNSCodeLoginPrivacyAlertViewClickContinue = @"700008";
/// 点击隐私协议二次弹窗上的协议富文本文字
static NSString * const PNSCodeLoginPrivacyAlertViewPrivacyContentClick = @"700009";

/*************** 活体认证相关返回码 FINISH ***************/

/*************** 活体认证相关返回码 START ***************/

/// 接口请求失败
static NSString * const PNSCodeFailed = @"600030";
/// 网络错误
static NSString * const PNSCodeErrorNetwork = @"600031";
/// 客户端设备时间错误
static NSString * const PNSCodeErrorClientTimestamp = @"600032";
/// 功能不可用，需要到控制台开通对应功能
static NSString * const PNSCodeFeatureInvalid = @"600033";
/// 不合法的SDK密钥
static NSString * const PNSCodeSDKInfoInvalid = @"600034";
/// 状态繁忙
static NSString * const PNSCodeStatusBusy = @"600035";
/// 业务停机
static NSString * const PNSCodeOutOfSerivce = @"600036";
/// 活体认证页面准备启动
static NSString * const PNSCodeLiftBodyVerifyReadyStating = @"700005";
/// 用户主动取消操作UI事件，用户取消操作
static NSString * const PNSCodeErrorUserCancel = @"700000";

/*************** 活体认证相关返回码 FINISH ***************/

#endif /* PNSReturnCode_h */
