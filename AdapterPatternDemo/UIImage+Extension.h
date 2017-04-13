//
//  UIImage+Extension.h
//
//  Created by xiaheqi on 15/4/15.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color ;

/**
 * 由于平时设置圆角的方法可能带来性能损耗
 * 将方形图片变换为圆形图片
 **/
- (UIImage *)cornerImageWithRadius:(CGFloat)radius viewSize:(CGSize)viewSize drawRect:(CGRect)drawRect;

- (UIImage *)drawAnnulusWithColor:(UIColor *)color annulusWidth:(CGFloat)annulusWith radius:(CGFloat)radius viewSize:(CGSize)viewSize;

//截图&等比例缩放
-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;

// 获取高斯模糊后的图片
- (UIImage *)blurImageWithBlurRadius: (CGFloat)radius;

// 生成圆角边框的uiimage
+ (UIImage *)imageWithBorderWidth: (CGFloat)borderWidth borderColor: (UIColor *)color size: (CGSize)size radius: (CGFloat)radius;

@end
