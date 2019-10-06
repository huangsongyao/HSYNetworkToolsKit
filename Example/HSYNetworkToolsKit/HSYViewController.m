//
//  HSYViewController.m
//  HSYNetworkToolsKit
//
//  Created by 317398895@qq.com on 09/26/2019.
//  Copyright (c) 2019 317398895@qq.com. All rights reserved.
//

#import "HSYViewController.h"
#import "HSYNetworkRequest.h"

@interface HSYViewController ()

@end

@implementation HSYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HSYNetworkRequest *request = [[HSYNetworkRequest alloc] init];
    request.requestHeaders = @[@{@"1" : @"new"}, @{@"5" : @"value"}, @{@"4" : @"new2"},];
    NSArray *as = [request hsy_networkingRequestHeaders:@[@{@"1" : @"value"}, @{@"2" : @"value"}, @{@"3" : @"value"}, @{@"4" : @"value"}, ]];
    NSLog(@"%@", as);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
