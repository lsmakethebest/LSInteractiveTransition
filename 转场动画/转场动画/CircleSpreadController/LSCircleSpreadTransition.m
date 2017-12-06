//
//  LSCircleSpreadTransition.m
//  转场动画
//
//  Created by liusong on 2017/12/6.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import "LSCircleSpreadTransition.h"

@interface LSCircleSpreadTransition()<CAAnimationDelegate>

@property (nonatomic, assign) LSCircleSpreadTransitionType type;

@end

@implementation LSCircleSpreadTransition

+ (instancetype)transitionWithTransitionType:(LSCircleSpreadTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(LSCircleSpreadTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case LSCircleSpreadTransitionTypePush:
            [self pushAnimation:transitionContext];
            break;
            
        case LSCircleSpreadTransitionTypePop:
            [self popAnimation:transitionContext];
            break;
    }
}



- (void)pushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];

   
    //画两个圆路径
    CGRect buttonFrame=CGRectMake(40, 40, 50, 50);
    CGFloat x = MAX(buttonFrame.origin.x, containerView.frame.size.width - buttonFrame.origin.x);
    CGFloat y = MAX(buttonFrame.origin.y, containerView.frame.size.height - buttonFrame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
  
    
    UIBezierPath *startCycle =  [UIBezierPath bezierPathWithOvalInRect:buttonFrame];
    UIBezierPath *endCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    
    
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCycle.CGPath;
    //将maskLayer作为toVC.View的遮盖
    toVC.view.layer.mask = maskLayer;
    
    
    
    
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    //动画是加到layer上的，所以必须为CGPath，再将CGPath桥接为OC对象
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}
- (void)popAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC= [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    
    [[transitionContext containerView] addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    
    
    //画两个圆路径
    CGRect buttonFrame=CGRectMake(40, 40, 50, 50);
    CGFloat x = MAX(buttonFrame.origin.x, containerView.frame.size.width - buttonFrame.origin.x);
    CGFloat y = MAX(buttonFrame.origin.y, containerView.frame.size.height - buttonFrame.origin.y);
    CGFloat radius = sqrtf(pow(x, 2) + pow(y, 2));
    
    
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:buttonFrame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
        [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    CAKeyframeAnimation *alphaAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.values=@[@1,@0,@0];
    alphaAnimation.keyTimes=@[@0.5,@0.8,@1];
    
    alphaAnimation.duration=0.5;
    [alphaAnimation setValue:transitionContext forKey:@"transitionContext"];
    alphaAnimation.delegate=self;
    alphaAnimation.autoreverses=NO;
    alphaAnimation.fillMode=kCAFillModeForwards;
//    [fromVC.view.layer addAnimation:alphaAnimation forKey:@"alpha"];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    switch (_type) {
            
        case LSCircleSpreadTransitionTypePush:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            //此方法会把fromView自动移除   如果为NO创建完会立刻销毁
            //如果为NO  toVC.view自动销毁了 所以不用判断
            [transitionContext completeTransition:YES];
            break;
        }
        case LSCircleSpreadTransitionTypePop:{
            id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
            
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if ([transitionContext transitionWasCancelled]) {
                NSLog(@"");
                [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
            }
            break;
        }
    }
}
@end
