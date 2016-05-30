//
//  XCProgressSlider.m
//  XCProgressSlider
//
//  Created by wxc on 14-7-11.
//  Copyright (c) 2014年 wxc. All rights reserved.
//

#import "XCProgressSlider.h"

#define XCSliderThumbSize (16)

@interface XCProgressSlider()
{
    UIImageView *_maxImageView;
    UIImageView *_minImageView;
    UIImageView *_thumbImageView;
    UIImageView *_progressImageView;
    
    CGFloat     _pWidth;
    CGFloat     _thumbSize;
}
@end

@implementation XCProgressSlider
@synthesize progress=_progress;
@synthesize value=_value;
@synthesize maximumTrackTintColor=_maximumTrackTintColor,minimumTrackTintColor=_minimumTrackTintColor,thumbTintColor=_thumbTintColor,progressTintColor=_progressTintColor;
@synthesize maximumTrackImage=_maximumTrackImage,minimumTrackImage=_minimumTrackImage,thumbImage=_thumbImage,progressImage=_progressImage;
@synthesize height=_height;
@synthesize delegate=_delegate;

- (void)dealloc
{
    [_maximumTrackTintColor release];
    [_minimumTrackTintColor release];
    [_thumbTintColor release];
    [_progressTintColor release];
    [_maximumTrackImage release];
    [_minimumTrackImage release];
    [_thumbImage release];
    [_progressImage release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _thumbSize = XCSliderThumbSize;
        self.height = 4;
        [self initView];
        self.maximumTrackTintColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.progressTintColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
        self.minimumTrackTintColor = [UIColor blueColor];
        self.thumbTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0];
        
        [self addPanGesture];
        
    }
    return self;
}

- (void)addPanGesture
{
    UIPanGestureRecognizer *recognizer;
    recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(thumbSwipe:)];
    [_thumbImageView addGestureRecognizer:recognizer];
    [recognizer release];
    _thumbImageView.userInteractionEnabled = YES;
}

- (void)initView
{
    _maxImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _maxImageView.backgroundColor = [UIColor whiteColor];
    _progressImageView = [[UIImageView alloc] init];
    _minImageView = [[UIImageView alloc] init];
    
    [self addSubview:_maxImageView];
    [self addSubview:_progressImageView];
    [self addSubview:_minImageView];
    [_maxImageView release];
    [_progressImageView release];
    [_minImageView release];
    
    _thumbImageView = [[UIImageView alloc] init];
    [self addSubview:_thumbImageView];
    [_thumbImageView release];
    
    [self loadFrame];
}

- (void)loadFrame
{
    _pWidth = self.frame.size.width - _thumbSize;
    
    CGFloat x = _thumbSize/2;
    CGFloat y = self.frame.size.height/2 - self.height/2;

    _maxImageView.frame = CGRectMake(x, y, self.frame.size.width - _thumbSize, self.height);
    _progressImageView.frame = CGRectMake(x, y, (_progress*_pWidth), self.height);
    _minImageView.frame = CGRectMake(x, y, (_value*_pWidth), self.height);
    
    _thumbImageView.bounds = CGRectMake(0, 0, _thumbSize, _thumbSize);
    _thumbImageView.center = CGPointMake((_value*_pWidth)+(_thumbSize/2), self.frame.size.height/2);
}

