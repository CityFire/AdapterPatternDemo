//
//  TTCommonCell.h
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTCommonItem;

@interface TTCommonCell : UITableViewCell

@property (nonnull, nonatomic, strong) TTCommonItem *item;

- (void)setIndexPath:(nonnull NSIndexPath *)indexPath
        rowsInSection:(NSInteger)rows;

@end
