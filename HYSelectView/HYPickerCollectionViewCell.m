//
//  HYPickerCollectionViewCell.m
//  HYSelectViewDemo
//
//  Created by MrZhangKe on 16/3/22.
//  Copyright © 2016年 huayun. All rights reserved.
//
//height 240 80 40
#import "HYPickerCollectionViewCell.h"


#define LABELFONT [UIFont systemFontOfSize:12]

@interface HYPickerCollectionViewCell ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *iconImageView;


@end

@implementation HYPickerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor = [UIColor whiteColor];
//        //自定义的图片
//        UIImageView *imageView = [[UIImageView alloc] init];
//        self.iconImageView = imageView;
//        [self addSubview:imageView];
//        
//        //图片下面的文字
//        UILabel *label = [[UILabel alloc] init];
//        [label setFont:LABELFONT];
//        label.textColor = [UIColor blackColor];
//        label.textAlignment = NSTextAlignmentCenter;
//        self.label = label;
//        [self addSubview:label];
//        
        //设置Button
        HYCollectionButton *collectionButton = [[HYCollectionButton alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:collectionButton];
        self.collectionButton = collectionButton;
        
        if (self.isShowGrid) {
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
    return self;
}

/*
- (void)layoutSubviews{
    [super layoutSubviews];
 
    CGFloat space = 8.f;
    CGFloat cellHeight = self.bounds.size.height;
    CGFloat cellWidth = self.bounds.size.width;
    
    NSValue *sizeValue = [NSValue valueWithCGSize:CGSizeMake(self.bounds.size.width, MAXFLOAT)];
    CGSize caculateSize = [self.title sizeWithAttributes:@{NSFontAttributeName:LABELFONT, NSViewSizeDocumentAttribute:sizeValue}];
    
    CGFloat labelW = cellWidth;
    CGFloat labelH = caculateSize.height;
    CGFloat labelX = 0.f;
    
    UIImage *image = [UIImage imageNamed:self.imageName];
    
    CGFloat imageH = cellHeight / 3;
    CGFloat imageW = imageH * image.size.width / image.size.height;
    CGFloat imageX = (cellWidth - imageW) / 2;
    CGFloat imageY = (cellHeight - imageH - space - labelH) / 2;
    
    CGFloat labelY = imageY + imageH + space;
    
    self.label.frame = CGRectMake(labelX, labelY, labelW, labelH);
    self.iconImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
}*/

- (void)setImageName:(NSString *)imageName{
    _imageName = imageName;
//    self.iconImageView.image = [UIImage imageNamed:imageName];
    [self.collectionButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title{
    _title = title;
//    self.label.text = title;
    [self.collectionButton setTitle:title forState:UIControlStateNormal];
}

@end
