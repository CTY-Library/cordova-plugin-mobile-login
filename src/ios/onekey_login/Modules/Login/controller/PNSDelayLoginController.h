//
//  PNSDelayLoginController.h
//  ATAuthSceneDemo
//
//  Created by 刘超的MacBook on 2020/8/6.
//  Copyright © 2020 刘超的MacBook. All rights reserved.
//

#import "PNSBaseViewController.h"
#import "PNSBuildModelUtils.h"

#import <Cordova/CDVViewController.h>
#import <Cordova/CDVCommandDelegateImpl.h>
#import <Cordova/CDVCommandQueue.h>

NS_ASSUME_NONNULL_BEGIN

@interface PNSDelayLoginController : PNSBaseViewController

@property (nonatomic, assign) PNSBuildModelStyle style;

@end

NS_ASSUME_NONNULL_END
