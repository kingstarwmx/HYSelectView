//
//  HYAlertView.h
//  HYSelectViewDemo
//
//  Created by kingstar on 16/3/28.
//  Copyright © 2016年 huayun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HYAlertViewConfig;

typedef void(^MMPopupInputHandler)(NSString *text);
typedef void (^ConfigBlock)(HYAlertViewConfig *config);
typedef void(^HYAlertBlock)(NSInteger itemIndex);

@interface HYAlertView : UIView
//动画持续时间，默认是0.23s
@property (nonatomic, assign) NSTimeInterval animationDuration;
//竖直方向上的偏移
@property (nonatomic, assign) CGFloat yOffset;
/** 最大输入长度,默认是0，就是无限制 */
@property (nonatomic, assign) NSUInteger maxInputLength;
/**背景视图的透明度，默认0.3*/
@property (nonatomic, assign) CGFloat backgroundOpacity;

/**
 *  带一个textField的样式，已经默认有"确定"，"取消"按钮
 *  @param title            标题
 *  @param detail           详细信息
 *  @param inputPlaceholder 输入框的placeholder
 *  @param inputHandler     输入文字的回调，按确定键之后会把输入的text传过来
 *  @param redButtonIndex   红色按钮的序号,没有传-1
 *  @param clickedBlock     点击按钮的回调
 */
- (instancetype) initWithInputTitle:(NSString*)title
                             detail:(NSString*)detail
                        placeholder:(NSString*)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler
                     redButtonIndex:(NSInteger)redButtonIndex
                            clicked:(HYAlertBlock)clickedBlock;

/**
 *  可以自定义标题和详细信息，并且默认有"确定"，"取消"按钮
 *  @param title          标题
 *  @param detail         详细信息
 *  @param redButtonIndex 红色按钮的序号,没有传-1
 *  @param clickedBlock   点击按钮的回调
 */
- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail
                       redButtonIndex:(NSInteger)redButtonIndex
                              clicked:(HYAlertBlock)clickedBlock;

/**
 *  可以自定义标题和详细信息，按钮需要自定义文字跟个数
 *  @param title          标题
 *  @param detail         详细信息
 *  @param items          按钮数组，这里装按钮的label文字
 *  @param redButtonIndex 红色按钮的序号,没有传-1
 *  @param clickedBlock   点击按钮的回调
 */
- (instancetype) initWithTitle:(NSString *)title
                        detail:(NSString *)detail
                         items:(NSArray *)items
                redButtonIndex:(NSInteger)redButtonIndex
                       clicked:(HYAlertBlock)clickedBlock;


- (void)show;

@end

@interface UIImage (MMPopup)

+ (UIImage *) mm_imageWithColor:(UIColor *)color;

+ (UIImage *) mm_imageWithColor:(UIColor *)color Size:(CGSize)size;

- (UIImage *) mm_stretched;

@end
