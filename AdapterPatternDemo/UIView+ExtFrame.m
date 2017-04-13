//
//  UIView+ExtFrame.m
//
//  Created by kankan on 14-5-26.
//  Copyright (c) 2014年 kankan. All rights reserved.
//

#import "UIView+ExtFrame.h"

@implementation UIView (ExtFrame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)top{
    return self.frame.origin.y;
}

- (CGFloat)bottom{
    return self.frame.size.height + self.frame.origin.y;
}

- (CGFloat)left{
    return self.frame.origin.x;
}

- (CGFloat)right{
    return self.frame.size.width + self.frame.origin.x;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setTop:(CGFloat)top{
    self.frame = CGRectMake(self.frame.origin.x, top, self.frame.size.width, self.frame.size.height);
}

- (void)setLeft:(CGFloat)left{
    self.frame = CGRectMake(left, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)setBottom:(CGFloat)bottom{
    self.frame = CGRectMake(self.frame.origin.x, bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (void)setRight:(CGFloat)right{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, right - self.frame.size.width, self.frame.size.height);
}

- (void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

/*
 设置圆角
 corneradius 圆角半径
 borderColor 边界颜色
 borderWidth 边界宽度
 */
- (void)setCorneradius:(CGFloat)corneradius withColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth{
    self.layer.cornerRadius = corneradius;
    if (borderColor) {
        self.layer.borderColor = borderColor.CGColor;
    }
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}

- (void)kkPopPopView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kKKPopViewExitNotification" object:self];
}

- (CGRect)calcFrameToView:(UIView *)view{
    CGRect frame1 = self.frame;
    CGRect frame2 = [self.superview convertRect:frame1 toView:view];
    return frame2;
}

/**
 ** lineView:    需要绘制成虚线的view
 ** lineLength:  虚线的宽度
 ** lineSpacing: 虚线的间距
 ** lineColor:   虚线的颜色
 **/
- (void)drawDashLine :(NSInteger)lineLength lineSpacing:(NSInteger)lineSpacing lineColor:(UIColor *)lineColor
{

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setStrokeColor:lineColor.CGColor];
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInteger:lineLength],
                                  [NSNumber numberWithInteger:lineSpacing], nil]];
    [self.layer addSublayer:shapeLayer];
}

@end
