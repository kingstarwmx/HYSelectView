//
//  HYAlertView.m
//  HYSelectViewDemo
//
//  Created by kingstar on 16/3/28.
//  Copyright © 2016年 huayun. All rights reserved.
//

#import "HYAlertView.h"

#define HY_SPLIT_WIDTH  0.5

@implementation UIImage (MMPopup)

+ (UIImage *) mm_imageWithColor:(UIColor *)color {
    return [UIImage mm_imageWithColor:color Size:CGSizeMake(4.0f, 4.0f)];
}

+ (UIImage *) mm_imageWithColor:(UIColor *)color Size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image mm_stretched];
}

- (UIImage *) mm_stretched
{
    CGSize size = self.size;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(truncf(size.height-1)/2, truncf(size.width-1)/2, truncf(size.height-1)/2, truncf(size.width-1)/2);
    
    return [self resizableImageWithCapInsets:insets];
}

@end

@interface HYAlertView ()

@property (nonatomic, strong) UIWindow    *backWindow;
@property (nonatomic, strong) UIView      *darkView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *detailLabel;
@property (nonatomic, strong) UITextField *inputView;
@property (nonatomic, strong) UIView      *buttonView;
@property (nonatomic, strong) NSArray     *actionItems;
@property (nonatomic, strong) UIView      *containerView;
@property (nonatomic, copy) NSString      *title;
@property (nonatomic, copy) NSString      *detail;
@property (nonatomic, copy) NSString      *inputPlaceholder;
@property (nonatomic, strong) NSArray     *items;
@property (nonatomic, assign) NSInteger   redButtonIndex;
@property (nonatomic, copy) MMPopupInputHandler inputHandler;
@property (nonatomic, copy) HYAlertBlock clickBlock;

//基本配置
@property (nonatomic, assign) CGFloat width;                // Default is 275.
@property (nonatomic, assign) CGFloat buttonHeight;         // Default is 275.
@property (nonatomic, assign) CGFloat lineHeight;           // Default is 0.5
@property (nonatomic, assign) CGFloat innerMargin;          // Default is 25.
@property (nonatomic, assign) CGFloat cornerRadius;         // Default is 5.


@property (nonatomic, assign) CGFloat titleFontSize;        // Default is 18.
@property (nonatomic, assign) CGFloat detailFontSize;       // Default is 14.
@property (nonatomic, assign) CGFloat buttonFontSize;       // Default is 17.

@property (nonatomic, strong) UIColor *mainColor;     // Default is #FFFFFF.
@property (nonatomic, strong) UIColor *titleColor;          // Default is #333333.
@property (nonatomic, strong) UIColor *detailColor;         // Default is #333333.
@property (nonatomic, strong) UIColor *lineColor;           // Default is[UIColor colorWithWhite:0.5 alpha:1]

@property (nonatomic, strong) UIColor *itemNormalColor;     // Default is #333333. effect with MMItemTypeNormal
@property (nonatomic, strong) UIColor *itemHighlightColor;  // Default is #E76153. effect with MMItemTypeHighlight
@property (nonatomic, strong) UIColor *itemPressedColor;    // Default is #EFEDE7.

@property (nonatomic, strong) NSString *defaultTextOK;      // Default is "好".
@property (nonatomic, strong) NSString *defaultTextCancel;  // Default is "取消".
@property (nonatomic, strong) NSString *defaultTextConfirm; // Default is "确定".
@end

@implementation HYAlertView

- (instancetype) initWithInputTitle:(NSString*)title
                             detail:(NSString*)detail
                        placeholder:(NSString*)inputPlaceholder
                            handler:(MMPopupInputHandler)inputHandler
                     redButtonIndex:(NSInteger)redButtonIndex
                            clicked:(HYAlertBlock)clickedBlock{
    self.yOffset = -40;
    return [self initWithTitle:title detail:detail items:@[@"取消", @"确定"] inputPlaceholder:inputPlaceholder inputHandler:inputHandler redButtonIndex:redButtonIndex clicked:clickedBlock];
    
}

