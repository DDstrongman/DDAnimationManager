//
//  DDAnimationManager.m
//  BZHeader
//
//  Created by 李胜书 on 2017/3/31.
//  Copyright © 2017年 李胜书. All rights reserved.
//

#import "DDAnimationManager.h"

@implementation DDAnimationManager

#pragma mark - 3d变换操作
- (CATransform3D )rotateXTransform {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0/ -900;
    //---宽高缩小0.9
    transform = CATransform3DScale(transform, 0.95, 0.95, 1);
    //---绕X轴旋转15度
    transform = CATransform3DRotate(transform, 15.0 * M_PI / 180.0 , 1, 0, 0);
    
    return transform;
}

- (CATransform3D )scaleTransform:(CGFloat)ScalePoint Space:(CGFloat)space{
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0/ -900;
    //---向上移动的高度
    transform = CATransform3DTranslate(transform, 0, space , 0);
    //---宽高缩小ScalePoint
    transform = CATransform3DScale(transform, ScalePoint, ScalePoint, 1);
    
    return transform;
}

- (CATransform3D )resetTransform {
    CATransform3D transform = CATransform3DIdentity;
    return transform;
}
#pragma mark - 2D变换
- (void)rotateTransform:(CGFloat)rotatePoint Layer:(CALayer *)layer KeyPath:(NSString *)keyPath {
    //rotation Animation
    CABasicAnimation *animationImage = [CABasicAnimation animationWithKeyPath:keyPath];
//    animationImage.fromValue = @(0);
    animationImage.toValue = @(rotatePoint/360*M_PI);
    animationImage.duration = 2.0f;
    animationImage.fillMode = kCAFillModeForwards;
    [layer addAnimation:animationImage forKey:keyPath];
}
#pragma mark - label数字变化
- (void)countNumberLabel:(UILabel *)label ToNumber:(CGFloat)toNum {
    [self countNumberLabel:label FromNumber:0 ToNumber:toNum Step:0.01 During:1.0];
}

- (void)countNumberLabel:(UILabel *)label FromNumber:(CGFloat)fromNum ToNumber:(CGFloat)toNum Step:(CGFloat)step During:(CGFloat)during {
    // 初始化
    POPBasicAnimation *anim = [POPBasicAnimation animation];
    // 限时
    anim.duration = during;
    POPAnimatableProperty * prop = [POPAnimatableProperty propertyWithName:@"count++" initializer:^(POPMutableAnimatableProperty *prop) {
        prop.readBlock = ^(id obj, CGFloat values[]){ values[0] = [[obj description] floatValue]; };
        prop.writeBlock = ^(id obj, const CGFloat values[])
        {
            [obj setText:[NSString stringWithFormat:@"%.2f",values[0]]];
        };
        prop.threshold = step;
    }];
    
    anim.property = prop;
    anim.fromValue = [NSNumber numberWithFloat:fromNum];
    anim.toValue = [NSNumber numberWithFloat:toNum];
    [label pop_addAnimation:anim forKey:@"counting"];
}
#pragma mark - pop基本运动
- (void)popSpringSlide:(UIView *)targetView ToRect:(CGRect)toRect ComleteBlock:(Complete)block {
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:toRect];
    anim.velocity = [NSValue valueWithCGRect:targetView.frame];
    anim.springBounciness = 5.0;
    anim.springSpeed = 10;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            if (block) {
                block(anim);
            }
        }
    };
    [targetView pop_addAnimation:anim forKey:@"slider"];
}

- (void)popFadeInOut:(UIView *)targetView ToAlpha:(CGFloat)toAlpha {
    POPBasicAnimation *anim = [POPBasicAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anim.fromValue = @(targetView.alpha);
    anim.toValue = @(toAlpha);
    [targetView pop_addAnimation:anim forKey:@"fade"];
}

- (void)popRotateLayer:(CALayer *)layer ToRotatePoint:(CGFloat)toPoint ComleteBlock:(Complete)block {
    POPSpringAnimation *anim = [POPSpringAnimation animation];
    anim.property = [POPAnimatableProperty propertyWithName:kPOPLayerRotationY];
    anim.toValue = @0;
    anim.velocity = @(toPoint);
    anim.springBounciness = 10.0;
    anim.springSpeed = 1.0;
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            if (block) {
                block(anim);
            }
        }
    };
    [layer pop_addAnimation:anim forKey:@"rotate"];
}

@end
