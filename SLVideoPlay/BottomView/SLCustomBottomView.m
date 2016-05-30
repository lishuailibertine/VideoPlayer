
//
//  SLCustomBottomView.m
//  SLCustPlayerControll
//
//  Created by shuaili on 14-7-15.
//  Copyright (c) 2014年 shuaili. All rights reserved.
//

#import "SLCustomBottomView.h"
#import "XCProgressSlider.h"

#define SECOND_FRAMENT(s,a) [self convertTime:s append:a];

@interface SLCustomBottomView ()<XCProgressSliderDelegate>
{
  
    XCProgressSlider *_progressSlider;
    UILabel *_playTimeLaber;
    UILabel *_totalTimeLaber;
    UIButton * _btn;
}
@end
@implementation SLCustomBottomView
@synthesize playing=_playing;
@synthesize delegate=_delegate;
@synthesize sliderProgressValue=_sliderProgressValue,sliderValue=_sliderValue;
@synthesize playingTime=_playingTime,totalTime=_totalTime;

- (void)dealloc
{
    [super dealloc];
  
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =[UIColor colorWithRed:0. green:0. blue:0. alpha:0.8];
        [self configuration];
        _totalTime = 0.;
        _playingTime = 0.;
    }
    return self;
}
- (void)configuration
{
    _playTimeLaber =[[UILabel alloc] initWithFrame:(CGRect){{self.frame.size.width-100,22},{50,30}}];
    _playTimeLaber.backgroundColor =[UIColor clearColor];
    _playTimeLaber.text = SECOND_FRAMENT(_playingTime,@"/");
    [self addSubview:_playTimeLaber];
    [_playTimeLaber release];

  
    _totalTimeLaber =[[UILabel alloc] initWithFrame:(CGRect){{self.frame.size.width-50,22},{50,30}}];
    _totalTimeLaber.backgroundColor =[UIColor clearColor];
    _totalTimeLaber.text = SECOND_FRAMENT(_totalTime,nil);
    [self addSubview:_totalTimeLaber];
    [_totalTimeLaber release];

}
#pragma -------setters
- (void)setTotalTime:(float)totalTime
{
    _totalTime = totalTime;
    
    _totalTimeLaber.text = SECOND_FRAMENT(_totalTime,nil);
}

- (void)setPlayingTime:(float)playingTime
{
    _playingTime = playingTime;
    
    _playTimeLaber.text = SECOND_FRAMENT(_playingTime,@"/");
}

- (void)setSliderProgressValue:(float )sliderProgressValue
{

    if (!sliderProgressValue) {
        return;
    }
    _sliderProgressValue=sliderProgressValue;
    _progressSlider.progress=sliderProgressValue;

}
- (void)setSliderValue:(float )sliderValue
{
    if (!sliderValue) {
        return;
    }
    _sliderValue=sliderValue;
    _progressSlider.value=sliderValue;

}
- (void)setPlaying:(BOOL)playing
{
    if (_playing==playing) {
        return;
    }
    _playing=playing;
    
    if (!_btn) {
        return;
    }
    [self _setBtnState:_btn playing:playing];
}
#pragma-----Private function

- (void)_setBtnState:(UIButton *)sender playing:(BOOL)play
{

    if (play) {
        [sender setBackgroundImage:[UIImage imageNamed:@"play2.png"] forState:UIControlStateNormal];
    }else{
        
        [sender setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    }

}
#pragma-----layoutSubviews
- (void)layoutSubviews
{
    _btn =[UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame =CGRectMake(10, 8, 30, 30);
    [_btn addTarget:self action:@selector(checkingBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_btn setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self addSubview:_btn];
    
    _progressSlider =[[XCProgressSlider alloc]initWithFrame:CGRectMake(45, 13, 200, 16)];
    _progressSlider.delegate=self;
    _progressSlider.value=0.0f;
    _progressSlider.progress=0.0f;
    [self addSubview:_progressSlider];
    [_progressSlider release];

}
#pragma-----BUTTON--controll
- (void)checkingBtn:(UIButton *)sender
{
 
    _playing=!_playing;
    [self _setBtnState:sender playing:_playing];
    
    if ([_delegate respondsToSelector:@selector(playerIsPlayingYesOrNo:)]) {
        [_delegate playerIsPlayingYesOrNo:self];
    }

}
#pragma-----XCProgressSliderDelegate
- (void)progressSliderDidMoveEnd:(XCProgressSlider *)progressSlider value:(float)vlaue
{

    if ([_delegate respondsToSelector:@selector(progressSliderDidMoveEnd:value:)]) {
        [_delegate progressSliderDidMoveEnd:self value:vlaue];
    }

}
- (void)progressSliderDidStart:(XCProgressSlider *)progressSlider value:(float)vlaue
{
    if ([_delegate respondsToSelector:@selector(progressSliderDidStart:value:)]) {
        [_delegate progressSliderDidStart:self value:vlaue];
    }

}


#pragma mark -
#pragma mark Kit

- (NSString *)convertTime:(CGFloat)second append:(NSString *)append
{
    NSMutableString *str = [NSMutableString string];
    int m = second/60;
    if (m <= 9)
    {
        [str appendFormat:@"0%d",m];
    }
    else
        [str appendFormat:@"%d",m];
    
    int s = (int)second%60;
    if (s <= 9)
    {
        [str appendFormat:@":0%d",s];
    }
    else
        [str appendFormat:@":%d",s];
    
    if (append)
    {
        [str appendString:append];
    }
    
    return str;
}

@end
