//
//  UIView+JHRedDot.m
//  JHKit
//
//  Created by HaoCold on 2017/12/18.
//  Copyright © 2017年 HaoCold. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "UIView+JHRedDot.h"

@interface JHRedDot()
@property (nonatomic,  unsafe_unretained) UIView *superView;
@property (nonatomic,  strong) JHRedDotConfig *config;
@end

@implementation JHRedDot

+ (instancetype)defaultDot{
    return [JHRedDot redDotWithConfig:[[JHRedDotConfig alloc] init]];
}

+ (instancetype)redDotWithConfig:(JHRedDotConfig *)config{
    JHRedDot *redDot = [[JHRedDot alloc] initWithConfig:config];
    return redDot;
}

- (instancetype)initWithConfig:(JHRedDotConfig *)config{
    self = [super init];
    if (self) {
        _config = config;
        self.frame = CGRectMake(0, 0, config.size.width, config.size.height);
        self.layer.cornerRadius = config.radius;
        self.backgroundColor = config.color;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    if (newSuperview) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self update];
        });
    }else{
        @try {
            [_superView removeObserver:self forKeyPath:@"frame"];
            [_superView removeObserver:self forKeyPath:@"bounds"];
            _superView = nil;
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"] ||
        [keyPath isEqualToString:@"bounds"]) {
        [self update];
    }
}

- (void)update
{
    CGRect frame = self.frame;
    frame.origin.x = CGRectGetWidth(self.superview.frame)-_config.size.width+_config.offsetX;
    frame.origin.y = _config.offsetY;
    self.frame = frame;
    
    // superview is UIButton
    if ([self.superview isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self.superview;
        CGRect titleRect = [button titleRectForContentRect:button.bounds];
        CGRect imageRect = [button imageRectForContentRect:button.bounds];

        CGFloat maxX = MAX(CGRectGetMaxX(titleRect), CGRectGetMaxX(imageRect));
        CGFloat minY = MIN(CGRectGetMinY(titleRect), CGRectGetMinY(imageRect));
        
        frame.origin.x = maxX + _config.offsetX;
        frame.origin.y = minY + _config.offsetY;
        
        self.frame = frame;
    }
}

@end

@implementation JHRedDotConfig

- (instancetype)init{
    self = [super init];
    if (self) {
        _size = CGSizeMake(10, 10);
        _radius = 5;
        _color = [UIColor redColor];
    }
    return self;
}
@end


@implementation UIView (JHRedDot)

- (JHRedDot *)jh_redDot{
    JHRedDot *redDot;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[JHRedDot class]]) {
            redDot = (JHRedDot *)view;
            break;
        }
    }
    return redDot;
}

- (void)setJh_redDot:(JHRedDot *)jh_redDot{
    if (jh_redDot) {
        jh_redDot.superView = self;
        [self addSubview:jh_redDot];

        [self addObserver:jh_redDot forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:NULL];
        [self addObserver:jh_redDot forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
    }
}

@end

