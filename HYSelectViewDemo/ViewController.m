//
//  ViewController.m
//  HYSelectViewDemo
//
//  Created by MrZhangKe on 16/3/21.
//  Copyright © 2016年 huayun. All rights reserved.
//

#import "ViewController.h"
#import "HYActionSheet.h"
#import "HYCollectionPicker.h"
#import "HYAlertView.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
}

- (IBAction)btnClicked:(UIButton *)sender {
    __weak typeof(self) weakself = self;
    
    HYActionSheet *sheet = [HYActionSheet sheetWithTitle:nil buttonTitles:@[@"拍照", @"从相册选择"] redButtonIndex:1 clicked:^(NSInteger buttonIndex) {
        NSLog(@"> Block way -> Clicked Index: %ld", (long)buttonIndex);
        if (buttonIndex == 1) {
            [weakself pickImage];
        }
    }];
    [sheet show];
}

- (IBAction)btn2Clicked:(UIButton *)sender {
    NSArray *titles = @[@"QQ好友", @"短信", @"朋友圈", @"QQ好友", @"短信", @"微信好友", @"QQ空间", @"QQ好友", @"短信", @"QQ好友", @"QQ好友", @"短信", @"朋友圈", @"QQ好友", @"短信", @"微信好友", @"QQ空间", @"QQ好友", @"短信", @"QQ好友"];
    NSArray *images = @[@"GreenBtn", @"heartbeat", @"game_center", @"heartbeat", @"GreenBtn", @"GreenBtn", @"heartbeat", @"GreenBtn", @"GreenBtn", @"heartbeat", @"GreenBtn", @"heartbeat", @"game_center", @"heartbeat", @"GreenBtn", @"GreenBtn", @"heartbeat", @"GreenBtn", @"GreenBtn", @"heartbeat"];
    HYCollectionPicker *collectionPicker = [HYCollectionPicker pickerWithTitles:titles images:images clicked:^(NSInteger itemIndex) {
        if (itemIndex == 0) {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor redColor];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
//    collectionPicker.pageControlH = 40;
    [collectionPicker show];
}
- (IBAction)btn3Clicked:(UIButton *)sender {
    NSArray *titles = @[@"QQ好友", @"短信", @"朋友圈", @"QQ好友", @"短信", @"微信好友", @"QQ空间", @"QQ好友"];
    NSArray *images = @[@"GreenBtn", @"heartbeat", @"game_center", @"heartbeat", @"GreenBtn", @"GreenBtn", @"heartbeat", @"GreenBtn"];
    HYCollectionPicker *collectionPicker = [HYCollectionPicker pickerWithTitles:titles images:images clicked:^(NSInteger itemIndex) {
        if (itemIndex == 0) {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor redColor];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    [collectionPicker show];
}

- (IBAction)btn4Clicked:(id)sender {
    NSArray *titles = @[@"QQ好友", @"短信", @"朋友圈", @"QQ好友"];
    NSArray *images = @[@"GreenBtn", @"heartbeat", @"game_center", @"heartbeat"];
    HYCollectionPicker *collectionPicker = [HYCollectionPicker pickerWithTitles:titles images:images clicked:^(NSInteger itemIndex) {
        if (itemIndex == 0) {
            UIViewController *vc = [[UIViewController alloc] init];
            vc.view.backgroundColor = [UIColor redColor];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }];
    [collectionPicker show];
}

- (IBAction)btn5Clicked:(UIButton *)sender {
    
    HYAlertView *alert = [[HYAlertView alloc] initWithInputTitle:@"豆瓣" detail:@"确认退出登录？" placeholder:@"请输入密码" handler:^(NSString *text) {
        NSLog(@"%@", text);
    } redButtonIndex:-1 clicked:^(NSInteger itemIndex) {
        
    }];
    [alert show];
    
    
}
- (IBAction)btn6Clicked:(id)sender {
    HYAlertView *alert = [[HYAlertView alloc] initWithConfirmTitle:@"你认真的说?" detail:@"你要抓" redButtonIndex:-1 clicked:^(NSInteger itemIndex) {
        
    }];
    [alert show];
    
    
}

- (IBAction)btn7Clicked:(id)sender {
    
    HYAlertView *alert = [[HYAlertView alloc]initWithTitle:@"这是一个标题" detail:@"也可以这样长长长长长长长长长长长长长长长长长长长长长长长长长长长长" items:@[@"BUTTON1", @"BUTTON2", @"BUTTON3", @"BUTTON4"] redButtonIndex:0 clicked:^(NSInteger itemIndex) {
        
    }];
    [alert show];
    
}



- (IBAction)btn8Clicked:(id)sender {
    
    HYAlertView *alert = [[HYAlertView alloc]initWithTitle:@"账号未绑定" detail:@"此账号未绑定手机，请联系管理员？" items:@[@"确认"] redButtonIndex:-1 clicked:^(NSInteger itemIndex) {
        
    }];
    [alert show];
}

- (void)pickImage{
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
    imagepicker.delegate = self;
    imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagepicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagepicker.allowsEditing = YES;
    [self presentViewController:imagepicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:picker completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:picker completion:nil];
}

@end
