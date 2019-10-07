//
//  UINavigationBar+Background.h
//  HSYMethodsToolsKit
//
//  Created by anmin on 2019/9/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Background)

- (void)hsy_setNavigationBarBackgroundImage:(UIImage *)backgroundImage;
- (void)hsy_setNavigationBarBottomlineColor:(UIColor *)color;
- (void)hsy_clearNavigationBarBottomline;

@end

NS_ASSUME_NONNULL_END