- (instancetype) initWithConfirmTitle:(NSString*)title
                               detail:(NSString*)detail
                       redButtonIndex:(NSInteger)redButtonIndex
                              clicked:(HYAlertBlock)clickedBlock{
    return [self initWithTitle:title detail:detail items:@[@"取消", @"确定"] inputPlaceholder:nil inputHandler:nil redButtonIndex:redButtonIndex clicked:clickedBlock];
    
}

- (instancetype) initWithTitle:(NSString*)title
                        detail:(NSString*)detail
                         items:(NSArray*)items
                redButtonIndex:(NSInteger)redButtonIndex
                       clicked:(HYAlertBlock)clickedBlock{
    
    return [self initWithTitle:title detail:detail items:items inputPlaceholder:nil inputHandler:nil redButtonIndex:redButtonIndex clicked:clickedBlock];
}

- (instancetype)initWithTitle:(NSString *)title
                       detail:(NSString *)detail
                        items:(NSArray *)items
             inputPlaceholder:(NSString *)inputPlaceholder
                 inputHandler:(MMPopupInputHandler)inputHandler
               redButtonIndex:(NSInteger)redButtonIndex
                      clicked:(HYAlertBlock)clickedBlock{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self){
        
        self.inputHandler = inputHandler;
        self.actionItems = items;
        self.title = title;
        self.detail = detail;
        self.items = items;
        self.inputPlaceholder = inputPlaceholder;
        self.clickBlock = clickedBlock;
        self.redButtonIndex = redButtonIndex;
        
        //初始化参数
        self.width          = 275.0f;
        self.buttonHeight   = 50.0f;
        self.innerMargin    = 25.0f;
        self.lineHeight     = 0.5f;
        self.cornerRadius   = 8.0f;
        
        self.titleFontSize  = 18.0f;
        self.detailFontSize = 14.0f;
        self.buttonFontSize = 17.0f;
        
        self.mainColor          = [UIColor whiteColor];
        self.titleColor         = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1];
        self.detailColor        = [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1];
        self.lineColor          = [UIColor colorWithWhite:0.5 alpha:0.5];
        
        self.itemNormalColor    = [UIColor colorWithRed:0 / 255.0 green:123.0 / 255.0 blue:255.0 / 255.0 alpha:1];
        self.itemHighlightColor = [UIColor colorWithRed:0 / 255.0 green:123.0 / 255.0 blue:255.0 / 255.0 alpha:1];
        self.itemPressedColor   = [UIColor colorWithRed:223.0 / 255.0 green:223.0 / 255.0 blue:223.0 / 255.0 alpha:1];
        
        self.defaultTextOK      = @"好";
        self.defaultTextCancel  = @"取消";
        self.defaultTextConfirm = @"确定";
    }
    return self;
}

