//
//  UIApplication+OpenURL.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/27.
//

#import <UIKit/UIKit.h>
#import "HSYToolsMacro.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (OpenURL)

/**
 调用系统的第三方用于
 
 @param url 完整的url地址
 
 @return YES表示可以打开，NO相反
 */
+ (BOOL)hsy_developerOpenURL:(NSURL *)url;

/**
 通过http开头的url打开safari浏览器
 
 @param url 完整的url地址
 
 @return YES表示可以打开，NO相反
 */
+ (BOOL)hsy_openSafari:(NSString *)url;

/**
 >= iOS9系统下，通过Safari_framework，在app内部调起Safari浏览器
 
 @param url 完整的url地址
 */
+ (void)hsy_openSafariServer:(NSString *)url HSY_AVAILABLE_IOS_9;

/**
 >= iOS8系统下，通过完整的url打开系统设置
 */
+ (void)hsy_openSystemSetting HSY_AVAILABLE_IOS_8; 

@end

NS_ASSUME_NONNULL_END
