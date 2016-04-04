//
//  EditingVC.m
//  PKTW
//
//  Created by Nemocdz on 16/3/30.
//  Copyright © 2016年 Nemocdz. All rights reserved.
//

#import "EditingVC.h"


@interface EditingVC ()
- (IBAction)showBlackStatusBar:(id)sender;
- (IBAction)showBlackDock:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)finish:(id)sender;
- (IBAction)preview:(id)sender;
- (IBAction)backgroundBlur:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *blackStatusBar;
@property (strong, nonatomic) IBOutlet UIImageView *blackDock;
@property (strong, nonatomic) IBOutlet UIButton *blackStatusBarBtn;
@property (strong, nonatomic) IBOutlet UIButton *blackDockBtn;
@property (strong, nonatomic) IBOutlet UIButton *backgroundBlurBtn;
@property (strong, nonatomic) IBOutlet UIButton *previewBtn;
@property (strong, nonatomic) IBOutlet UILabel *statusBarLabel;
@property (strong, nonatomic) IBOutlet UILabel *dockLabel;
@property (strong, nonatomic) IBOutlet UILabel *helpLabel;
@property (strong, nonatomic) IBOutlet UIImageView *apps;

@end

@implementation EditingVC
//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}
@end
