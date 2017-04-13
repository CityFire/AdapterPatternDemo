//
//  TTCommonItem.m
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "TTCommonItem.h"

static float kDefaultCellHeight = 45.0;

@implementation TTCommonItem

#pragma mark - initialized method

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title
                             subTitle:(nullable NSString *)subTitle
                                cellHeight:(CGFloat)cellHeight
                                   iconName:(nullable NSString *)iconName {
    NSAssert(title.length > 0, @"title不能为空");
    NSAssert(cellHeight > 0, @"cell高度小于0");
    TTCommonItem *item = [[self alloc] init];
    item.title = title;
    item.subTitle = subTitle;
    item.cellHeight = cellHeight;
    item.iconName = iconName;
    return item;
}

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title
                             subTitle:(nullable NSString *)subTitle
                                cellHeight:(CGFloat)cellHeight {
    return [self itemWithTitle:title
                      subTitle:subTitle
                         cellHeight:cellHeight
                            iconName:nil];
}


+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title
                           cellHeight:(CGFloat)cellHeight
                             iconName:(nullable NSString *)iconName {
    return [self itemWithTitle:title
                      subTitle:nil
                        cellHeight:cellHeight
                          iconName:iconName];
}

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title
                             iconName:(nullable NSString *)iconName {
    return [self itemWithTitle:title
                      subTitle:nil
                    cellHeight:kDefaultCellHeight
                      iconName:iconName];
}

+ (nonnull instancetype)itemWithTitle:(nonnull NSString *)title {
    return [self itemWithTitle:title
                    cellHeight:kDefaultCellHeight
                      iconName:nil];
}

@end
