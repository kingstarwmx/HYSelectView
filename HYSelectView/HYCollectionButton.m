//
//  HYCollectionButton.m
//  HYSelectViewDemo
//
//  Created by MrZhangKe on 16/3/24.
//  Copyright © 2016年 huayun. All rights reserved.
//


#define HYBUTTONIMAGERATIO 0.7

#import "HYCollectionButton.h"

@implementation HYCollectionButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, 10);
//        self.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self showGrid:YES];
    }
    return self;
}

- (void)showGrid:(BOOL)isShowGrid{
    if (isShowGrid) {
        //设置cell的阴影
        self.clipsToBounds = NO;
        self.layer.contentsScale = [UIScreen mainScreen].scale;
        self.layer.shadowOpacity = 0.1f;
        self.layer.shadowRadius = 0.7f;
        self.layer.shadowOffset = CGSizeMake(0,0);
        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        //设置缓存
        self.layer.shouldRasterize = YES;
        //设置抗锯齿边缘
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * HYBUTTONIMAGERATIO - self.imageMargin;
    return CGRectMake(0, self.imageMargin, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleY = contentRect.size.height * HYBUTTONIMAGERATIO;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (CGFloat)imageMargin{
    if (!_imageMargin) {
        _imageMargin = 10.f;
    }
    return _imageMargin;
}

- (CGFloat)titleMargin{
    if (!_titleMargin) {
        _titleMargin = 0.f;
    }
    return _titleMargin;
}

- (void)setIsShowGrid:(BOOL)isShowGrid{
    _isShowGrid = isShowGrid;
    [self showGrid:isShowGrid];
}

@end
