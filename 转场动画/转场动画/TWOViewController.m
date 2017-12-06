



//
//  TWOViewController.m
//  转场动画
//
//  Created by liusong on 2017/12/6.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "TWOViewController.h"

@interface TWOViewController ()

@end

@implementation TWOViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.interactivePopGestureRecognizer.delegate=self;
    NSLog(@"昌吉俯拾地芥偶发 发号施令断开 ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)dealloc
{
    NSLog(@"DEALLOC------------");
    
}
@end
