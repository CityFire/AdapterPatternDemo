//
//  UIImage+Extension.m

//
//  Created by xiaheqi on 15/4/15.
//  Copyright (c) 2015年 JuGuang. All rights reserved.
//

#import "UIImage+Extension.h"
@implementation UIImage (Extension)
/**
 * 将UIColor变换为UIImage
 *
 **/
+ (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (UIImage *)cornerImageWithRadius:(CGFloat)radius viewSize:(CGSize)viewSize drawRect:(CGRect)drawRect
{
    CGRect rect = CGRectMake(0, 0, viewSize.width, viewSize.height);
    
    UIGraphicsBeginImageContextWithOptions(viewSize, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx,path.CGPath);
    CGContextClip(ctx);
    
    [self drawInRect:drawRect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)drawAnnulusWithColor:(UIColor *)color annulusWidth:(CGFloat)annulusWith radius:(CGFloat)radius viewSize:(CGSize)viewSize
{
    // 圆形图片
    CGRect drawRect = CGRectMake(0.0, 0.0, viewSize.width, viewSize.height);
    UIImage *oldImage = [self cornerImageWithRadius:radius viewSize:viewSize drawRect:drawRect];
    
    CGFloat imageW = oldImage.size.width + 2 * annulusWith;
    CGFloat imageH = oldImage.size.height + 2 * annulusWith;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [color set];
    CGFloat bigRadius = imageW * 0.5;
    CGContextAddArc(ctx, bigRadius, bigRadius, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx);
    
    CGFloat smallRadius = radius;
    CGContextAddArc(ctx, bigRadius, bigRadius, smallRadius, 0, M_PI * 2, 0);
    
    [oldImage drawInRect:CGRectMake(annulusWith, annulusWith, oldImage.size.width, oldImage.size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    CGImageRelease(subImageRef);
    return smallImage;
}

//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float verticalRadio = size.height*1.0/height;
    float horizontalRadio = size.width*1.0/width;
    
    float radio = 1;
    if(verticalRadio>1 && horizontalRadio>1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width = width*radio;
    height = height*radio;
    
    int xPos = (size.width - width)/2;
    int yPos = (size.height-height)/2;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (UIImage *)blurImageWithBlurRadius:(CGFloat)radius {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(radius) forKey:kCIInputRadiusKey];
    CIImage *output = [filter valueForKey:kCIOutputImageKey];
    CGRect rect = inputImage.extent;
    CGImageRef cgImage = [context createCGImage:output fromRect:rect];
    UIImage *blurImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return blurImage;
}

+ (UIImage *)imageWithBorderWidth: (CGFloat)borderWidth borderColor: (UIColor *)color size: (CGSize)size radius: (CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);

    UIBezierPath *outerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0, 0.0, size.width, size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    UIBezierPath *innerPath = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderWidth, borderWidth, size.width-2*borderWidth, size.height-2*borderWidth) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius-borderWidth, radius-borderWidth)] bezierPathByReversingPath];
    [outerPath appendPath:innerPath];
    CGContextAddPath(context, outerPath.CGPath);
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
