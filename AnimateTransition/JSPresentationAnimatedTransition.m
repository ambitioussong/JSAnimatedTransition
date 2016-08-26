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
    return 0.3f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIView * fromView = fromVC.view;
    UIView * toView = toVC.view;
    
    containerView.backgroundColor = [UIColor whiteColor];
    
    if (self.animationType == AnimationTypePresent) {
        //snapshot方法是很高效的截屏
        
        UIView * snap = [fromView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:snap];
        
        UIView * snap2 = [toView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:snap2];
        
        snap2.transform = CGAffineTransformMakeTranslation(-320, 0);
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear
                         animations: ^{
            
            snap2.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
            
            //删掉截图
            [snap removeFromSuperview];
            [snap2 removeFromSuperview];
            
            //添加视图
            [[transitionContext containerView] addSubview:toView];
            
            //结束Transition
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        
    } else {
        UIView * snap = [toView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:snap];
        
        UIView * snap2 = [fromView snapshotViewAfterScreenUpdates:YES];
        [containerView addSubview:snap2];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:0
                            options:UIViewAnimationOptionCurveLinear animations: ^{
            
            snap2.transform = CGAffineTransformMakeTranslation(-320, 0);
            
        } completion:^(BOOL finished) {
            
            //删掉截图
            [snap removeFromSuperview];
            [snap2 removeFromSuperview];
            
            //添加视图
            [[transitionContext containerView] addSubview:toView];
            
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
