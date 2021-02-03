//
//  AppDelegate.m
//  MZPayment
//
//  Created by Mr.Z on 2021/1/4.
//

#import "AppDelegate.h"
#import "MZPaymentManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 向微信终端注册
    [MZPaymentManager registerWxApp];
    return YES;
}

#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    /*
    if ([url.host isEqualToString:@"safepay"]) {
        // 跳转支付宝钱包进行支付,处理支付结果
        [MZPaymentManager processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@", resultDic);
        }];
        // 支付宝钱包快速登录授权
        [MZPaymentManager processAuthResult:url auth:AlipayAuthV2 standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"auth result = %@", resultDic);
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length > 0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode ? : @"");
        }];
    }
     */
    if ([url.host isEqualToString:@"pay"]) {
        // 处理微信的支付结果
        [MZPaymentManager handleOpenURL:url];
    }
    return YES;
}

@end
