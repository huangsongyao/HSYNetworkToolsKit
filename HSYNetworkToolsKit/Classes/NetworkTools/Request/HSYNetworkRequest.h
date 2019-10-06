//
//  HSYNetworkRequest.h
//  HSYNetworkToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSYNetworkRequest : NSObject

@property (nonatomic, strong) id paramter;                                                      //请求参数
@property (nonatomic, strong) NSArray<NSDictionary *> *requestHeaders;                          //本次请求的新增请求头信息
@property (nonatomic, assign) BOOL showErrorMessage;                                            //如果请求报错，是否显示错误信息
@property (nonatomic, assign) BOOL showResultMessage;                                           //如果请求成功，是否显示成功结果

/**
 通过originalRequestHeaders和self.requestHeaders两个新旧请求头信息，重新整理出一份请求头

 @param originalRequestHeaders 上一次请求的请求头信息
 @return 返回本次请求的请求头信息
 */
- (NSArray<NSDictionary *> *)hsy_networkingRequestHeaders:(NSArray<NSDictionary *> *)originalRequestHeaders;

@end

NS_ASSUME_NONNULL_END
