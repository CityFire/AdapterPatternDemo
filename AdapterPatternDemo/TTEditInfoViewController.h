//
//  TTEditInfoViewController.h
//  TTKanKan
//
//  Created by wjc on 2017/2/10.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTEditInfoViewController : UIViewController

// 编辑完成后的跳转block（必传）
@property (nonatomic, copy) void (^completeBlock)();

@end