- (void)setUpViews{
    // 暗黑色的view
    UIView *darkView = [[UIView alloc] init];
    [darkView setAlpha:0];
    [darkView setUserInteractionEnabled:NO];
    [darkView setFrame:[UIScreen mainScreen].bounds];
    [darkView setBackgroundColor:[UIColor colorWithRed:46 / 255.0 green:49 / 255.0 blue:50 / 255.0 alpha:1]];
    [self addSubview:darkView];
    _darkView = darkView;
    
    //初始化容器视图
    UIView *containerView = [UIView new];
    containerView.userInteractionEnabled = YES;
    self.containerView = containerView;
    containerView.backgroundColor = self.mainColor;
    containerView.layer.cornerRadius = self.cornerRadius;
    containerView.clipsToBounds = YES;
    CGFloat containerW = self.width;
    containerView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    containerView.alpha = 0.0f;
    
    //设置titleLabel
    CGRect titleRect = CGRectMake(self.innerMargin, self.innerMargin, 0, 0);
    if (self.title.length > 0 ){
        self.titleLabel = [UILabel new];
        self.titleLabel.textColor = self.titleColor;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:self.titleFontSize];
        self.titleLabel.backgroundColor = containerView.backgroundColor;
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = self.title;
        [containerView addSubview:self.titleLabel];
        //设置位置信息
        CGFloat titleW = containerW - 2 * self.innerMargin;
        NSValue *sizeValue = [NSValue valueWithCGSize:CGSizeMake(titleW, MAXFLOAT)];
        CGSize caculateSize = [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:self.titleFontSize], NSViewSizeDocumentAttribute:sizeValue}];
        CGFloat titleH = caculateSize.height;
        self.titleLabel.frame = CGRectMake(self.innerMargin, self.innerMargin, titleW, titleH);
        titleRect = self.titleLabel.frame;
    }
    
    //设置detailLabel
    CGRect detailRect = titleRect;
    if (self.detail.length > 0 ){
        self.detailLabel = [UILabel new];
        [containerView addSubview:self.detailLabel];
        self.detailLabel.textColor = self.detailColor;
        self.detailLabel.textAlignment = NSTextAlignmentCenter;
        self.detailLabel.font = [UIFont systemFontOfSize:self.detailFontSize];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.backgroundColor = containerView.backgroundColor;
        self.detailLabel.text = self.detail;
        //设置位置信息
        CGFloat detailW = containerW - 2 * self.innerMargin;
        CGRect detailSize = [self.detail boundingRectWithSize:CGSizeMake(detailW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.detailFontSize]} context:nil];
        CGFloat detailH = detailSize.size.height;
        self.detailLabel.frame = CGRectMake(self.innerMargin, CGRectGetMaxY(titleRect) + 5, detailW, detailH);
        detailRect = self.detailLabel.frame;
    }
    
    //设置inputTextfield
    CGRect inputRect = detailRect;
    if (self.inputHandler) {
        self.inputView = [UITextField new];
        [containerView addSubview:self.inputView];
        self.inputView.backgroundColor = containerView.backgroundColor;
        self.inputView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
        self.inputView.leftViewMode = UITextFieldViewModeAlways;
        self.inputView.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.inputView.placeholder = self.inputPlaceholder;
        self.inputView.layer.borderWidth = HY_SPLIT_WIDTH;
        self.inputView.layer.borderColor = [UIColor grayColor].CGColor;
        self.inputView.frame = CGRectMake(self.innerMargin, CGRectGetMaxY(detailRect) + 10, containerW - self.innerMargin * 2, 40);
        inputRect = self.inputView.frame;
    }
    
    
    //设置按钮
    NSMutableArray *btnArr = [NSMutableArray array];
    NSMutableArray *lineArr = [NSMutableArray array];
    for (int i = 0; i < self.items.count; i ++) {
        NSString *btnTitle = self.items[i];
        //创建buttons
        //            UIButton *btn = [UIButton mm_buttonWithTarget:self action:@selector(actionButton:)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnArr addObject:btn];
        [containerView addSubview:btn];
        btn.tag = i + 250;
        [btn setBackgroundImage:[UIImage mm_imageWithColor:self.mainColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage mm_imageWithColor:self.itemPressedColor] forState:UIControlStateHighlighted];
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        UIColor *titleColor = nil;
        if (i == self.redButtonIndex) {
            
            titleColor = [UIColor colorWithRed:255 / 255.0 green:10 / 255.0 blue:10 / 255.0 alpha:1];
            
        } else {
            
            titleColor = self.itemNormalColor ;
        }
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:self.buttonFontSize];
        
        //创建lines
        UIView *line = [UIView new];
        line.backgroundColor = self.lineColor;
        [lineArr addObject:line];
        [containerView addSubview:line];
    }
    
    CGFloat btnsH = 0.f;
    if (self.actionItems.count == 2) {
        
        //横着的line
        UIView *line1 = lineArr[0];
        line1.frame = CGRectMake(0, CGRectGetMaxY(inputRect) + self.innerMargin, containerW, self.lineHeight);
        //竖着的line
        UIView *line2 = lineArr[1];
        line2.frame = CGRectMake((containerW - self.lineHeight) / 2 , CGRectGetMaxY(line1.frame), self.lineHeight, self.buttonHeight);
        
        UIButton *btn1 = btnArr[0];
        btn1.frame = CGRectMake(0, CGRectGetMaxY(line1.frame), (containerW - self.lineHeight) / 2, self.buttonHeight);
        
        UIButton *btn2 = btnArr[1];
        btn2.frame = CGRectMake(CGRectGetMaxX(line2.frame), CGRectGetMaxY(line1.frame), (containerW - self.lineHeight) / 2 , self.buttonHeight);
        
        btnsH = self.buttonHeight + self.lineHeight;
        
    }else {
        for (int i = 0; i < btnArr.count; i ++) {
            UIView *line = lineArr[i];
            line.frame = CGRectMake(0, CGRectGetMaxY(inputRect) + self.innerMargin + (self.buttonHeight + self.lineHeight) * i, containerW, self.lineHeight);
            
            UIButton *btn = btnArr[i];
            btn.frame = CGRectMake(0, CGRectGetMaxY(inputRect) + self.innerMargin + self.lineHeight+ (self.buttonHeight + self.lineHeight) * i, containerW, self.buttonHeight);
        }
        btnsH = (self.buttonHeight + self.lineHeight) * self.actionItems.count;
        
    }
    
    CGFloat containerH = CGRectGetMaxY(inputRect) + self.innerMargin + btnsH;
    containerView.bounds = CGRectMake(0, 0, containerW, containerH);
    containerView.center = CGPointMake(self.center.x, self.center.y + self.yOffset);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyTextChange:) name:UITextFieldTextDidChangeNotification object:nil];


}

