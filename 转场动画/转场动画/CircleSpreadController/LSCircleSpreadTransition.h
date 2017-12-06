//
//  LSCircleSpreadTransition.h
//  转场动画
//
//  Created by liusong on 2017/12/6.
//  Copyright © 2017年 liusong. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LSCircleSpreadTransitionType) {
    LSCircleSpreadTransitionTypePush = 0,
    LSCircleSpreadTransitionTypePop
};


@interface LSCircleSpreadTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(LSCircleSpreadTransitionType)type;

@end
