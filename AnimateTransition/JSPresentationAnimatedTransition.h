//
//  JSPresentationAnimatedTransition.h
//  AnimateTransition
//
//  Created by Jason on 16/8/26.
//  Copyright © 2016年 JSong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AnimationType) {
    
    AnimationTypePresent,
    AnimationTypeDismiss
};

@interface JSPresentationAnimatedTransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) AnimationType animationType;

@end
