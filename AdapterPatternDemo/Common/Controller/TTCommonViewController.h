//
//  TTCommonViewController.h
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTCommonGroup;

NS_ASSUME_NONNULL_BEGIN

@interface TTCommonViewController : UIViewController

- (UITableView *)tableView;

- (NSMutableArray<TTCommonGroup *> *)datas;

@end

NS_ASSUME_NONNULL_END
