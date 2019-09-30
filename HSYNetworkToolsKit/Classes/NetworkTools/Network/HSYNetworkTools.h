//
//  HSYNetworkTools.h
//  HSYNetworkToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import <Foundation/Foundation.h>
#import "HSYNetworkRequest.h"

NS_ASSUME_NONNULL_BEGIN

typedef NSString *HSYNetworkingToolsBaseUrl;
FOUNDATION_EXPORT HSYNetworkingToolsBaseUrl const _Nullable HSYNetworkingToolsBaseUrlStringForKey;

typedef NSString *HSYNetworkingToolsHttpSession;
FOUNDATION_EXPORT HSYNetworkingToolsHttpSession const _Nullable HSYNetworkingToolsHttpRequestSerializerForKey;
FOUNDATION_EXPORT HSYNetworkingToolsHttpSession const _Nullable HSYNetworkingToolsHttpResponseSerializerForKey;
FOUNDATION_EXPORT HSYNetworkingToolsHttpSession const _Nullable HSYNetworkingToolsHttpRequestCachePolicyForKey;
FOUNDATION_EXPORT HSYNetworkingToolsHttpSession const _Nullable HSYNetworkingToolsHttpRequestTimeoutForKey;
FOUNDATION_EXPORT HSYNetworkingToolsHttpSession const _Nullable HSYNetworkingToolsHttpResponseContentTypesForKey;
FOUNDATION_EXPORT HSYNetworkingToolsHttpSession const _Nullable HSYNetworkingToolsHttpRequestHeadersForKey;

typedef NSString *HSYNetworkingToolsUrlSession;
FOUNDATION_EXPORT HSYNetworkingToolsUrlSession const _Nullable HSYNetworkingToolsUrlResponseSerializerForKey;
FOUNDATION_EXPORT HSYNetworkingToolsUrlSession const _Nullable HSYNetworkingToolsUrlSecurityPolicyForKey;

@class RACSignal;
@interface HSYNetworkTools : NSObject

/**
 单例
 
 @return XQCNetworkingTools
 */
+ (instancetype)sharedInstance;

/**
 清空请求头的信息
 */
- (void)hsy_clearAllHeaders;

#pragma mark - Configs

/**
 配置base-url的域名地址
 
 @param configs 配置项，@{kXQCNetworkingToolsBaseUrl : @"http://..."}
 */
- (void)hsy_baseUrlStringConfigs:(NSDictionary<HSYNetworkingToolsBaseUrl, NSString *> *)configs;

/**
 配置http请求的session的相关内容
 
 @param configs 配置项，@{XQCNetworkingToolsHttpRequestSerializerForKey : id, ...}
 */
- (void)hsy_httpSessionConfigs:(NSDictionary<HSYNetworkingToolsHttpSession, id> *)configs;

/**
 配置http下的file download或者file upload的相关内容
 
 @param configs 配置项，@{XQCNetworkingToolsUrlResponseSerializerForKey : id, ...}
 */
- (void)hsy_urlSessionConfigs:(NSDictionary<HSYNetworkingToolsUrlSession, id> *)configs;

#pragma mark - Methods

/**
 http-get请求

 @param path 请求的url
 @param paramter 请求参数
 @return RACSignal
 */
- (RACSignal *)hsy_requestByGet:(NSString *)path
                requestParamter:(HSYNetworkRequest *)paramter;

/**
 http-get请求
 
 @param path 请求的url
 @param paramter 请求参数
 @return RACSignal
 */
- (RACSignal *)hsy_requestByGet:(NSString *)path
                       paramter:(NSDictionary *)paramter;

/**
 http-post请求
 
 @param path 请求的url
 @param paramter 请求参数
 @return RACSignal
 */
- (RACSignal *)hsy_requestByPost:(NSString *)path
                 requestParamter:(HSYNetworkRequest *)paramter;

/**
 http-post请求
 
 @param path 请求的url
 @param paramter 请求参数
 @return RACSignal
 */
- (RACSignal *)hsy_requestByPost:(NSString *)path
                        paramter:(NSDictionary *)paramter;


@end

NS_ASSUME_NONNULL_END
