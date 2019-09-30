//
//  HSYNetworkTools.m
//  HSYNetworkToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import "HSYNetworkTools.h"
#import <AFNetworking/AFNetworking.h>
#import "HSYToolsMacro.h"

//请求域名的配置key
HSYNetworkingToolsBaseUrl const HSYNetworkingToolsBaseUrlStringForKey                          = @"baseUrlString";

//AFHTTPSessionManager的http管理者的配置key
HSYNetworkingToolsHttpSession const HSYNetworkingToolsHttpRequestSerializerForKey              = @"hsy_setRequestSerializer:";
HSYNetworkingToolsHttpSession const HSYNetworkingToolsHttpResponseSerializerForKey             = @"hsy_setResponseSerializer:";
HSYNetworkingToolsHttpSession const HSYNetworkingToolsHttpRequestCachePolicyForKey             = @"hsy_setCachePolicy:";
HSYNetworkingToolsHttpSession const HSYNetworkingToolsHttpRequestTimeoutForKey                 = @"hsy_setTimeoutInterval:";
HSYNetworkingToolsHttpSession const HSYNetworkingToolsHttpResponseContentTypesForKey           = @"hsy_setAcceptableContentTypes:";
HSYNetworkingToolsHttpSession const HSYNetworkingToolsHttpRequestHeadersForKey                 = @"hsy_setHeaders:";

//AFURLSessionManager的配置key
HSYNetworkingToolsUrlSession const HSYNetworkingToolsUrlResponseSerializerForKey               = @"hsy_setUrlResponseSerializer:";
HSYNetworkingToolsUrlSession const HSYNetworkingToolsUrlSecurityPolicyForKey                   = @"hsy_setUrlSecurityPolicy:";

static HSYNetworkTools *networkTools = nil;

//*****************************************************************************************************************************************

@interface AFURLSessionManager (Private)

- (void)hsy_setUrlResponseSerializer:(id<AFURLResponseSerialization>)responseSerializer;
- (void)hsy_setUrlSecurityPolicy:(AFSecurityPolicy *)securityPolicy;

@end

@implementation AFURLSessionManager (Private)

- (void)hsy_setUrlResponseSerializer:(id<AFURLResponseSerialization>)responseSerializer
{
    if (responseSerializer) {
        self.responseSerializer = responseSerializer;
    }
}

- (void)hsy_setUrlSecurityPolicy:(AFSecurityPolicy *)securityPolicy
{
    if (securityPolicy) {
        self.securityPolicy = securityPolicy;
    }
}

@end

//*****************************************************************************************************************************************

@interface AFHTTPSessionManager (Private)

- (void)hsy_setHeaders:(NSArray<NSDictionary *> *)headers;
- (void)hsy_setRequestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer;
- (void)hsy_setResponseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer;
- (void)hsy_setTimeoutInterval:(NSNumber *)interval;
- (void)hsy_setAcceptableContentTypes:(NSArray *)contentTypes;
- (void)hsy_setCachePolicy:(NSNumber *)cachePolicy;

@end

@implementation AFHTTPSessionManager (Private)

- (void)hsy_setHeaders:(NSArray<NSDictionary *> *)headers
{
    for (NSDictionary *header in headers) {
        [self.requestSerializer setValue:header.allValues.firstObject forHTTPHeaderField:header.allKeys.firstObject];
    }
}

- (void)hsy_setRequestSerializer:(AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer
{
    if (requestSerializer) {
        self.requestSerializer = requestSerializer;
    }
}

- (void)hsy_setResponseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
{
    if (responseSerializer) {
        self.responseSerializer = responseSerializer;
    }
}

- (void)hsy_setTimeoutInterval:(NSNumber *)interval
{
    if (interval) {
        [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.requestSerializer.timeoutInterval = interval.doubleValue;
        [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
}

- (void)hsy_setAcceptableContentTypes:(NSArray *)contentTypes
{
    if (!contentTypes.count) {
        NSSet *acceptableContentTypes = [NSSet setWithArray:contentTypes];
        self.responseSerializer.acceptableContentTypes = acceptableContentTypes;
    }
}

- (void)hsy_setCachePolicy:(NSNumber *)cachePolicy
{
    if (cachePolicy) {
        self.requestSerializer.cachePolicy = (NSURLRequestCachePolicy)cachePolicy.integerValue;
    }
}

@end

//*****************************************************************************************************************************************

@interface HSYNetworkTools () {
    @private NSString *baseUrlString;
}

@property (nonatomic, strong) AFHTTPSessionManager *hsy_httpSessionManager;
@property (nonatomic, strong) AFURLSessionManager *hsy_urlSessionManager;

@end

@implementation HSYNetworkTools

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        networkTools = [HSYNetworkTools new];
    });
    return networkTools;
}

#pragma mark - Getter

- (AFHTTPSessionManager *)hsy_httpSessionManager
{
    if (!_hsy_httpSessionManager) {
        _hsy_httpSessionManager = [AFHTTPSessionManager manager];
        _hsy_httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"image/jpeg", @"text/plain", nil];
    }
    return _hsy_httpSessionManager;
}

- (AFURLSessionManager *)hsy_urlSessionManager
{
    if (!_hsy_urlSessionManager) {
        NSURLSessionConfiguration *urlConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _hsy_urlSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:urlConfiguration];
    }
    return _hsy_urlSessionManager;
}

