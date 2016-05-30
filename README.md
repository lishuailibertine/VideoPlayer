
# videoPlayer
一个高度自定义的播放器控件

## 简单介绍一下这个demo
* [实现方式](#实现方式)
* [播放控件的基本功能](#播放控件的基本功能)
* [使用方法](#使用方法)
* [播放器代理介绍及播放状态](#播放器代理介绍及播放状态)
* [效果预览](#效果预览)

##实现方式
  demo中视频播放控件用到框架是`AVFoundation`,主要通过`AVPlayerLayer``AVPlayer``AVPlayerItem`等相关类对其进行封装.
##播放控件的基本功能
  此播放控件具有高度可扩展性。基本功能支持:**`快进``暂停``重播``跳到指定播放位置`**等。
##使用方法
```objective-c
//在控制器或者view的子视图中添加播放器对象
SLVideoView * videoView =[[SLVideoView alloc]initWithFrame:CGRectMake(5, 50, self.view.bounds.size.width-20,300) contentUrl:LSViewControllerVideoPath];

//设置代理并实现代理方法
videoView.delegate=self;
[self.view addSubview:videoView];
```
##播放器代理介绍及播放状态
```objective-c
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

//几个播放的枚举状态
typedef NS_ENUM(NSInteger, LSVideoPlayerPlaybackState) {
    LSVideoPlayerPlaybackStateStopped = 0,//播放结束状态
    LSVideoPlayerPlaybackStatePlaying,//正在播放状态
    LSVideoPlayerPlaybackStatePaused,//暂停播放状态
    LSVideoPlayerPlaybackStateFailed,//播放失败状态(视频损坏或无法识别)
};
```
##效果预览
![]()  
