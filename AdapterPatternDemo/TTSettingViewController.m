//
//  TTSettingViewController.m
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "TTSettingViewController.h"
#import "TTCommonGroup.h"
#import "TTCommonSwitchItem.h"
#import "TTSettingManager.h"
#import "UIColor+HexString.h"
#import "UIView+ExtFrame.h"
#import "UIImage+Extension.h"
#import "TTAlertView.h"
#import <Masonry.h>

#define kCellHeight 45.0
#define kDefaultTableViewBackgroundColor [UIColor colorWithHexString:@"f4f4f4"]
// 线条颜色
#define SeperatLineColor [UIColor colorWithHexString:@"e5e5e5"]

static const CGFloat kCellLineHeight = 0.5;

@interface TTSettingViewController ()
{
    bool _isLogin;
}

@property (nonatomic, strong) UIView *footerView;

@property (nonatomic, strong) UIButton *logoutBtn;

@property (nonatomic, strong) UIView *footerV;

@end

@implementation TTSettingViewController

#pragma mark - LifeCycle

- (void)initView {
    self.title = @"设置";
    _isLogin = YES;
    
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 15.0)];
    v.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, v.height-kCellLineHeight, SCREENWIDTH, kCellLineHeight)];
    lineV.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [v addSubview:lineV];
    self.tableView.tableHeaderView = v;
    
    if (_isLogin) {
        self.tableView.tableFooterView = self.footerView;
    }
    else {
        self.tableView.tableFooterView = self.footerV;
    }
    
    TTCommonGroup *group0 = [TTCommonGroup group];
    [self.datas addObject:group0];
    
    TTCommonSwitchItem *item01 = [TTCommonSwitchItem itemWithTitle:@"使用2G/3G/4G网络播放" cellHeight:kCellHeight iconName:nil];
    item01.switchType = TTCommonSwitchTypePlay;
    item01.OperationWithParamBlock = ^(UISwitch *s) {
        BOOL on = [[TTSettingManager shareInstance] getNetworkPlayDefaultSettingByKey:kdefaultNetworkPlaySettingSwitch];
//        BOOL on = s.on;
        if (on) {
            [TTAlertView showAlertWithTitle:@"提醒" message:@"2G/3G/4G播放会产生较多流量，确定使用？" clickAction:^(NSInteger buttonIndex) {
                if (buttonIndex == 0) {
//                    NSLog(@".......不允许播放");
                    s.on = NO;
                    [[TTSettingManager shareInstance] setNetworkPlayDefaultSetting:s.on forKey:kdefaultNetworkPlaySettingSwitch];
                }
//                else {
//                    NSLog(@".......允许播放");
//                }
            } cancelButtonTitle:@"取消" otherButtonTitles:@[@"打开开关"]];
        }
        else {
            NSLog(@"禁止播放");
        }
    };
    TTCommonSwitchItem *item11 = [TTCommonSwitchItem itemWithTitle:@"使用2G/3G/4G网络下载" cellHeight:kCellHeight iconName:nil];
    item11.switchType = TTCommonSwitchTypeDownload;
    item11.OperationWithParamBlock = ^(UISwitch *s) {
        BOOL on = [[TTSettingManager shareInstance] getNetworkPlayDefaultSettingByKey:kdefaultNetworkDownloadSettingSwitch];
        if (on) {
            [TTAlertView showAlertWithTitle:@"提醒" message:@"2G/3G/4G下载会产生较多流量，确定使用？" clickAction:^(NSInteger buttonIndex) {
                if (buttonIndex == 0) {
//                    TTLog(@".......不允许下载");
                    s.on = NO;
                    [[TTSettingManager shareInstance] setNetworkDownloadDefaultSetting:s.on forKey:kdefaultNetworkDownloadSettingSwitch];
                }
//                else {
//                    TTLog(@".......允许下载");
//                }
            } cancelButtonTitle:@"取消" otherButtonTitles:@[@"打开开关"]];
        }
        else {
            NSLog(@"禁止下载");
        }
    };
    group0.items = @[item01];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(0);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(SCREENHEIGHT);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

#pragma mark - 通知回调

- (void)popSelf {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - touch event

- (void)logoutAction {
    NSString *alertMsg = @"确定退出当前账号吗？";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"天天看看" message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }]];
    
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - getter methods

- (UIView *)footerV {
    if (!_footerV) {
        _footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10.0)];
        _footerV.backgroundColor = kDefaultTableViewBackgroundColor;
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kCellLineHeight)];
        lineV.backgroundColor = SeperatLineColor;
        [_footerV addSubview:lineV];
    }
    return _footerV;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 67.0)];
        _footerView.backgroundColor = kDefaultTableViewBackgroundColor;
        [_footerView addSubview:self.logoutBtn];
        self.logoutBtn.frame = CGRectMake(0, 23, SCREENWIDTH, 44.0);
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kCellLineHeight)];
        lineV.backgroundColor = SeperatLineColor;
        [_footerView addSubview:lineV];
        
        lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 23, SCREENWIDTH, kCellLineHeight)];
        lineV.backgroundColor = SeperatLineColor;
        [_footerView addSubview:lineV];
        
        lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 66.5, SCREENWIDTH, kCellLineHeight)];
        lineV.backgroundColor = SeperatLineColor;
        [_footerView addSubview:lineV];
    }
    return _footerView;
}

- (UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutBtn setTitle:@"退出账号" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:[UIColor colorWithHexString:@"FE4153"] forState:UIControlStateNormal];
        [_logoutBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_logoutBtn setBackgroundImage:[UIImage createImageWithColor:SeperatLineColor] forState:UIControlStateSelected];
        [_logoutBtn setBackgroundImage:[UIImage createImageWithColor:SeperatLineColor] forState:UIControlStateHighlighted];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_logoutBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_logoutBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_logoutBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}

@end
