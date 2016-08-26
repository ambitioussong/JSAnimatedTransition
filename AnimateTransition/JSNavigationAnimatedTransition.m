//
//  JSAnimateTransition.m
//  AnimateTransition
//
//  Created by Jason on 16/8/26.
//  Copyright © 2016年 JSong. All rights reserved.
//

#import "JSNavigationAnimatedTransition.h"

@implementation JSNavigationAnimatedTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
{
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    containerView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:toVC.view];
    
    // 自定义动画
    toVC.view.transform = CGAffineTransformMakeTranslation(320, 568);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations: ^{
        
        fromVC.view.transform = CGAffineTransformMakeTranslation(-320, -568);
        toVC.view.transform = CGAffineTransformIdentity;
        
    }
                     completion:^(BOOL finished) {
        
        fromVC.view.transform = CGAffineTransformIdentity;
        
        // 过渡结束时调用 completeTransition: 这个方法
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];
}

- (void)animationEnded:(BOOL) transitionCompleted
{
    NSLog(@"===Navigation Animated Transition Ended===");
}

@end
