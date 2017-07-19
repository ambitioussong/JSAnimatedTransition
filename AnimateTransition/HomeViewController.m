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
#import "SSPresentationController.h"
#import "SSPresentedViewController.h"

@interface HomeViewController ()<UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) SSPresentedViewController             *presentedVC;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition  *interactionController;

@end

@implementation HomeViewController

- (void)injected
{
    [self.presentedVC dismissViewControllerAnimated:YES completion:nil];
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
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(didClickPanGestureRecognizer:)];
    [self.navigationController.view addGestureRecognizer:panRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didClickPanGestureRecognizer:(UIPanGestureRecognizer*)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self presentViewController:self.presentedVC animated:YES completion:nil];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:self.view];
        CGFloat percent = fabs(translation.x / CGRectGetWidth(self.view.bounds));
        [self.interactionController updateInteractiveTransition:percent];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint translation = [recognizer translationInView:self.view];
        CGFloat percent = fabs(translation.x / CGRectGetWidth(self.view.bounds));
        if (percent > 0.5) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}

#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (UINavigationControllerOperationPush == operation) {
        JSNavigationAnimatedTransition *jsAnimateTransition = [[JSNavigationAnimatedTransition alloc] init];
        
        return jsAnimateTransition;
    }
    return nil;
}



//- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source {
//    SSPresentationController *presentation = [[SSPresentationController alloc] initWithPresentedViewController:presented
//                                                                                      presentingViewController:presenting];
//    
//    return presentation;
//}

#pragma mark - Actions

- (void)onButton1 {
    UIViewController *toVC = [[UIViewController alloc] init];
    toVC.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:toVC animated:YES];
}

- (void)onButton2 {
    [self presentViewController:self.presentedVC animated:YES completion:nil];
}

#pragma mark - Getters

- (SSPresentedViewController *)presentedVC {
    if (!_presentedVC) {
        _presentedVC = [[SSPresentedViewController alloc] init];
    }
    return _presentedVC;
}

@end
