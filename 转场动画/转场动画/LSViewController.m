//
//  ViewController.m
//  转场动画
//
//  Created by liusong on 2017/12/6.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSViewController.h"
#import "LSCircleSpreadTransition.h"
#import "LSInteractiveTransition.h"

@interface LSViewController ()<UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *v;
@property (nonatomic,strong) LSInteractiveTransition* interactiveTransitionPop;
@property (nonatomic, assign) UINavigationControllerOperation operation;

@end

@implementation LSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.v.layer.cornerRadius=50;
    self.v.clipsToBounds=YES;

    self.navigationController.delegate=self;
    
    
    
    //初始化手势过渡的代理
    _interactiveTransitionPop = [LSInteractiveTransition interactiveTransitionWithTransitionType:LSInteractiveTransitionTypePop GestureDirection:LSInteractiveTransitionGestureDirectionRight];
        //给当前控制器的视图添加手势
    [_interactiveTransitionPop addPanGestureForViewController:self];

}


- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    _operation = operation;
    return  [LSCircleSpreadTransition transitionWithTransitionType:operation == UINavigationControllerOperationPush?LSCircleSpreadTransitionTypePush:LSCircleSpreadTransitionTypePop];
}
-(id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    if (_operation==UINavigationControllerOperationPop) {
        return self.interactiveTransitionPop.interation?self.interactiveTransitionPop:nil;
    }
    return nil;
}


@end
