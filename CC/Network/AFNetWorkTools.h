//
//  AFNetWorkTools.h
//  CC
//
//  Created by 樊康鹏 on 16/8/26.
//  Copyright © 2016年 FanKaren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoadIMG.h"
#import <AFNetworking.h>
typedef NS_ENUM(NSInteger, RequestMethodType){
    RequestMethodTypePost = 1,
    RequestMethodTypeGet = 2,
    RequestMethodTypePostJson = 3
};


@interface AFNetWorkTools : NSObject
@property (nonatomic ,assign) AFNetworkReachabilityStatus status;
/**
 *  监控网络
 */
+ (void)startMonitoring;
/**
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)shareIntance;
/**
*  发起一个请求
*
*  @param methodType  请求方式
*  @param url         请求URL
*  @param params      请求参数
*  @param contentType contentType
*  @param showLoadImg 是否显示加载动画
*  @param success     请求成功后的回调（请将请求成功后想做的事情写到这个block中）
*  @param failure     请求失败后的回调（请将请求失败后想做的事情写到这个block中）
*/
+ (void) requestWihtMethod:(RequestMethodType)
methodType url : (NSString *)url
                   params:(NSDictionary *)params
                  contentType:(NSSet *)contentType
                  showLoadImg:(BOOL)showLoadImg
                  success:(void (^)(id response))success
                  failure:(void (^)(NSError *err))failure;

/**
 *  取消所有请求
 */
- (void)cancelDataRequest;
@end
