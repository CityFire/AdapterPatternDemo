//
//  TTMineViewController.m
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "TTMineViewController.h"
#import "TTUserCenterHeaderView.h"
#import "TTCommonGroup.h"
#import "TTCommonItem.h"
#import "TTCommonArrowItem.h"
#import "TTLoginViewController.h"
#import "TTMyFavouriteViewController.h"
#import "TTMyFocusViewController.h"
#import "TTMyFansViewController.h"
#import "TTFeedbackViewController.h"
#import "TTSettingViewController.h"
#import "TTAboutViewController.h"
#import "TTEditInfoViewController.h"
#import <Masonry.h>
#import "UIColor+HexString.h"

#define MINE_INFO_VIP                        @"开通会员"
#define MINE_INFO_MESSAGE                    @"我的消息"
#define MINE_INFO_FAVORITE                   @"我的收藏"
#define MINE_INFO_FOCUS                      @"我的关注"
#define MINE_INFO_FANS                       @"我的粉丝"
#define MINE_INFO_HISTORY                    @"历史记录"
#define MINE_INFO_OFFLINE_CACHES             @"离线缓存"
#define MINE_INFO_SETTING                    @"设置"
#define MINE_INFO_ABOUT                      @"关于我们"
#define MINE_INFO_FEEDBACK                   @"意见反馈"

#define kDefaultTableViewBackgroundColor [UIColor colorWithHexString:@"f4f4f4"]
// 线条颜色
#define SeperatLineColor [UIColor colorWithHexString:@"e5e5e5"]

@interface TTMineViewController () <TTUserCenterHeaderViewDelegate> {
    BOOL _isLogin;
}

@property (nonatomic, strong) TTUserCenterHeaderView *headerView;

@property (nonatomic, strong) UIView *footerV;

@end

@implementation TTMineViewController

#pragma mark - Initlized 

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

#pragma mark - lifeCycle

id __weak obj1 = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id __strong obj0 = [[NSObject alloc] init];
    NSLog(@"obj0:%@", obj0);
    obj1 = obj0;
    
    NSLog(@"A:%@", obj1);
    
    [self initView];
}

- (void)initView {
    NSLog(@"B:%@", obj1);
    
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerV;
    
    NSArray<NSArray *> *titleArray = @[@[MINE_INFO_FAVORITE,
                                         MINE_INFO_FOCUS,
                                         MINE_INFO_FANS],
                                       @[MINE_INFO_SETTING,
                                         MINE_INFO_FEEDBACK,
                                         MINE_INFO_ABOUT]];
    NSArray<NSArray *> *iconArray = @[@[@"icon_myfavs", @"icon_mylike", @"icon_myfans"], @[@"icon_site", @"icon_feedback", @"icon_about"]];
    NSArray<NSArray *> *jumpClassArray = @[
                                        @[[TTMyFavouriteViewController class],
                                          [TTMyFocusViewController class],
                                          [TTMyFansViewController class]],
                                        @[[TTSettingViewController class],
                                          [TTFeedbackViewController class],
                                          [TTAboutViewController class]]];
    
    [titleArray enumerateObjectsUsingBlock:^(NSArray * _Nonnull arr, NSUInteger idx, BOOL * _Nonnull stop) {
        TTCommonGroup *group = [TTCommonGroup group];
        [self.datas addObject:group];
        
        NSMutableArray<TTCommonItem *> *items = [NSMutableArray array];
        
        [arr enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger index, BOOL * _Nonnull stop) {
            TTCommonItem *item = nil;
            item = [TTCommonArrowItem itemWithTitle:title iconName:iconArray[idx][index]];
            item.jumpVClass = NSClassFromString(NSStringFromClass(jumpClassArray[idx][index]));
            if (idx == 0 && (index == 1 || index == 2)) {
                item.isJumpVC = _isLogin;
                if (!item.isJumpVC) {
                    item.OperationBlock = ^() {
                        // TO DO
                    };
                }
                // 用户被屏蔽的情况
                if (index == 1 || index == 2) {
                    if (_isLogin) {
                        item.isJumpVC = _isLogin;
                        item.OperationBlock = ^() {
                            // TO DO
                        };
                    }
                }
//                else {
//                    item.badgeValue = @"2";
//                }
            }
            else {
//                if (idx == 1 && index == 1) {
//                    item.jumpMode = TTCommonItemJumpModePresent;
//                }
                item.isJumpVC = YES;
            }
            [items addObject:item];
        }];
        group.items = items;
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 目前逻辑是有屏蔽才重新请求，否则不请求，运营那边审核不通过会被屏蔽
    [self.navigationController.navigationBar setHidden:YES];
    NSLog(@"B:%@", obj1);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - 用户登录或注销后更新相关视图UI

- (void)updateUIAfterLoginOrLogout:(BOOL)isLogin {
    if (isLogin) {
        [self.headerView updateUserInfo:nil login:isLogin];
    }
    else {
        [self.headerView updateUserInfo:nil login:isLogin];
    }
    
    [self.tableView reloadData];
}

#pragma mark - TTUserCenterHeaderViewDelegate

- (void)headerViewDidClickButton:(TTUserCenterHeaderView *)view {
    TTLoginViewController *vc = [[TTLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)headerViewDidClickEdit:(TTUserCenterHeaderView *)view {
    if (_isLogin) {
        TTEditInfoViewController *vc = [TTEditInfoViewController new];
        __weak typeof(self) weakSelf = self;
        vc.completeBlock = ^() {
             [weakSelf updateUIAfterLoginOrLogout:_isLogin];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0.0) {
        [self.headerView viewScrollOffset:offsetY];
    }
}

#pragma mark - 头视图初始化

- (TTUserCenterHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TTUserCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 215.0+15.0)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (UIView *)footerV {
    if (!_footerV) {
        _footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 15.0)];
        _footerV.backgroundColor = kDefaultTableViewBackgroundColor;
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
        lineV.backgroundColor = SeperatLineColor;
        [_footerV addSubview:lineV];
    }
    return _footerV;
}

@end
