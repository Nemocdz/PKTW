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
- (IBAction)next:(id)sender;
- (IBAction)backgroundBlur:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIImageView *blackStatusBar;
@property (strong, nonatomic) IBOutlet UIImageView *blackDock;
@property (strong, nonatomic) IBOutlet UIButton *blackStatusBarBtn;
@property (strong, nonatomic) IBOutlet UIButton *blackDockBtn;
@property (strong, nonatomic) IBOutlet UIButton *backgroundBlurBtn;

@end

@implementation EditingVC
- (BOOL)prefersStatusBarHidden{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showBlackStatusBar:(id)sender {
    self.blackStatusBar.hidden = !self.blackStatusBar.hidden;
    self.blackStatusBarBtn.selected = !self.blackStatusBarBtn.selected;
}

- (IBAction)showBlackDock:(id)sender {
    self.blackDock.hidden = !self.blackDock.hidden;
    self.blackDockBtn.selected = !self.blackDockBtn.selected;
}

- (IBAction)back:(id)sender {
    
}

- (IBAction)next:(id)sender {
    
}

- (IBAction)backgroundBlur:(id)sender {
    self.backgroundBlurBtn.selected = !self.backgroundBlurBtn.selected;
    
}
@end
