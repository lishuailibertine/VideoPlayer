//
//  XCProgressSlider.h
//  XCProgressSlider
//
//  Created by wxc on 14-7-11.
//  Copyright (c) 2014年 wxc. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol XCProgressSliderDelegate;

@interface XCProgressSlider : UIView
{
    float _value;
    float _progress;
    float _height;
    
    UIColor *_minimumTrackTintColor;
    UIColor *_maximumTrackTintColor;
    UIColor *_thumbTintColor;
    UIColor *_progressTintColor;
    
    UIImage *_minimumTrackImage;
    UIImage *_maximumTrackImage;
    UIImage *_thumbImage;
    UIImage *_progressImage;
    
    id<XCProgressSliderDelegate> _delegate;
}
@property(nonatomic,assign) float value;            //滑块位置
@property(nonatomic,assign) float progress;         //缓冲进度位置
@property(nonatomic,assign) float height;            //进度条高

@property(nonatomic,retain) UIColor *minimumTrackTintColor;
@property(nonatomic,retain) UIColor *maximumTrackTintColor;
@property(nonatomic,retain) UIColor *thumbTintColor;
@property(nonatomic,retain) UIColor *progressTintColor;

@property(nonatomic,retain) UIImage *minimumTrackImage;
@property(nonatomic,retain) UIImage *maximumTrackImage;
@property(nonatomic,retain) UIImage *thumbImage;
@property(nonatomic,retain) UIImage *progressImage;

@property (nonatomic,assign) id<XCProgressSliderDelegate> delegate;
@end

@protocol XCProgressSliderDelegate <NSObject>

- (void)progressSliderDidStart:(XCProgressSlider *)progressSlider value:(float)vlaue;
- (void)progressSliderDidMoveEnd:(XCProgressSlider *)progressSlider value:(float)vlaue;
@end
