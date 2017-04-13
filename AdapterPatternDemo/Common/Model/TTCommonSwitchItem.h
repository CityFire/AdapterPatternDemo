//
//  TTCommonSwitchItem.h
//  TTKanKan
//
//  Created by wjc on 2016/12/27.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "TTCommonItem.h"

typedef NS_ENUM(NSUInteger, TTCommonSwitchType) {
    TTCommonSwitchTypePlay = 0, // 网络播放开关
    TTCommonSwitchTypeDownload, // 网络下载开关
};

@interface TTCommonSwitchItem : TTCommonItem

@property (nonatomic, assign) TTCommonSwitchType switchType;

// 带参数的
@property (nonatomic, copy) void (^OperationWithParamBlock) (UISwitch *s);

@end
