//
//  TTLoginViewController.h
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TTLoginPushTag) {
    TTLoginPushTagFromDetailVC = 55, // 详情页
    TTLoginPushTagFromFocusVC,
};

typedef NS_ENUM(NSUInteger, TTLoginPresentTag) { // 模态进来
    TTLoginPresentTagFromDetailVC = 10, // 详情页
    TTLoginPresentTagFromFocusVC,
};

@interface TTLoginViewController : UIViewController

#pragma mark - 详情页点击进来，需要这些属性传参
/** 55是详情页 默认不传是个人中心进来 push形式*/
@property (nonatomic, assign) TTLoginPushTag fromTag;
/** 默认不传是个人中心进来 present形式*/
@property (nonatomic, assign) TTLoginPresentTag presentTag;
/** 因为跳转之类要pop回上一个页面，所以需要赋值上一个VC的对象进来 */
@property (nonatomic, weak) UIViewController *viewController;
/** 上一页需要刷新数据之类的可以调用这个Block进行数据变更 */
@property (nonatomic, copy) void (^loginSuccessBlock)();

@end
