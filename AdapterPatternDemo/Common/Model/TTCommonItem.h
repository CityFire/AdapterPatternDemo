//
//  TTCommonItem.h
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TTCommonItemJumpMode) {
    TTCommonItemJumpModePush = 1, // Push
    TTCommonItemJumpModePresent,  // Present
};

@interface TTCommonItem : NSObject

// 标题
@property (nonnull, nonatomic, copy) NSString *title;

// 图标名
@property (nullable, nonatomic, copy) NSString *iconName;

// 子标题
@property (nullable, nonatomic, copy) NSString *subTitle;

// 数字标记提醒
@property (nullable, nonatomic, copy) NSString *badgeValue;

// cell高度
@property (nonatomic, assign) CGFloat cellHeight;

// 左右间距 不同Cell可能间距不一样，默认是当没有图片时是15
@property (nonatomic, assign) CGFloat horizontalMargin;

/** isJumpVC为YES才能跳转对应类，否则执行相关的Block做对应的操作 */
@property (nonatomic, assign) BOOL isJumpVC;

// 需要跳转的类
@property (nullable, nonatomic, assign) Class jumpVClass;

/** 默认是push形式,可以设置 */
@property (nonatomic, assign) TTCommonItemJumpMode jumpMode;

#pragma mark - callback 类似代理，具体实现需要传target和sel
// 目标对象
@property (nonnull, nonatomic, assign) id target;

// 响应target的选择器SEL
@property (nonnull, nonatomic, assign) SEL selector;

// 响应target的选择器需要携带的参数
@property (nullable, nonatomic, strong) NSDictionary *params;

// 需要跳转执行相关的Block操作（例如跳转到AppStore评分）
@property (nullable, nonatomic, copy) void (^OperationBlock)();

#pragma mark - designated initialized method

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title
                           subTitle:(nullable NSString *)subTitle
                               cellHeight:(CGFloat)cellHeight
                                   iconName:(nullable NSString *)iconName;

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title
                             subTitle:(nullable NSString *)subTitle
                           cellHeight:(CGFloat)cellHeight;

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title
                           cellHeight:(CGFloat)cellHeight
                             iconName:(nullable NSString *)iconName;

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title
                             iconName:(nullable NSString *)iconName;

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title;

@end

