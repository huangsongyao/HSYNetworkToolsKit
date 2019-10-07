//
//  RACSignal+Timer.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal (Timer)

/**
 返回一个主线程计时器

 @param intervals 计时器触发间隔时间
 @param maxIntervals 计时器最大边界时间
 @param next 计时器触发事件回调事件
 @return RACDisposable
 */
+ (RACDisposable *)hsy_timerSignal:(NSTimeInterval)intervals
                 timerMaxIntervals:(NSTimeInterval)maxIntervals
                     subscribeNext:(BOOL(^)(NSDate *date, NSTimeInterval interval))next;

@end

NS_ASSUME_NONNULL_END
