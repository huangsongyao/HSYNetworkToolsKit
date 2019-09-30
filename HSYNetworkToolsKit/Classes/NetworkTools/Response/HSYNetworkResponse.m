//
//  HSYNetworkResponse.m
//  HSYNetworkToolsKit
//
//  Created by anmin on 2019/9/30.
//

#import "HSYNetworkResponse.h"

@interface NSArray (Keys)

- (NSArray<NSString *> *)originalRequestHeaderKeys;

@end

@implementation NSArray (Keys)

- (NSArray<NSString *> *)originalRequestHeaderKeys
{
    NSMutableArray<NSString *> *originalRequestHeaderKeys = [NSMutableArray arrayWithCapacity:self.count];
    for (NSDictionary *originalHeader in self) {
        [originalRequestHeaderKeys addObject:originalHeader.allKeys.firstObject];
    }
    return originalRequestHeaderKeys.mutableCopy;
}

@end

@implementation HSYNetworkResponse

- (NSArray<NSDictionary *> *)networkingRequestHeaders:(NSArray<NSDictionary *> *)originalRequestHeaders
{
    NSMutableArray<NSDictionary *> *requestHeaders = [[NSMutableArray alloc] initWithArray:self.requestHeaders];
    NSArray<NSString *> *originalRequestHeaderKeys = originalRequestHeaders.originalRequestHeaderKeys;
    for (NSDictionary *originalHeader in originalRequestHeaderKeys) {
//        if ([]) {
//            <#statements#>
//        }
    }
    return @[];
}

@end