- (void)thumbSwipe:(UIPanGestureRecognizer *)recognizer
{
    if ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateBegan)
    {
        if ([_delegate respondsToSelector:@selector(progressSliderDidStart:value:)]) {
            [_delegate progressSliderDidStart:self value:_value];
        }
    }
    if ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateChanged)
    {
        CGPoint curPoint = [recognizer locationInView:self];
        if (curPoint.x < XCSliderThumbSize/2 || curPoint.x > _pWidth+XCSliderThumbSize/2)
        {
            return;
        }
        
        _thumbImageView.center = CGPointMake(curPoint.x, _thumbImageView.center.y);
        _minImageView.frame = CGRectMake(_minImageView.frame.origin.x, _minImageView.frame.origin.y,_thumbImageView.center.x , _minImageView.frame.size.height);
        _value = [self transformXToValue:_thumbImageView.center.x];
    }
    
    if ([(UIPanGestureRecognizer *)recognizer state] == UIGestureRecognizerStateEnded)
    {
        if (_thumbImageView.center.x <= XCSliderThumbSize/2)
        {
            _value = 0.0f;
            _thumbImageView.center = CGPointMake(XCSliderThumbSize/2, _thumbImageView.center.y);
        }
        else if (_thumbImageView.center.x >= _pWidth+XCSliderThumbSize/2)
        {
            _value = 1.0f;
            _thumbImageView.center = CGPointMake(_pWidth+XCSliderThumbSize/2, _thumbImageView.center.y);
        }
        if ([_delegate respondsToSelector:@selector(progressSliderDidMoveEnd:value:)])
        {
            [_delegate progressSliderDidMoveEnd:self value:_value];
        }
    }
    
    
    
}
#pragma mark -
#pragma mark color
- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor
{
    if (_maximumTrackTintColor != maximumTrackTintColor)
    {
        [_maximumTrackTintColor release];
        _maximumTrackTintColor = [maximumTrackTintColor retain];
        
        _maxImageView.backgroundColor = _maximumTrackTintColor;
    }
}
- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor
{
    if (_minimumTrackTintColor != minimumTrackTintColor)
    {
        [_minimumTrackTintColor release];
        _minimumTrackTintColor = [minimumTrackTintColor retain];
        
        _minImageView.backgroundColor = _minimumTrackTintColor;
    }
}
- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    if (_progressTintColor != progressTintColor)
    {
        [_progressTintColor release];
        _progressTintColor = [progressTintColor retain];
        
        _progressImageView.backgroundColor = _progressTintColor;
    }
}
- (void)setThumbTintColor:(UIColor *)thumbTintColor
{
    if (_thumbTintColor != thumbTintColor)
    {
        [_thumbTintColor release];
        _thumbTintColor = [thumbTintColor retain];
        
        _thumbImageView.image = [self drawDefImage:_thumbImageView.frame.size color:thumbTintColor];
    }
}
#pragma mark -
#pragma mark value
- (void)setProgress:(float)progress
{
    if (_progress != progress)
    {
        _progress = progress;
        
        _progressImageView.frame = CGRectMake(_progressImageView.frame.origin.x, _progressImageView.frame.origin.y, [self transformValueToX:progress], _progressImageView.frame.size.height);
        
    }
}

- (void)setValue:(float)value
{
    if (_value != value)
    {
        _value = value;
        float x = [self transformValueToX:value];
        _minImageView.frame = CGRectMake(_minImageView.frame.origin.x, _minImageView.frame.origin.y, x, _minImageView.frame.size.height);
        _thumbImageView.center = CGPointMake(x, _thumbImageView.center.y);
    }
}

- (void)setHeight:(float)height
{
    if (_height != height)
    {
        _height = height;
        [self loadFrame];
    }
}
#pragma mark -
#pragma mark setImage
- (void)setThumbImage:(UIImage *)thumbImage
{
    if (_thumbImage != thumbImage)
    {
        [_thumbImage release];
        _thumbImage = [thumbImage retain];
        
        _thumbSize = thumbImage.size.width;
        _thumbImageView.image = _thumbImage;
        
        [self loadFrame];
    }
}
- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage
{
    if (_maximumTrackImage != maximumTrackImage)
    {
        [_maximumTrackImage release];
        _maximumTrackImage = [maximumTrackImage retain];
        
        _maxImageView.image = _maximumTrackImage;
    }
}
- (void)setProgressImage:(UIImage *)progressImage
{
    if (_progressImage != progressImage)
    {
        [_progressImage release];
        _progressImage = [progressImage retain];
        
        _progressImageView.image = _progressImage;
    }
}
- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage
{
    if (_minimumTrackImage != minimumTrackImage)
    {
        [_minimumTrackImage release];
        _minimumTrackImage = [minimumTrackImage retain];
        
        _minImageView.image = _minimumTrackImage;
    }
}
#pragma mark -
#pragma mark kit
- (CGFloat)transformValueToX:(float)x
{
    return (_pWidth * x)+XCSliderThumbSize/2;
}
- (float)transformXToValue:(CGFloat)x
{
    return (x-XCSliderThumbSize/2)/_pWidth;
}

- (UIImage *)drawDefImage:(CGSize)size color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath* p = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:size.width/2];
    [color setFill];
    [p fill];
    UIImage* im = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return im;
}
@end
