//
//  NSError+Message.m
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import "NSError+Message.h"

FOUNDATION_EXPORT NSErrorDomain const kHSYMethodsToolsKitJSOMModelErrorDomain;
NSErrorDomain const kHSYMethodsToolsKitJSOMModelErrorDomain = @"HSYMethodsToolsKitJSOMModelErrorDomain";
NSErrorUserInfoKey const kHSYMethodsToolsKitJSOMModelErrorKey = @"HSYMethodsToolsKitJSOMModelErrorKey";

@implementation NSError (Message)

+ (NSError *)hsy_defaultJSONModelErrorMessage
{
    NSError *error = [[NSError alloc] initWithDomain:kHSYMethodsToolsKitJSOMModelErrorDomain
                                                code:kHSYMethodsToolsKitErrorCode
                                            userInfo:@{kHSYMethodsToolsKitJSOMModelErrorKey : @"JSONModel解析报错，出错原因可能为json数据为nil或解析的json对象不是[NSDictionary或NSArray]！请检查"}];
    return error;
}

@end
