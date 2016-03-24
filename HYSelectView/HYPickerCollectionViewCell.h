//
//  HYPickerCollectionViewCell.h
//  HYSelectViewDemo
//
//  Created by MrZhangKe on 16/3/22.
//  Copyright © 2016年 huayun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HYCollectionButton.h"

@interface HYPickerCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, assign) BOOL isShowGrid;

@property (nonatomic, strong) HYCollectionButton *collectionButton;
@end
