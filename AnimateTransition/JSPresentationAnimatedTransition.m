//
//  JSPresentationAnimatedTransition.m
//  AnimateTransition
//
//  Created by Jason on 16/8/26.
//  Copyright © 2016年 JSong. All rights reserved.
//

#import "JSPresentationAnimatedTransition.h"

@implementation JSPresentationAnimatedTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView * fromView = fromVC.view;
    UIView * toView = toVC.view;
    
    containerView.backgroundColor = [UIColor yellowColor];
    
    if (self.animationType == AnimationTypePresent) {
        //snapshot方法是很高效的截屏
        
        UIView * snap = [fromView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:snap];
        
        UIView * snap2 = [toView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:snap2];
        
        snap2.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(snap2.bounds));
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             snap2.transform = CGAffineTransformIdentity;
                         }
                         completion:^(BOOL finished) {
                             //删掉截图
                             [snap removeFromSuperview];
                             [snap2 removeFromSuperview];
                             
                             //添加视图
                             [containerView addSubview:toView];
                             
                             //结束Transition
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
        
    } else {
        UIView * snap = [toView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:snap];
        
        UIView * snap2 = [fromView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:snap2];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                         animations:^{
                             snap2.transform = CGAffineTransformMakeTranslation(0, CGRectGetHeight(snap2.bounds));
                         }
                         completion:^(BOOL finished) {
                             //删掉截图
                             [snap removeFromSuperview];
                             [snap2 removeFromSuperview];
                             
                             //添加视图
                             [containerView addSubview:toView];
                             
                             //结束Transition
                             [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                         }];
    }
}

- (void)animationEnded:(BOOL) transitionCompleted
{
    NSLog(@"===Presentation Animated Transition Ended===");
}

@end
