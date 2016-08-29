//
//  AFNetWorkTools.m
//  CC
//
//  Created by 樊康鹏 on 16/8/26.
//  Copyright © 2016年 FanKaren. All rights reserved.
//

#import "AFNetWorkTools.h"


@interface AFNetWorkTools ()
@property (nonatomic, strong)AFHTTPSessionManager * manager;
@end

@implementation AFNetWorkTools
+ (instancetype)shareIntance
{
    static AFNetWorkTools *tools = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tools = [[AFNetWorkTools alloc]init];
        tools.manager = [[AFHTTPSessionManager alloc] init];
        tools.manager.requestSerializer.timeoutInterval = 5.0f;
        
    });
    return tools;
}
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
+ (void)requestWihtMethod:(RequestMethodType)methodType url:(NSString *)url params:(NSDictionary *)params contentType:(NSSet *)contentType showLoadImg:(BOOL)showLoadImg success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    if ([AFNetWorkTools shareIntance].status == AFNetworkReachabilityStatusNotReachable) {
        //无网络
        failure(nil);
        return;
    }
    url = [self DealWithUrl:url];
    LoadIMG *loadImg = [[LoadIMG alloc] init];
    if (showLoadImg) {
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        [window addSubview:loadImg];
    }

    if (contentType) {
        [AFNetWorkTools shareIntance].manager.responseSerializer.acceptableContentTypes = contentType;
        [AFNetWorkTools shareIntance].manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [AFNetWorkTools shareIntance].manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    switch (methodType) {
        case RequestMethodTypeGet:
        {
            [[AFNetWorkTools shareIntance].manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSError *err = nil;
                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
                    if (err) {
                        failure(err);
                    }else
                        success(dict);
                }else{
                    success(responseObject);
                }
                [loadImg removeFromSuperview];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
                 [loadImg removeFromSuperview];
            }];
        }
            break;
        case RequestMethodTypePost:
        {
            [[AFNetWorkTools shareIntance].manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if ([responseObject isKindOfClass:[NSData class]]) {
                    NSError *err = nil;
                    NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
                    if (err) {
                        failure(err);
                    }else
                        success(dict);
                }else{
                    success(responseObject);
                }
                 [loadImg removeFromSuperview];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(error);
                 [loadImg removeFromSuperview];
            }];
        }
            break;
        case RequestMethodTypePostJson:
        {
            NSError * err = nil;
            NSMutableURLRequest * requets =[[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:params error:&err];
            AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            NSURLSessionUploadTask *uploadTask;
            uploadTask = [manager1 uploadTaskWithStreamedRequest:requets progress:nil completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                 [loadImg removeFromSuperview];
                if (error) {
                    failure(err);
                } else {
                    if ([responseObject isKindOfClass:[NSData class]]) {
                        NSError *err = nil;
                        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
                        success(dict);
                    }else{
                        success(responseObject);
                    }
                }
            }];
            [uploadTask resume];
        }
            break;
            
        default:
            break;
    }
    
    
}
- (void)cancelDataRequest
{
    [self.manager.operationQueue cancelAllOperations];
}
/**
 *  处理URL
 *
 *  @param url URL
 *
 *  @return 处理后的URL
 */
+ (NSString *)DealWithUrl:(NSString *)url
{
    return url;
}

#pragma makr - 开始监听网络连接

+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [AFNetWorkTools shareIntance].status = [AFNetWorkTools networkingStatesFromStatebar];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        [AFNetWorkTools shareIntance].status =status;
    }];
    [mgr startMonitoring];
}
/**
 *  判断网络
 *
 *  @return 网络状态
 */
+ (NSUInteger )networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    return type;
//    NSString *stateString = @"wifi";
//    
//    switch (type) {
//        case 0:
//            stateString = @"notReachable";
//            break;
//            
//        case 1:
//            stateString = @"2G";
//            break;
//            
//        case 2:
//            stateString = @"3G";
//            break;
//            
//        case 3:
//            stateString = @"4G";
//            break;
//            
//        case 4:
//            stateString = @"LTE";
//            break;
//            
//        case 5:
//            stateString = @"wifi";
//            break;
//            
//        default:
//            break;
//    }
    

}
@end
