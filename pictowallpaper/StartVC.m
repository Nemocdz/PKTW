//
//  ViewController.m
//  pictowallpaper
//
//  Created by Nemocdz on 16/3/6.
//  Copyright © 2016年 Nemocdz. All rights reserved.
//

#import "StartVC.h"
#import "CDZImagePickerViewController.h"
#import "CDZImagePickerActionsItem.h"

@interface StartVC ()
@property (strong, nonatomic) UIView *backgroundView;
@property (nonatomic,strong) UIImage *imageToSend;
@end
@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

//状态栏变白
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



//相机按钮
- (IBAction)openCamera:(id)sender {
    [self.view addSubview:self.backgroundView];
    CDZImagePickerViewController *imagePickerController = [[CDZImagePickerViewController alloc]init];
    imagePickerController.actionArray = [NSMutableArray arrayWithObjects:
                                         [[CDZImagePickerActionsItem alloc]initWithTitle:@"打开设备上的图片" withActionType:CDZImagePickerLibraryAction withImage:[UIImage imageNamed:@"phone-icon.png"]],
                                         [[CDZImagePickerActionsItem alloc]initWithTitle:@"相机" withActionType:CDZImagePickerCameraAction withImage:[UIImage imageNamed:@"camera-icon.png"]],
                                         [[CDZImagePickerActionsItem alloc]initWithTitle:@"打开最新图片" withActionType:CDZImagePickerRecentAction withImage:[UIImage imageNamed:@"clock-icon.png"]],
                                         nil];
    [imagePickerController openPickerInController:self withImageBlock:^(UIImage *image) {
        [self.backgroundView removeFromSuperview];
        if (image) { //检查是否有照片
            self.imageToSend = image;
            [self performSegueWithIdentifier:@"toEditVC" sender:self];
        }
    }];
}



//segue传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id VC = segue.destinationViewController;
    [VC setValue:self.imageToSend forKey:@"image"];
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:self.view.bounds];
        _backgroundView.backgroundColor = BACKGROUND_BLACK_COLOR;
    }
    return _backgroundView;
}



@end
