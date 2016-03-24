//
//  HYCollectionPicker.h
//  HYSelectViewDemo
//
//  Created by MrZhangKe on 16/3/22.
//  Copyright © 2016年 huayun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HYCollectionPickerBlock)(NSInteger itemIndex);

@interface HYCollectionPicker : UIView

/**
 *  动画的持续时间，默认是0.3
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 *  背景视图的透明度，默认0.3
 */
@property (nonatomic, assign) CGFloat backgroundOpacity;

/**
 *  集合视图cell的颜色，默认是纯白
 */
@property (nonatomic, strong) UIColor *collectionBGColor;

/**
 *  集合视图的宽高比,默认是1.3
 */
@property (nonatomic, assign) CGFloat cellRatio;

/**
 *  每行的列数,默认是4
 */
@property (nonatomic, assign) NSInteger column;

/**
 *  是否显示网格，默认是NO，不显示
 */
@property (nonatomic, assign) BOOL isShowGrid;

/**
 *  返回一个 HYCollectionPicker 对象, 类方法
 *
 *  @param title          所有按钮的标题
 *  @param imageNames     所有按钮的图片名字
 *  @param clickedBlock   点击按钮的 block 回调
 */
+ (instancetype)pickerWithTitles:(NSArray *)titles
                          images:(NSArray *)imageNames
                         clicked:(HYCollectionPickerBlock)clickedBlock;

/**
 *  返回一个 HYCollectionPicker 对象, 对象方法
 *
 *  @param title          所有按钮的标题
 *  @param imageNames     所有按钮的图片名字
 *  @param clickedBlock   点击按钮的 block 回调
 */
- (instancetype)initWithTitles:(NSArray *)titles
                          images:(NSArray *)imageNames
                         clicked:(HYCollectionPickerBlock)clickedBlock;

/**
 *  显示 CollectionPicker
 */
- (void)show;

@end
