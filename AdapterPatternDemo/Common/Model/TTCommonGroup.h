//
//  TTCommonGroup.h
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//  该模型用来描述每组cell的信息，譬如组头，组尾，这组的所有row模型

#import <Foundation/Foundation.h>
@class TTCommonItem;

@interface TTCommonGroup : NSObject

@property (nonnull, nonatomic, strong) NSArray<TTCommonItem *> *items;

+ (nonnull instancetype)group;

@end
