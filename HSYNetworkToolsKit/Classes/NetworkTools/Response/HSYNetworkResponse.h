//
//  HSYNetworkResponse.h
//  HSYNetworkToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSYNetworkResponse : NSObject

@property (nonatomic, strong) NSURLSessionDataTask *urlSessionDataTask;
@property (nonatomic, strong, readonly) NSError *error;
@property (nonatomic, strong, readonly) id response;
@property (nonatomic, assign, readonly) NSInteger httpStatusCode;

@property (nonatomic, strong) id paramter;
@property (nonatomic, strong) NSArray<NSDictionary *> *requestHeaders;
@property (nonatomic, assign) BOOL showErrorMessage;
@property (nonatomic, assign) BOOL showResultMessage;

- (NSArray<NSDictionary *> *)networkingRequestHeaders:(NSArray<NSDictionary *> *)originalRequestHeaders;

@end

NS_ASSUME_NONNULL_END
