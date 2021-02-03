//
//  MZPaymentManager.h
//  MZPayment
//
//  Created by Mr.Z on 2021/1/4.
//

#import <Foundation/Foundation.h>
#import <AliPaySDK/AliPaySDK.h>
#import <WechatOpenSDK/WXApi.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AlipayAuthVersion) {
    AlipayAuthV1 = 1,
    AlipayAuthV2 = 2
};

@interface MZPaymentManager : NSObject

+ (instancetype)shareInstance;

/*! @brief 向微信终端程序注册第三方应用
 *
 * @return 成功返回YES,失败返回NO
 */
+ (BOOL)registerWxApp;

/*! @brief 检查微信是否已被用户安装
 *
 * @return 微信已安装返回YES,未安装返回NO
 */
+ (BOOL)isWXAppInstalled;

/*! @brief 微信通过URL启动App时传递的数据
 *
 * 需要在application:openURL:sourceApplication:annotation:或者application:handleOpenURL中调用
 * @param url 微信启动第三方应用时传递过来的URL
 * @return 成功返回YES,失败返回NO
 */
+ (BOOL)handleOpenUrl:(NSURL *)url;

/*! @brief 处理微信通过Universal Link启动App时传递的数据
 *
 *  需要在application:continueUserActivity:restorationHandler:中调用
 *  @param userActivity 微信启动第三方应用时系统API传递过来的userActivity
 *  @return 成功返回YES,失败返回NO
 */
+ (BOOL)handleOpenUniversalLink:(NSUserActivity *)userActivity;

/*! @brief 支付接口
 *
 *  @param orderDic 支付订单信息
 *  @param completionBlock 支付结果回调Block,用于支付结果回调
 */
+ (void)sendWXPaymentOrder:(NSDictionary *)orderDic callback:(void (^ __nullable)(BOOL success))completionBlock;

/*! @brief 处理支付宝支付后跳回商户携带的支付结果URL
 *
 *  @param url 支付宝返回的支付结果URL
 *  @param completionBlock 支付结果回调,为nil时默认使用支付接口的completionBlock
 */
+ (void)processOrderWithPaymentResult:(NSURL *)url standbyCallback:(CompletionBlock)completionBlock;

/*! @brief 处理支付宝授权后跳回商户携带的授权结果URL
 *
 *  @param url 支付宝返回的授权结果URL
 *  @param alipayAuth 支付宝授权版本
 *  @param completionBlock 授权结果回调,用于处理跳转支付宝授权过程中商户被系统终止的情况
 */
+ (void)processAuthResult:(NSURL *)url auth:(AlipayAuthVersion)alipayAuth standbyCallback:(CompletionBlock)completionBlock;

/*! @brief 支付接口
 *
 *  @param orderString 支付订单信息字串
 *  @param alipayAuth 支付宝授权版本
 *  @param completionBlock 支付结果回调Block,用于支付结果回调,跳转支付宝支付时只有当processOrderWithPaymentResult接口的completionBlock为nil时会使用这个bolock
 */
+ (void)sendAliPaymentOrder:(NSString *)orderString auth:(AlipayAuthVersion)alipayAuth callback:(CompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
