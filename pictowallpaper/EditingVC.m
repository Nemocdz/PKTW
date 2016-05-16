//
//  EditingVC.m
//  PKTW
//
//  Created by Nemocdz on 16/3/30.
//  Copyright © 2016年 Nemocdz. All rights reserved.
//

#import "EditingVC.h"
#import "FXBlurView.h"

static const int kMaxBlurLevel = 5;
static const int kMaxAppLevel = 5;

@interface EditingVC ()<UIImagePickerControllerDelegate>
- (IBAction)showBlackStatusBar:(id)sender;
- (IBAction)showBlackDock:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)finish:(id)sender;
- (IBAction)preview:(id)sender;
- (IBAction)backgroundBlur:(id)sender;

- (IBAction)changeBlur:(UIButton *)sender;
- (IBAction)changePreview:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *blackStatusBar;
@property (strong, nonatomic) IBOutlet UIView *blackDock;
@property (strong, nonatomic) IBOutlet UIButton *blackStatusBarBtn;
@property (strong, nonatomic) IBOutlet UIButton *blackDockBtn;
@property (strong, nonatomic) IBOutlet UIButton *backgroundBlurBtn;
@property (strong, nonatomic) IBOutlet UIButton *previewBtn;
@property (strong, nonatomic) IBOutlet UILabel *statusBarLabel;
@property (strong, nonatomic) IBOutlet UILabel *dockLabel;
@property (strong, nonatomic) IBOutlet UILabel *helpLabel;
@property (strong, nonatomic) IBOutlet UIImageView *apps;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentViewHight;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *previewUpBtn;
@property (strong, nonatomic) IBOutlet UIButton *previewDownBtn;
@property (strong, nonatomic) IBOutlet UIButton *blurUpBtn;
@property (strong, nonatomic) IBOutlet UIButton *blurDownBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewAspect;
@property (strong, nonatomic) IBOutlet FXBlurView *blurView;
@property (strong, nonatomic) IBOutlet UIImageView *apps2;
@property (strong, nonatomic) IBOutlet UIImageView *apps3;
@property (strong, nonatomic) IBOutlet UIImageView *apps4;
@property (strong, nonatomic) IBOutlet UIImageView *apps5;
@property (strong, nonatomic) IBOutlet UIView *drawView;
@property (assign, nonatomic) int previewIndex;
@property (assign, nonatomic) int blurIndex;
@property (assign, nonatomic) float blackSpace;

@end

@implementation EditingVC
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self relayoutAndSetImage];

}


- (BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//重新计算滑动范围和加入图片
- (void)relayoutAndSetImage{
    CGSize imageSize = self.originalImage.size;
   // CGSize contentViewSize = self.contentView.frame.size;
    CGSize scrollViewSize = self.scrollView.frame.size;
    
    CGFloat imgaeHeight = imageSize.height / imageSize.width * scrollViewSize.width;
    self.blackSpace = (scrollViewSize.height - imgaeHeight);
    CGFloat newHeight = self.blackSpace * 2 + imgaeHeight;
    
    self.scrollView.contentOffset = CGPointMake(0,self.blackSpace/2);
    self.scrollView.showsVerticalScrollIndicator = NO;
 //   self.scrollView.bounces = NO;
    self.contentViewHight.constant = newHeight;
    self.imageViewAspect.constant = imageSize.height/imageSize.width;

    
    [self updateViewConstraints];
    [self.contentView setNeedsLayout];
    [self.imageView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    [self.imageView layoutIfNeeded];
    [self.imageView setImage:self.originalImage];
}


//显示隐藏状态栏黑边
- (IBAction)showBlackStatusBar:(id)sender {
    self.blackStatusBar.hidden = !self.blackStatusBar.hidden;
    self.blackStatusBarBtn.selected = !self.blackStatusBarBtn.selected;
}

//显示隐藏Dock栏黑边
- (IBAction)showBlackDock:(id)sender {
    self.blackDock.hidden = !self.blackDock.hidden;
    self.blackDockBtn.selected = !self.blackDockBtn.selected;
}

//返回
- (IBAction)back:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"要返回吗?" message:@"如果返回，则应用到当前图片的修改的所有未保存更改都会丢失。" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定按钮被点击");
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *canselAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:canselAction];

    [self presentViewController:alert animated:YES completion:nil];
    
    
}

//完成
- (IBAction)finish:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0.0);
    [self.drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

//预览
- (IBAction)preview:(id)sender {
    self.previewBtn.selected = !self.previewBtn.selected;
    self.blackStatusBarBtn.hidden = !self.blackStatusBarBtn.hidden;
    self.blackDockBtn.hidden = !self.blackDockBtn.hidden;
    self.previewUpBtn.hidden = !self.previewUpBtn.hidden;
    self.previewDownBtn.hidden = !self.previewDownBtn.hidden;
    self.statusBarLabel.hidden = !self.statusBarLabel.hidden;
    self.dockLabel.hidden = !self.dockLabel.hidden;
    self.helpLabel.hidden = !self.helpLabel.hidden;
    self.apps.hidden = !self.apps.hidden;
    NSLog(@"%d行app已显示",self.previewIndex+1);

}

//毛玻璃效果
- (IBAction)backgroundBlur:(id)sender {
    self.backgroundBlurBtn.selected = !self.backgroundBlurBtn.selected;
    self.blurUpBtn.hidden = !self.blurUpBtn.hidden;
    self.blurDownBtn.hidden = !self.blurDownBtn.hidden;
    self.blurView.tintColor = [UIColor clearColor];
    self.blurView.blurRadius = 10.0f;
    self.blurView.hidden = !self.blurView.hidden;
    NSLog(@"模糊%.2f个像素",self.blurView.blurRadius);
}

//调整模糊程度
- (IBAction)changeBlur:(UIButton *)sender {
    if (sender.tag) {
        self.blurIndex ++;
        self.blurView.blurRadius += 5.0f;
    }
    else{
        self.blurIndex --;
        self.blurView.blurRadius -= 5.0f;
    }
    NSLog(@"模糊%.2f个像素",self.blurView.blurRadius);
    self.blurUpBtn.enabled = ((self.blurIndex +1) < kMaxBlurLevel);
    self.blurDownBtn.enabled = ((self.blurIndex +1) > 1);
}

//调整app行数
- (IBAction)changePreview:(UIButton *)sender {
    if (sender.tag) {
        self.previewIndex ++;
    }
    else{
        self.previewIndex --;
    }
    switch (self.previewIndex - sender.tag) {
        case 0:
            self.apps2.hidden = !self.apps2.hidden;
            break;
        case 1:
            self.apps3.hidden = !self.apps3.hidden;
            break;
        case 2:
            self.apps4.hidden = !self.apps4.hidden;
            break;
        case 3:
            self.apps5.hidden = !self.apps5.hidden;
            break;

    }
    NSLog(@"%d行app已显示",self.previewIndex+1);
    self.previewUpBtn.enabled = ((self.previewIndex +1) < kMaxAppLevel);
    self.previewDownBtn.enabled = ((self.previewIndex +1) > 1);
}

//保存壁纸
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSString *string;
    if (error) {
        string = @"保存失败，请检查是否拥有相关的权限";
        NSLog(@"%@",string);

    }
    else{
        string = @"保存成功";
        NSLog(@"%@",string);
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *canselAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:canselAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
