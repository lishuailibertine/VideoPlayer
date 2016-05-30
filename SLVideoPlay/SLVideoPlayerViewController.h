//
//  SLVideoPlayerViewController.h
//  SLVideoPlay
//
//  Created by shuaili on 14-7-11.
//  Copyright (c) 2014年 shuaili. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SLalertViewRemindState) {
    SLalertViewRemindStateNetNotBest = 0,
    SLalertViewRemindStateNetVideoBad,
};
@interface SLVideoPlayerViewController : UIViewController

@property (nonatomic)SLalertViewRemindState alertViewRemindState;

@end
