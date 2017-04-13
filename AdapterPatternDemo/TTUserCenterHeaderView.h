//
//  TTPersonCenterHeaderView.h
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTUserCenterHeaderView;
@class KanKanUserModel;

@protocol TTUserCenterHeaderViewDelegate <NSObject>

@required
- (void)headerViewDidClickButton:(TTUserCenterHeaderView *)view;

- (void)headerViewDidClickEdit:(TTUserCenterHeaderView *)view;

@end

@interface TTUserCenterHeaderView : UIView

@property (nonatomic, weak) id<TTUserCenterHeaderViewDelegate>delegate;

// 登录后更新用户信息
- (void)updateUserInfo:(KanKanUserModel *)model login:(BOOL)isLogin;

- (void)viewScrollOffset:(CGFloat)offset;

@end
