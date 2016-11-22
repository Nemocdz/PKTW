//
//  ViewController.m
//  pictowallpaper
//
//  Created by Nemocdz on 16/3/6.
//  Copyright © 2016年 Nemocdz. All rights reserved.
//

#import "StartVC.h"
#import "FXBlurView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface StartVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
}
@property (strong, nonatomic) IBOutlet FXBlurView *blurView;
@property (nonatomic,strong) UIImage *imageToSend;
@end
@implementation StartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.blurView.tintColor = [UIColor clearColor];
    self.blurView.blurRadius = 10.0f;
}

//状态栏变白
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}



//相机按钮
- (IBAction)openCamera:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        NSLog(@"设备没有摄像头");
    }
}

//相册按钮
- (IBAction)openGallery:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
}

//获取照片，跳转VC
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera){
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
        self.imageToSend = image;
    [picker dismissViewControllerAnimated:NO completion:^{
       [self performSegueWithIdentifier:@"toEditVC" sender:self];
    }];

    NSLog(@"获取照片");
}

//segue传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    id VC = segue.destinationViewController;
    [VC setValue:self.imageToSend forKey:@"image"];
}

//保存照片
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(!error){
        NSLog(@"照片保存成功");
    }else{
        NSLog(@"照片保存失败");
    }
}

@end
