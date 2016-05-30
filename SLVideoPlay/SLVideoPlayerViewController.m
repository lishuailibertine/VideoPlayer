//
//  SLVideoPlayerViewController.m
//  SLVideoPlay
//
//  Created by shuaili on 14-7-11.
//  Copyright (c) 2014年 shuaili. All rights reserved.
//
static NSString * const LSViewControllerVideoPath = @"http://www.cs.vu.nl/~eliens/assets/media/street/code.mp4";

#import "SLVideoPlayerViewController.h"
#import "SLVideoView.h"
#import "SLCustomBottomView.h"
@interface SLVideoPlayerViewController ()<SLVideoViewDelegate,SLCustomBottomViewDelegate>
{
    SLVideoView *_slVideoView;
    SLCustomBottomView *_bottomView;
    UIImageView *_playButton;
    BOOL _checkPlaying;
}
@end
@implementation SLVideoPlayerViewController
@synthesize alertViewRemindState;

- (void)dealloc
{
    [_slVideoView release];
    [_bottomView release];
    [_playButton release];
    [super dealloc];

}
#pragma mark - UIResponder

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    switch (_slVideoView.playbackState)
    {
        case LSVideoPlayerPlaybackStatePaused:
        {
            [_slVideoView play];
            [self buttonHidden];
        }
            
            break;
        case LSVideoPlayerPlaybackStatePlaying:
        {
            [_slVideoView pause];
            [self buttonShow];
        }
            break;
        case LSVideoPlayerPlaybackStateStopped:
        {
            [_slVideoView repeatPlaying];
            [self buttonHidden];
        }
            break;
        case LSVideoPlayerPlaybackStateFailed:
        {
            [_slVideoView pause];
            [self buttonShow];
        }
            break;
        default:
            break;
    }
    
}
#pragma mark - viewDidLoad
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _slVideoView =[[SLVideoView alloc]initWithFrame:CGRectMake(5, 50, self.view.bounds.size.width-20,300) contentUrl:LSViewControllerVideoPath];
    _slVideoView.delegate=self;
    self.view.userInteractionEnabled=NO;
    _bottomView =[[SLCustomBottomView alloc] initWithFrame:CGRectMake(10, 360, self.view.bounds.size.width-20, 50)];
    _bottomView.delegate=self;
    _playButton = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play_button"]];
    _playButton.center = _slVideoView.center;
    [self.view addSubview:_slVideoView];
    [self.view addSubview:_bottomView];
    [_slVideoView addSubview:_playButton];
    [_slVideoView bringSubviewToFront:_playButton];
    [_slVideoView release];
    [_bottomView release];
    [_playButton release];

}
#pragma mark - alertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    
    
}
#pragma mark - SLVideoViewDelegate

- (void)networkNotBest:(SLVideoView *)slVideoView
{
   //网络不好卡的情况 处理

}

- (void)canStartPlaying:(SLVideoView *)slVideoView
{
    self.view.userInteractionEnabled=YES;
    _bottomView.totalTime = slVideoView.totalTime;
}
- (void)dontPlayer:(SLVideoView *)slVideoView
{
    UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:@"亲！视频无法正常播放！@" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.tag=SLalertViewRemindStateNetVideoBad;
    [alertView show];

}

- (void)bufferTimeLengh:(CGFloat)time
{
   //当前缓冲时间
    if (_slVideoView.totalTime==0)
    {
        return;
    }
    _bottomView.sliderProgressValue =time/_slVideoView.totalTime ;

}
- (void)currentPlayerTimeLengh:(CGFloat)time
{
    //当前播放的时间
    _bottomView.sliderValue = time/_slVideoView.totalTime;
    _bottomView.playingTime = time;
}
- (void)playEnd:(SLVideoView *)slVideoView
{
    //播放完成操作
    _bottomView.sliderValue = 1.0;
    [self buttonShow];
}

#pragma mark - SLCustomBottomViewDelegate

- (void)playerIsPlayingYesOrNo:(SLCustomBottomView*)bottom
{
    if (_slVideoView.playbackState ==LSVideoPlayerPlaybackStatePaused)
    {
        [_slVideoView play];
        [self buttonHidden];
    }else
    {
        [_slVideoView pause];
        [self buttonShow];
    }
}
- (void)progressSliderDidStart:(SLCustomBottomView *)progressSlider value:(float)vlaue
{
    if (_slVideoView.playbackState==LSVideoPlayerPlaybackStatePlaying)
    {
         _checkPlaying=YES;
        
         [_slVideoView pause];
        
    }else
    {
        _checkPlaying=NO;
       [_slVideoView pause];
    }
}
- (void)progressSliderDidMoveEnd:(SLCustomBottomView *)progressSlider value:(float)value
{
   
    CGFloat speedTime = value*_slVideoView.totalTime;
    
    int scale =_slVideoView.timeScale;
    
    CMTime cmtime =CMTimeMake(speedTime*scale, scale);
    
    [_slVideoView speed:cmtime];
    if (_checkPlaying)
    {
        [_slVideoView play];
    }else{
    
        [_slVideoView pause];
    }
}
#pragma mark - Private function  (buttonHiddenAndShow)

- (void)buttonHidden
{
    _bottomView.playing=YES;
    
    _playButton.alpha = 1.0f;
    _playButton.hidden = NO;
    [UIView animateWithDuration:0.1f animations:^{
        _playButton.alpha = 0.0f;
    } completion:^(BOOL finished) {
        _playButton.hidden = YES;
    }];
    
}

- (void)buttonShow
{
    _bottomView.playing=NO;
    
    _playButton.hidden = NO;
    
    [UIView animateWithDuration:0.1f animations:^{
        _playButton.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
}

@end
