//
//  NSError+Message.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorUserInfoKey const kHSYMethodsToolsKitJSOMModelErrorKey;
static const NSInteger kHSYMethodsToolsKitErrorCode = 20181212;

@interface NSError (Message)

/**
 返回一个JSONModel解析出错后的默认message

 @return JSONModel解析出错后的默认message
 */
+ (NSError *)hsy_defaultJSONModelErrorMessage;

@end

NS_ASSUME_NONNULL_END
