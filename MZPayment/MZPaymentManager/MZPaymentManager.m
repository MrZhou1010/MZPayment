//
//  MZPaymentManager.m
//  MZPayment
//
//  Created by Mr.Z on 2021/1/4.
//

#import "MZPaymentManager.h"
#import "MZPaymentConfig.h"
#import <AliPaySDK/AliPaySDK.h>
#import <WechatOpenSDK/WXApi.h>

@interface MZPaymentManager() <WXApiDelegate>

@end

@implementation MZPaymentManager

#pragma mark - 单例
+ (instancetype)shareInstance {
    static MZPaymentManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[MZPaymentManager alloc] init];
    });
    return _instance;
}

#pragma mark - 微信SDK
+ (BOOL)registerWxApp {
    return [WXApi registerApp:wxAppId universalLink:wxUniversalLink];
}

+ (BOOL)isWxAppInstalled {
    return [WXApi isWXAppInstalled];
}

+ (BOOL)handleOpenUrl:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[MZPaymentManager shareInstance]];
}

+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity {
    return [WXApi handleOpenUniversalLink:userActivity delegate:[MZPaymentManager shareInstance]];
}

+ (void)sendWxPaymentOrder:(NSDictionary *)orderDic callback:(void (^ __nullable)(BOOL success))completionBlock {
    PayReq *payReq = [[PayReq alloc] init];
    payReq.partnerId = orderDic[@"partnerid"];
    payReq.prepayId = orderDic[@"prepayid"];
    payReq.nonceStr = orderDic[@"noncestr"];
    payReq.timeStamp = [orderDic[@"timestamp"] intValue];
    payReq.package = orderDic[@"package"];
    payReq.sign = orderDic[@"sign"];
    [WXApi sendReq:payReq completion:completionBlock];
}

/// 微信支付回调
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *payResp = (PayResp *)resp;
        switch (payResp.errCode) {
            case WXSuccess:
                // 成功
                break;
            case WXErrCodeCommon:
                // 普通错误类型
                break;
            case WXErrCodeUserCancel:
                // 用户点击取消并返回
                break;
            case WXErrCodeSentFail:
                // 发送失败
                break;
            case WXErrCodeAuthDeny:
                // 授权失败
                break;
            case WXErrCodeUnsupport:
                // 微信暂不支持
                break;
            default:
                break;
        }
    }
}

#pragma mark - 支付宝SDK
+ (void)processOrderWithPaymentResult:(NSURL *)url standbyCallback:(void (^ __nullable)(NSDictionary *resultDic))completionBlock {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:completionBlock];
}

+ (void)processAuthResult:(NSURL *)url auth:(AlipayAuthVersion)alipayAuth standbyCallback:(void (^ __nullable)(NSDictionary *resultDic))completionBlock {
    switch (alipayAuth) {
        case AlipayAuthV1:
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:completionBlock];
            break;
        case AlipayAuthV2:
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:completionBlock];
            break;
        default:
            break;
    }
}

+ (void)sendAliPaymentOrder:(NSString *)orderString auth:(AlipayAuthVersion)alipayAuth callback:(void (^ __nullable)(NSDictionary *resultDic))completionBlock {
    switch (alipayAuth) {
        case AlipayAuthV1:
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:aliAppId callback:completionBlock];
            break;
        case AlipayAuthV2:
            [[AlipaySDK defaultService] payOrder:orderString dynamicLaunch:NO fromScheme:aliAppId callback:completionBlock];
            break;
        default:
            break;
    }
}

@end
