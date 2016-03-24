//
//  HYCollectionPicker.m
//  HYSelectViewDemo
//
//  Created by MrZhangKe on 16/3/22.
//  Copyright © 2016年 huayun. All rights reserved.
//

#import "HYCollectionPicker.h"
#import "HYPickerCollectionViewCell.h"
#import "HYCollectionLayout.h"

#define CollectionHeight 100
#define PC_DEFAULT_BACKGROUND_OPACITY 0.3f
#define PC_DEFAULT_ANIMATION_DURATION 0.3f
#define MAXCOLUMN 4 //默认的列数


@interface HYCollectionPicker ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIWindow *backWindow;
@property (nonatomic, strong) UIView *darkView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *imageNames;
@property (nonatomic, copy) HYCollectionPickerBlock pickerBlock;
@property (nonatomic, strong) UIPageControl *pageControl;
/** 所有按钮的底部view */
@property (nonatomic, strong) UIView *bottomView;


@end

@implementation HYCollectionPicker


+ (instancetype)pickerWithTitles:(NSArray *)titles
                          images:(NSArray *)imageNames
                         clicked:(HYCollectionPickerBlock)clickedBlock{
    return [[self alloc] initWithTitles:titles images:imageNames clicked:clickedBlock];
}

- (instancetype)initWithTitles:(NSArray *)titles
                        images:(NSArray *)imageNames
                       clicked:(HYCollectionPickerBlock)clickedBlock{
    self = [super init];
    if (self) {
        self.titles = titles;
        self.imageNames = imageNames;
        self.pickerBlock = clickedBlock;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setUpViews{
    
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    //collectionView的页数
    NSInteger pageCount = ((self.titles.count + 7 ) / 8);//取整
    
    self.userInteractionEnabled = YES;
    self.frame = CGRectMake(0, 0, screenSize.width, screenSize.height);
    
    //初始化darkView
    UIView *darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    darkView.alpha = 0.f;
    darkView.backgroundColor = [UIColor blackColor];
    darkView.userInteractionEnabled = YES;
    [self addSubview:darkView];
    self.darkView = darkView;
    
    //设置darkView点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
    [darkView addGestureRecognizer:tap];
    
    NSInteger maxRow = 0;
    if (self.titles.count <= 4) {
        maxRow = 1;
    }else{
        maxRow = 2;
    }
    CGFloat cellWidth = screenSize.width / MAXCOLUMN;
    CGFloat cellHeight = cellWidth / self.cellRatio;
    
    //初始化collectionViewLayOut
    HYCollectionLayout *layOut = [[HYCollectionLayout alloc] init];
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layOut.itemSize = CGSizeMake(cellWidth, cellHeight);
    layOut.minimumInteritemSpacing = 0;
    layOut.minimumLineSpacing = 0;
    layOut.customSize = CGSizeMake(screenSize.width * pageCount,  cellHeight * maxRow);
    
    //初始化collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, cellHeight * maxRow) collectionViewLayout:layOut];
    
    collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[HYPickerCollectionViewCell class] forCellWithReuseIdentifier:@"HYCollectionCell"];
//    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    //初始化pagecontrol
    CGFloat pageControlH = 0;
    if (pageCount > 1) {
        pageControlH = 20;
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        self.pageControl = pageControl;
//        [self addSubview:pageControl];
        pageControl.frame = CGRectMake(0, CGRectGetMaxY(collectionView.frame), screenSize.width, pageControlH);
        pageControl.numberOfPages = pageCount;
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithWhite:0.4 alpha:1];
    }
    
    //初始化bottomView
    UIView *bottomView = [[UIView alloc] init];
    CGFloat bottomViewH = collectionView.bounds.size.height + pageControlH;
    bottomView.frame = CGRectMake(0, screenSize.height - bottomViewH, screenSize.width, bottomViewH);
    bottomView.backgroundColor = self.collectionBGColor;
    [bottomView addSubview:collectionView];
    [bottomView addSubview:self.pageControl];
    self.bottomView = bottomView;
    
    CGAffineTransform VerticalTransform = CGAffineTransformMakeTranslation(0, bottomView.bounds.size.height);
    bottomView.transform = VerticalTransform;
}

#pragma mark --- UICollectionViewDataSource ---
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseID = @"HYCollectionCell";
    HYPickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    cell.title = (NSString *)self.titles[indexPath.row];
    cell.imageName = (NSString *)self.imageNames[indexPath.row];
    cell.isShowGrid = self.isShowGrid;
    cell.backgroundColor = self.collectionBGColor;
    return cell;
}

#pragma mark --- UICollectionViewDelegate ---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self dismiss:nil];
    if (self.pickerBlock) {
        self.pickerBlock(indexPath.row);
    }
}
- (void)show{
    [self setUpViews];
    
    self.backWindow.hidden = NO;
    
    [self addSubview:self.bottomView];
    [self.backWindow addSubview:self];
    
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.bottomView.transform = CGAffineTransformIdentity;
        self.darkView.alpha = self.backgroundOpacity;
    } completion:^(BOOL finished) {
        self.darkView.userInteractionEnabled = YES;
    }];
}

- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [self.darkView setUserInteractionEnabled:YES];
    [UIView animateWithDuration:self.animationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        [self.darkView setAlpha:0];
        
        CGRect frame = self.bottomView.frame;
        frame.origin.y += frame.size.height;
        [self.bottomView setFrame:frame];
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        self.backWindow.hidden = YES;
    }];
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

- (CGFloat)backgroundOpacity{
    if (!_backgroundOpacity) {
        _backgroundOpacity = PC_DEFAULT_BACKGROUND_OPACITY;
    }
    return _backgroundOpacity;
}

- (CGFloat)animationDuration{
    if (!_animationDuration) {
        _animationDuration = PC_DEFAULT_ANIMATION_DURATION;
    }
    return _animationDuration;
}

- (UIColor *)collectionBGColor{
    if (!_collectionBGColor) {
        _collectionBGColor = [UIColor colorWithWhite:1 alpha:1];
    }
    return _collectionBGColor;
}

- (CGFloat)cellRatio{
    if (!_cellRatio) {
        _cellRatio = 1.3f;
    }
    return _cellRatio;
}

- (BOOL)isShowGrid{
    if (!_isShowGrid) {
        _isShowGrid = NO;
    }
    return _isShowGrid;
}

@end



