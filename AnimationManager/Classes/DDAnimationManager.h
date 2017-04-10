//
//  DDAnimationManager.h
//  BZHeader
//
//  Created by 李胜书 on 2017/3/31.
//  Copyright © 2017年 李胜书. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <POP/POP.h>

typedef void (^Complete)(id res);

@interface DDAnimationManager : NSObject

#pragma mark - 3D动画变换操作
/**
 3D变换第一步变换,沿x轴旋转

 @return 返回3d变换的CATransform3D
 */
- (CATransform3D )rotateXTransform;
/**
 第二步变换，缩小宽高等,以及距离上方向下space的距离

 @param ScalePoint 缩小宽高
 @param space 缩小距离上方向下space的距离
 @return 返回3d变换的CATransform3D
 */
- (CATransform3D )scaleTransform:(CGFloat)ScalePoint Space:(CGFloat)space;
/**
 3d变换变换回原样

 @return 返回3d变换的CATransform3D
 */
- (CATransform3D )resetTransform;
#pragma makr - rotate CA2D旋转
/**
 CA2D旋转的函数，作为示范方法

 @param rotatePoint 旋转的角度，度数，非弧度
 @param layer 旋转的layer
 @param keyPath 旋转的方式
 */
- (void)rotateTransform:(CGFloat)rotatePoint Layer:(CALayer *)layer KeyPath:(NSString *)keyPath;
#pragma mark - label数字跳动变化
/**
 简化的计数跳动方法

 @param label 跳动的label
 @param toNum 到哪个数字结束
 */
- (void)countNumberLabel:(UILabel *)label ToNumber:(CGFloat)toNum;
/**
 数字变化计数的方法

 @param label 计数的label
 @param fromNum 从哪个数字开始计数
 @param toNum 到哪个数字计数结束
 @param step 计数跳动的间隔
 @param during 计数跳动的时间
 */
- (void)countNumberLabel:(UILabel *)label FromNumber:(CGFloat)fromNum ToNumber:(CGFloat)toNum Step:(CGFloat)step During:(CGFloat)during;
#pragma mark - pop基本运动
/**
 view的frame变化

 @param targetView 变化的目标view,同样可以改造成layer
 @param toRect 变动后的frame
 @param block 完成变化后的block
 */
- (void)popSpringSlide:(UIView *)targetView ToRect:(CGRect)toRect ComleteBlock:(Complete)block;
/**
 pop运动渐隐渐现的变化

 @param targetView 变化的目标view
 @param toAlpha 变化的alpha
 */
- (void)popFadeInOut:(UIView *)targetView ToAlpha:(CGFloat)toAlpha;
/**
 pop layer rotate旋转，沿y轴

 @param layer 旋转的图层
 @param toPoint 旋转的角度
 @param block 完成后调用的block
 */
- (void)popRotateLayer:(CALayer *)layer ToRotatePoint:(CGFloat)toPoint ComleteBlock:(Complete)block;

@end
