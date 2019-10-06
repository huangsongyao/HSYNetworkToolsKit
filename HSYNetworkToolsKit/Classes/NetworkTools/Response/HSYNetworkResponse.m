//
//  HSYNetworkResponse.m
//  HSYNetworkToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import "HSYNetworkResponse.h"

@implementation HSYNetworkResponse

- (instancetype)initWithTask:(NSURLSessionTask *)sessionDataTask
                withResponse:(nullable id)response
                       error:(nullable NSError *)error
          httpRequestMethods:(kHSYNetworkingToolsHttpRequestMethods)requestMethods
{
    if (self = [super init]) {
        _urlSessionDataTask = sessionDataTask;
        _error = error;
        _response = response;
        _httpStatusCode = self.hsy_urlRequestResponseStatusCode;
        _requestMethods = requestMethods;
    }
    return self;
}

- (instancetype)initWithTask:(NSURLSessionTask *)sessionDataTask
                   withError:(NSError *)error
          httpRequestMethods:(kHSYNetworkingToolsHttpRequestMethods)requestMethods
{
    return [self initWithTask:sessionDataTask
                 withResponse:nil
                        error:error
           httpRequestMethods:requestMethods];
} 

- (instancetype)initWithTask:(NSURLSessionTask *)sessionDataTask
                withResponse:(id)response
          httpRequestMethods:(kHSYNetworkingToolsHttpRequestMethods)requestMethods
{
    return [self initWithTask:sessionDataTask
                 withResponse:response
                        error:nil
           httpRequestMethods:requestMethods];
}

- (NSInteger)hsy_urlRequestResponseStatusCode
{
    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)self.urlSessionDataTask.response;
    return urlResponse.statusCode;
}

- (void)hsy_downloadWithCancelDatas:(HSYNetworkResponseDownloadCancelDatasBlock)cancel
{
    NSURLSessionDownloadTask *downloadTask = (NSURLSessionDownloadTask *)self.urlSessionDataTask;
    @weakify(self);
    [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        @strongify(self);
        if (cancel) {
            cancel(self, resumeData);
        }
    }];
}

@end
