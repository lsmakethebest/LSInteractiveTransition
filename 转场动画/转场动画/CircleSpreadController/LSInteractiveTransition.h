//
//  LSInteractiveTransition.h
//  转场动画
//
//  Created by liusong on 2017/12/6.
//  Copyright © 2017年 liusong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GestureConifg)();

typedef NS_ENUM(NSUInteger, LSInteractiveTransitionGestureDirection) {//手势的方向
    LSInteractiveTransitionGestureDirectionLeft = 0,
    LSInteractiveTransitionGestureDirectionRight,
    LSInteractiveTransitionGestureDirectionUp,
    LSInteractiveTransitionGestureDirectionDown
};

typedef NS_ENUM(NSUInteger, LSInteractiveTransitionType) {//手势控制哪种转场
    LSInteractiveTransitionTypePresent = 0,
    LSInteractiveTransitionTypeDismiss,
    LSInteractiveTransitionTypePush,
    LSInteractiveTransitionTypePop,
};


@interface LSInteractiveTransition : UIPercentDrivenInteractiveTransition


//是否正在交互手势
@property (nonatomic, assign) BOOL interation;
//促发手势present的时候的config，config中初始化并present需要弹出的控制器
@property (nonatomic, copy) GestureConifg presentConifg;
//促发手势push的时候的config，config中初始化并push需要弹出的控制器
@property (nonatomic, copy) GestureConifg pushConifg;

//初始化方法
+ (instancetype)interactiveTransitionWithTransitionType:(LSInteractiveTransitionType)type GestureDirection:(LSInteractiveTransitionGestureDirection)direction;
/** 给传入的控制器添加手势*/
- (void)addPanGestureForViewController:(UIViewController *)viewController;

@end






