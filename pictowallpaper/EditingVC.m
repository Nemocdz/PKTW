//
//  EditingVC.m
//  PKTW
//
//  Created by Nemocdz on 16/3/30.
//  Copyright © 2016年 Nemocdz. All rights reserved.
//

#import "EditingVC.h"
#import "FXBlurView.h"

@interface EditingVC ()
- (IBAction)showBlackStatusBar:(id)sender;
- (IBAction)showBlackDock:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)finish:(id)sender;
- (IBAction)preview:(id)sender;
- (IBAction)backgroundBlur:(id)sender;

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

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageViewAspect;
@property (strong, nonatomic) IBOutlet FXBlurView *blurView;

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
    CGSize contentViewSize = self.contentView.frame.size;
    
    CGFloat imgaeHeight = imageSize.height / imageSize.width * contentViewSize.width;
    CGFloat blackSpace = (contentViewSize.height - imgaeHeight);
    CGFloat newHeight = blackSpace * 2 + imgaeHeight;
    
    self.scrollView.contentOffset = CGPointMake(0,blackSpace/2);
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

}

//预览
- (IBAction)preview:(id)sender {
    self.previewBtn.selected = !self.previewBtn.selected;
    self.blackStatusBarBtn.hidden = !self.blackStatusBarBtn.hidden;
    self.blackDockBtn.hidden = !self.blackDockBtn.hidden;
    self.statusBarLabel.hidden = !self.statusBarLabel.hidden;
    self.dockLabel.hidden = !self.dockLabel.hidden;
    self.helpLabel.hidden = !self.helpLabel.hidden;
    self.apps.hidden = !self.apps.hidden;
}

//毛玻璃效果
- (IBAction)backgroundBlur:(id)sender {
    self.backgroundBlurBtn.selected = !self.backgroundBlurBtn.selected;
    self.blurView.tintColor = [UIColor clearColor];
    self.blurView.blurRadius = 10.0f;
    self.blurView.hidden = !self.blurView.hidden;

}
@end
