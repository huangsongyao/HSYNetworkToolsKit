//
//  HSYNetworkResponse.h
//  HSYNetworkToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager+RACSignal.h"

NS_ASSUME_NONNULL_BEGIN

@class HSYNetworkResponse;
typedef void(^HSYNetworkResponseDownloadCancelDatasBlock)(HSYNetworkResponse *networkResponse, NSData *data);

@interface HSYNetworkResponse : NSObject

@property (nonatomic, strong) NSURLSessionTask *urlSessionDataTask;                             //session请求任务
@property (nonatomic, strong, readonly, nullable) NSError *error;                               //错误信息
@property (nonatomic, strong, readonly, nullable) id response;                                  //response的JSON结果
@property (nonatomic, assign, readonly) NSInteger httpStatusCode;                               //HTTP超文本传输协议的结果
@property (nonatomic, assign, readonly) kHSYNetworkingToolsHttpRequestMethods requestMethods;   //请求方法类型

/**
 快速创建

 @param sessionDataTask 短连接、下载任务、上传任务的session
 @param response session任务结果
 @param error session任务失败信息
 @param requestMethods session任务的类型枚举
 @return HSYNetworkResponse
 */
- (instancetype)initWithTask:(NSURLSessionTask *)sessionDataTask
                withResponse:(nullable id)response
                       error:(nullable NSError *)error
          httpRequestMethods:(kHSYNetworkingToolsHttpRequestMethods)requestMethods;
- (instancetype)initWithTask:(NSURLSessionTask *)sessionDataTask
                withResponse:(id)response
          httpRequestMethods:(kHSYNetworkingToolsHttpRequestMethods)requestMethods;
- (instancetype)initWithTask:(NSURLSessionTask *)sessionDataTask
                   withError:(NSError *)error
          httpRequestMethods:(kHSYNetworkingToolsHttpRequestMethods)requestMethods;

/**
 下载任务失败后返回已经下载好的数据

 @param cancel HSYNetworkResponseDownloadCancelDatasBlock block
 */
- (void)hsy_downloadWithCancelDatas:(HSYNetworkResponseDownloadCancelDatasBlock)cancel;

@end

NS_ASSUME_NONNULL_END
