//
//  AppDelegate.m
//  SLVideoPlay
//
//  Created by shuaili on 14-7-11.
//  Copyright (c) 2014年 shuaili. All rights reserved.
//

#import "AppDelegate.h"
#import "SLVideoPlayerViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    SLVideoPlayerViewController *sLVideoPlayerViewController =[[SLVideoPlayerViewController alloc]init];
    self.window.rootViewController =sLVideoPlayerViewController;
    [self.window makeKeyAndVisible];
    [sLVideoPlayerViewController release];
    
    
    return YES;
}



@end
