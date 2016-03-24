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

    }
    return self;
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

@end
