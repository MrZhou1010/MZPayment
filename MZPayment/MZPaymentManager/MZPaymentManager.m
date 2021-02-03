//
//  MZPaymentManager.m
//  MZPayment
//
//  Created by Mr.Z on 2021/1/4.
//

#import "MZPaymentManager.h"
#import "MZPaymentConfig.h"

@interface MZPaymentManager() <WXApiDelegate>

@end

@implementation MZPaymentManager

+ (instancetype)shareInstance {
    static MZPaymentManager *paymentManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        paymentManager = [[MZPaymentManager alloc] init];
    });
    return paymentManager;
}

#pragma mark - 微信SDK
+ (BOOL)registerWxApp {
    return [WXApi registerApp:wxAppId universalLink:wxUniversalLink];
}

+ (BOOL)isWXAppInstalled {
    return [WXApi isWXAppInstalled];
}

+ (BOOL)handleOpenUrl:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[MZPaymentManager shareInstance]];
}

+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity {
    return [WXApi handleOpenUniversalLink:userActivity delegate:[MZPaymentManager shareInstance]];
}

+ (void)sendWXPaymentOrder:(NSDictionary *)orderDic callback:(void (^ __nullable)(BOOL success))completionBlock {
    PayReq *payReq = [[PayReq alloc] init];
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
+ (void)processOrderWithPaymentResult:(NSURL *)url standbyCallback:(CompletionBlock)completionBlock {
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:completionBlock];
}

+ (void)processAuthResult:(NSURL *)url auth:(AlipayAuthVersion)alipayAuth standbyCallback:(CompletionBlock)completionBlock {
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

+ (void)sendAliPaymentOrder:(NSString *)orderString auth:(AlipayAuthVersion)alipayAuth callback:(CompletionBlock)completionBlock {
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
