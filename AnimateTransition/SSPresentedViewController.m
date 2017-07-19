//
//  SSPresentedViewController.m
//  AnimateTransition
//
//  Created by CIZ on 2017/7/19.
//  Copyright © 2017年 JSong. All rights reserved.
//

#import "SSPresentedViewController.h"
#import "JSPresentationAnimatedTransition.h"
#import "SSPresentationController.h"

@interface SSPresentedViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation SSPresentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    UIButton *disBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:disBtn];
    disBtn.frame = CGRectMake(100, 300, 200, 50);
    disBtn.backgroundColor = [UIColor redColor];
    [disBtn setTitle:@"Custom Dismiss" forState:UIControlStateNormal];
    [disBtn addTarget:self action:@selector(onDisButton) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [UIColor greenColor];
    self.transitioningDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {

    JSPresentationAnimatedTransition *customPresentation = [[JSPresentationAnimatedTransition alloc] init];
    customPresentation.animationType = AnimationTypePresent;
    return customPresentation;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    JSPresentationAnimatedTransition *customPresentation = [[JSPresentationAnimatedTransition alloc] init];
    customPresentation.animationType = AnimationTypeDismiss;
    return customPresentation;
}

//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source {
//    SSPresentationController *presentation = [[SSPresentationController alloc] initWithPresentedViewController:presented
//                                                                                      presentingViewController:presenting];
//    
//    return presentation;
//}

- (void)onDisButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
