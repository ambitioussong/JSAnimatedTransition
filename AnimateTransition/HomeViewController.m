//
//  ViewController.m
//  AnimateTransition
//
//  Created by Jason on 16/8/26.
//  Copyright © 2016年 JSong. All rights reserved.
//

#import "HomeViewController.h"
#import "JSNavigationAnimatedTransition.h"
#import "JSPresentationAnimatedTransition.h"

@interface HomeViewController ()<UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIViewController *presentingVC;

@end

@implementation HomeViewController

- (void)injected
{
    [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"1");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = self;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(100, 100, 200, 50);
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"Custom Push" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 addTarget:self action:@selector(onButton1) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(100, 300, 200, 50);
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"Custom Present" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(onButton2) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (UINavigationControllerOperationPush == operation)
    {
        JSNavigationAnimatedTransition *jsAnimateTransition = [[JSNavigationAnimatedTransition alloc] init];
        
        return jsAnimateTransition;
    }
    return nil;
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

#pragma mark - Actions

- (void)onButton1 {
    UIViewController *toVC = [[UIViewController alloc] init];
    toVC.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:toVC animated:YES];
}

- (void)onButton2 {
    self.presentingVC = [[UIViewController alloc] init];
    UIButton *disBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.presentingVC.view addSubview:disBtn];
    disBtn.frame = CGRectMake(100, 300, 200, 50);
    disBtn.backgroundColor = [UIColor redColor];
    [disBtn setTitle:@"Custom Dismiss" forState:UIControlStateNormal];
    [disBtn addTarget:self action:@selector(onDisButton) forControlEvents:UIControlEventTouchUpInside];
    self.presentingVC.view.backgroundColor = [UIColor greenColor];
    self.presentingVC.transitioningDelegate = self;
    [self presentViewController:self.presentingVC animated:YES completion:nil];
}

- (void)onDisButton {
    [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
}

@end
