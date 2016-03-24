##1.HYActionSheet:跟微信的actionsheet是完全一模一样的
  ###用法:

/**
 *  返回一个 ActionSheet 对象, 类方法
 *  @param title          提示标题,如果没有传nil
 *  @param buttonTitles   所有按钮的标题
 *  @param redButtonIndex 红色按钮的 index
 *  @param clicked        点击按钮的 block 回调
 *  Tip: 如果没有红色按钮, redButtonIndex 给 `-1` 即可
 */
        + (instancetype)sheetWithTitle:(NSString *)title
                          buttonTitles:(NSArray *)buttonTitles
                        redButtonIndex:(NSInteger)redButtonIndex
                               clicked:(HYActionSheetBlock)clicked;
                               
###example:
    __weak typeof(self) weakself = self;
    HYActionSheet *sheet = [HYActionSheet sheetWithTitle:@"选择照片" buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:1 clicked:^(NSInteger buttonIndex) {
         if (buttonIndex == 1) {
         //根据选中的item的序号做相应的事情
         [self doSomething];
      }
    }];
    [sheet show];
    
    
##2.HYCOllectionPicker:可用于社交分享的界面
  ###用法:
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
                                  
###example:
    NSArray *titles = @[@"朋友圈", @"微信好友", @"QQ空间", @"QQ好友", @"短信", @"朋友圈"];
    NSArray *images = @[@"icon_base", @"GreenBtn", @"heartbeat", @"GreenBtn", @"heartbeat", @"game_center"];
    HYCollectionPicker *collectionPicker = [HYCollectionPicker pickerWithTitles:titles images:images clicked:^(NSInteger itemIndex) {
        if (itemIndex == 0) {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor redColor];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    [collectionPicker show];