- (void)show{
    [self setUpViews];
    
    self.backWindow.hidden = NO;
    
    [self addSubview:self.containerView];
    [self.backWindow addSubview:self];
    
    
    [UIView animateWithDuration:self.animationDuration
                          delay:0.0 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.containerView.alpha = 1;
                         self.containerView.transform = CGAffineTransformIdentity;
                         self.darkView.alpha = self.backgroundOpacity;
                         
                     } completion:^(BOOL finished) {
                         self.darkView.userInteractionEnabled = YES;
                     }];
    if (self.inputHandler) {
        [self showKeyboard];
    }
    
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [self.darkView setUserInteractionEnabled:YES];
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.darkView setAlpha:0];
        self.containerView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        self.backWindow.hidden = YES;
    }];
    [self hideKeyboard];
}

- (void)btnClicked:(UIButton *)sender{
    [self dismiss:nil];
    if (self.clickBlock) {
        self.clickBlock(sender.tag - 250);
    }
    //确保只有当点击确定才把输入的文字传过去
    if (self.inputHandler && (sender.tag - 250 > 0))
    {
        self.inputHandler(self.inputView.text);
    }
}

- (void)showKeyboard
{
    [self.inputView becomeFirstResponder];
}

- (void)hideKeyboard
{
    [self.inputView resignFirstResponder];
}


- (void)notifyTextChange:(NSNotification *)n
{
    if ( self.maxInputLength == 0 )
    {
        return;
    }
    
    if ( n.object != self.inputView )
    {
        return;
    }
    
    UITextField *textField = self.inputView;
    
    NSString *toBeString = textField.text;
    
    UITextRange *selectedRange = [textField markedTextRange];
    //获取高亮部分
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (toBeString.length > self.maxInputLength) {
//            textField.text = [toBeString mm_truncateByCharLength:self.maxInputLength];
            textField.text = [self string:toBeString truncateByCharLength:self.maxInputLength];
        }
    }
}

- (NSString *)string:(NSString *)str truncateByCharLength:(NSUInteger)charLength
{
    __block NSUInteger length = 0;
    [str enumerateSubstringsInRange:NSMakeRange(0, [str length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              
                              if ( length+substringRange.length > charLength )
                              {
                                  *stop = YES;
                                  return;
                              }
                              
                              length+=substringRange.length;
                          }];
    
    return [str substringToIndex:length];
}


#pragma mark -- getter --

- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}

- (CGFloat)animationDuration{
    if (!_animationDuration) {
        _animationDuration = 0.23f;
    }
    return _animationDuration;
}

- (CGFloat)backgroundOpacity{
    if (!_backgroundOpacity) {
        _backgroundOpacity = 0.3f;
    }
    return _backgroundOpacity;
}

@end

