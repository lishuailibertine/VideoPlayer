//
//  SLVideoView.h
//  SLVideoPlay
//
//  Created by shuaili on 14-7-11.
//  Copyright (c) 2014年 shuaili. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LSVideoPlayerPlaybackState) {
    LSVideoPlayerPlaybackStateStopped = 0,//播放结束状态
    LSVideoPlayerPlaybackStatePlaying,//正在播放状态
    LSVideoPlayerPlaybackStatePaused,//暂停播放状态
    LSVideoPlayerPlaybackStateFailed,//播放失败状态(视频损坏或无法识别)
};
@class SLVideoView;

@protocol  SLVideoViewDelegate <NSObject>

@optional
/**
 *  可以开始播放
 */
- (void)canStartPlaying:(SLVideoView *)slVideoView;
/**
 *  网络不好回调
 */
- (void)networkNotBest:(SLVideoView *)slVideoView;
/**
 *  不能播放
 */
- (void)dontPlayer:(SLVideoView *)slVideoView;
/**
 *  缓冲的长度
 */
- (void)bufferTimeLengh:(CGFloat)time;
/**
 *  当前播放的长度
 */
- (void)currentPlayerTimeLengh:(CGFloat)time;
/**
 *  播放结束
 */
- (void)playEnd:(SLVideoView *)slVideoView;
@end
@interface SLVideoView : UIView
{
    
    id<SLVideoViewDelegate>_delegate;
    
    NSString *_videoModel;
    CMTimeScale _timeScale;
}
@property (nonatomic,retain)id<SLVideoViewDelegate>delegate;
@property (nonatomic,assign) LSVideoPlayerPlaybackState playbackState;
@property (nonatomic,copy) NSString *contentUrl;
@property (assign,readonly) CGFloat   totalTime;
@property (nonatomic,readonly)CMTimeScale  timeScale;
@property (nonatomic,copy) NSString *videoModel;

- (id)initWithFrame:(CGRect)frame contentUrl:(NSString *)url ;
- (void)speed:(CMTime)speedValue;
- (void)play;
- (void)pause;
- (void)repeatPlaying;
@end
