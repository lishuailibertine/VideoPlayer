//
//  SLCustomBottomView.h
//  SLCustPlayerControll
//
//  Created by shuaili on 14-7-15.
//  Copyright (c) 2014年 shuaili. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLCustomBottomView;
@protocol  SLCustomBottomViewDelegate <NSObject>

@optional

- (void)playerIsPlayingYesOrNo:(SLCustomBottomView*)bottom;
- (void)progressSliderDidStart:(SLCustomBottomView *)progressSlider value:(float)vlaue;
- (void)progressSliderDidMoveEnd:(SLCustomBottomView *)progressSlider value:(float)vlaue;
@end

@interface SLCustomBottomView : UIView
{
    BOOL _playing;
    id<SLCustomBottomViewDelegate>_delegate;
    float   _sliderValue;
    float   _sliderProgressValue;
    
    float _totalTime,_playingTime;
}
@property (nonatomic)BOOL playing;
@property (nonatomic,assign) id<SLCustomBottomViewDelegate>delegate;
@property (nonatomic,assign) float   sliderValue;
@property (nonatomic,assign) float   sliderProgressValue;

@property (nonatomic,assign) float totalTime;
@property (nonatomic,assign) float playingTime;

@end