#pragma mark - Clear ---> Headers

- (void)clearAllHeaders
{
    [self.hsy_httpSessionManager.requestSerializer clearAuthorizationHeader];
}

- (NSArray<NSDictionary *> *)originalRequestHeaders
{
    NSDictionary *requestHeaders = self.hsy_httpSessionManager.requestSerializer.HTTPRequestHeaders;
    NSMutableArray<NSDictionary *> *realRequestHeaders = [NSMutableArray arrayWithCapacity:requestHeaders.allKeys.count];
    for (NSString *forKey in requestHeaders.allKeys) {
        [realRequestHeaders addObject:@{forKey : requestHeaders[forKey]}];
    }
    return realRequestHeaders;
}

#pragma mark - Base Url

- (void)baseUrlStringConfigs:(NSDictionary<HSYNetworkingToolsBaseUrl, NSString *> *)configs
{
    NSLog(@"\n ========================================================================== ");
    baseUrlString = configs[HSYNetworkingToolsBaseUrlStringForKey];
    NSLog(@"\n alert --> baseUrlString = %@", baseUrlString);
    NSLog(@"\n ========================================================================== ");
    NSParameterAssert(baseUrlString);
    NSParameterAssert([baseUrlString hasPrefix:@"http"]);
}

- (NSString *)networkingToolUrlString:(NSString *)urlPath
{
    NSString *url = [NSString stringWithFormat:@"%@%@", baseUrlString, urlPath];
    return url;
}

#pragma mark - Configs

- (void)hsy_httpSessionConfigs:(NSDictionary<HSYNetworkingToolsHttpSession, id> *)configs
{
    //防止无序键值对的覆盖，因此requestSerializer和responseSerializer需要优先设置
    if ([configs.allKeys containsObject:HSYNetworkingToolsHttpRequestSerializerForKey]) {
        AFHTTPRequestSerializer<AFURLRequestSerialization> *requestSerializer = configs[HSYNetworkingToolsHttpRequestSerializerForKey];
        [self.hsy_httpSessionManager hsy_setRequestSerializer:requestSerializer];
    }
    if ([configs.allKeys containsObject:HSYNetworkingToolsHttpResponseSerializerForKey]) {
        AFHTTPResponseSerializer<AFURLResponseSerialization> *responseSerializer =  configs[HSYNetworkingToolsHttpResponseSerializerForKey];
        [self.hsy_httpSessionManager hsy_setResponseSerializer:responseSerializer];
    }
    //遍历配置项，所有非requestSerializer和responseSerializer的项根据SEL方法名称配置
    for (HSYNetworkingToolsHttpSession httpSessionForKey in configs.allKeys) {
        if ([httpSessionForKey isEqualToString:HSYNetworkingToolsHttpRequestSerializerForKey] || [httpSessionForKey isEqualToString:HSYNetworkingToolsHttpResponseSerializerForKey]) {
            continue;
        }
        HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.hsy_httpSessionManager performSelector:NSSelectorFromString(httpSessionForKey) withObject:configs[httpSessionForKey]]);
    }
}

- (void)hsy_urlSessionConfigs:(NSDictionary<HSYNetworkingToolsUrlSession, id> *)configs
{
    //防止无序键值对的覆盖，因此responseSerializer需要优先设置
    if ([configs.allKeys containsObject:HSYNetworkingToolsUrlResponseSerializerForKey]) {
        id<AFURLResponseSerialization>serialization = configs[HSYNetworkingToolsUrlResponseSerializerForKey];
        [self.hsy_urlSessionManager hsy_setUrlResponseSerializer:serialization];
    }
    //遍历配置项，所有非responseSerializer的项根据SEL方法名称配置
    for (HSYNetworkingToolsUrlSession urlSessionForKey in configs.allKeys) {
        if ([urlSessionForKey isEqualToString:HSYNetworkingToolsUrlResponseSerializerForKey]) {
            continue;
        }
        HSYCOCOAKIT_IGNORED_SUPPRESS_PERFORM_SELECTOR_LEAK_WARNING([self.hsy_urlSessionManager performSelector:NSSelectorFromString(urlSessionForKey) withObject:configs[urlSessionForKey]]);
    }
}

#pragma mark - Methods

//- (RACSignal *)hsy_requestByGet:(NSString *)path requestParamter:(HSYNetworkRequest *)paramter
//{
//    if (paramter.requestHeaders.count) {
//        NSDictionary *originalRequestHeaders = [self.originalRequestHeaders mutableCopy];
//        NSArray<NSDictionary *> *requestHeaders = [paramter networkingRequestHeaders:originalRequestHeaders];
//        [self clearAllHeaders];
//        [self.hsy_httpSessionManager xqc_setHeaders:requestHeaders];
//    }
//    return [self xqc_requestByGet:path paramter:paramter.paramter];
//}
//
//- (RACSignal *)hsy_requestByGet:(NSString *)path paramter:(NSDictionary *)paramter
//{
//    NSString *url = [self networkingToolUrlString:path];
//    return [self.hsy_httpSessionManager xqc_getRequest:url paramters:path];
//}
//
//- (RACSignal *)hsy_requestByPost:(NSString *)path requestParamter:(HSYNetworkRequest *)paramter
//{
//    
//}
//
//- (RACSignal *)hsy_requestByPost:(NSString *)path paramter:(NSDictionary *)paramter
//{
//    
//}


@end
