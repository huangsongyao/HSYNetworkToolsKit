//
//  NSBundle+PrivateFileResource.m
//  HSYMethodsToolsKit
//
//  Created by huangsongyao on 2019/9/26.
//

#import "NSBundle+PrivateFileResource.h"

@implementation NSBundle (PrivateFileResource)

+ (UIImage *)hsy_imageForBundle:(NSString *)imageName
{
    NSBundle *resourceBundle = [NSBundle hsy_resourceBundle];
    UIImage *image = [UIImage imageNamed:imageName
                                inBundle:resourceBundle
           compatibleWithTraitCollection:nil];
    
    return image;
}

+ (NSBundle *)hsy_resourceBundle
{
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"HSYBaseViewController")];
    NSString *bundleName = bundle.infoDictionary[@"CFBundleName"];
    NSURL *bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    if (!bundleURL) {
        bundleName = @"HSYCocoaKit";
        bundleURL = [bundle URLForResource:bundleName withExtension:@"bundle"];
    }
    NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
    return resourceBundle;
}

@end
