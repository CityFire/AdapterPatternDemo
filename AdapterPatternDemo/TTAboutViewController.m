//
//  TTAboutViewController.m
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "TTAboutViewController.h"
#import "TTCommonGroup.h"
#import "TTCommonLabelItem.h"
#import "TTCommonArrowItem.h"
#import "TTFeedbackViewController.h"
#import "TTSettingManager.h"
#import "UIColor+HexString.h"
#import <Masonry.h>

#warning id上架前需要更换
static NSString * const kJumpAppStoreUrl = @"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=466321750&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8";
#define tt_lookup_app_url  @"https://itunes.apple.com/lookup?id=466321750"
// 表格视图默认背景色
#define kDefaultTableViewBackgroundColor [UIColor colorWithHexString:@"f4f4f4"]
#define KKDefaultBackgroundColor [UIColor colorWithHexString:@"f4f4f4"]
// 线条颜色
#define SeperatLineColor [UIColor colorWithHexString:@"e5e5e5"]

@interface TTAboutViewController ()

@property (nonnull, nonatomic, strong) TTCommonGroup *group0;

@property (nonatomic, copy) NSString *trackViewUrl;

@property (nonatomic, copy) NSString *downloadUrl;

@property (nonatomic, copy) NSString *currentVersion;

@property (nonatomic, copy) NSString *onlineVersion;

@property (nonatomic, copy) NSString *rightTitle;

@end

@implementation TTAboutViewController

// app启动时获取一次
+ (void)load {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic valueForKey:@"CFBundleShortVersionString"];
//    NSDictionary *param = @{@"ver":currentVersion, @"os":@"ios"};
    // 做法1.服务器接口
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [TTDataRequest requestVersionUpdateWithParam:param Handler:^(NSDictionary *resultDict, NSInteger code, NSString *message) {
        NSDictionary *resultDict;
    NSInteger code = 0;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (code == 0) {
            if (resultDict) {
                CGFloat versionOnline = [[resultDict objectForKey:@"latestVersion"] floatValue];
                NSString *downloadUrl = [resultDict objectForKey:@"latestUrl"];
                NSLog(@"downloadUrl:%@", downloadUrl);
                NSInteger type = [[resultDict objectForKey:@"type"] integerValue];
                NSString *upgradeMessage = [resultDict objectForKey:@"upgradeMessage"];
                NSLog(@"upgradeMessage:%@", upgradeMessage);
                if (type == 2) {
                    NSLog(@"弹出框提示");
                }
                else if (type == 0) {
                    NSLog(@"无升级");
                }
                else if (type == 1) {
                    NSLog(@"手动检查升级时提示");
                }
                else if (type == 3) {
                    NSLog(@"强制升级");
                }
                /** NO 为没有更新，YES 为有新版本*/
                if (versionOnline <= [currentVersion floatValue] || type == 0) {
                    // 无新版
                    [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
                }
                else {
                    // 有更新
                    [[TTSettingManager shareInstance] setBool:YES forKey:kNewVersionCheck];
                }
            }
            else {
                // 无新版
                [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
            }
        }
        else {
            [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
        }
//    }];
    
    // 做法2：苹果AppStore查找app信息的接口
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    [manager GET:tt_lookup_app_url parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        NSDictionary *resultDict = (NSDictionary *)responseObject;
//        if (resultDict) {
//            NSArray *res = [resultDict objectForKey:@"results"];
//            NSDictionary *dict = res[0];
//            CGFloat versionOnline = [[dict objectForKey:@"version"] floatValue];
//            /** NO 为没有更新，YES 为有新版本*/
//            if (versionOnline > [currentVersion floatValue]) {
//                // 有更新
//                [[TTSettingManager shareInstance] setBool:YES forKey:kNewVersionCheck];
//            }
//            else {
//                // 无新版
//                [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
//            }
//        }
//        else {
//            // 无新版
//            [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        // 审核期间隐藏新版更新功能 无新版
//        if (error) {
//            [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
//        }
//    }];
}

#pragma mark - LifeCycle

- (void)initView {
    self.title = @"关于我们";
    self.tableView.backgroundColor = kDefaultTableViewBackgroundColor;
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150.0)];
    v.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = v;
    
    UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 0.5)];
    lineV.backgroundColor = SeperatLineColor;
    self.tableView.tableFooterView = lineV;
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_about_us_logo"]];
//    icon.backgroundColor = [UIColor colorWithHexString:@"ebebeb"];
    icon.layer.cornerRadius = 17.0;
    icon.layer.masksToBounds = YES;
    [v addSubview:icon];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(v);
        make.size.mas_equalTo(CGSizeMake(76, 76));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = SeperatLineColor;
    [v addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(v);
        make.height.mas_equalTo(0.5);
        make.left.right.mas_equalTo(v);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).with.offset(0);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(SCREENHEIGHT);
    }];
}

- (void)initGroup {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    self.currentVersion = [infoDic valueForKey:@"CFBundleVersion"];
    
    CGFloat margin = 17.0;
    TTCommonLabelItem *item01 = [TTCommonLabelItem itemWithTitle:@"当前版本"];
    item01.rightTitle = [NSString stringWithFormat:@"%@", self.currentVersion];
    item01.horizontalMargin = margin;
    // 显示新版更新功能
    TTCommonLabelItem *item02 = [TTCommonLabelItem itemWithTitle:@"新版更新"];
    if ([[TTSettingManager shareInstance] boolValueWithKey:kNewVersionCheck defaultValue:YES]) {
        item02.rightTitle = @"有新版";
    }
    else {
        item02.rightTitle = @"无新版";
    }
    // 已经上线显示新版更新功能
    __weak typeof(self) weakSelf = self;
    item02.OperationBlock = ^() {
        [weakSelf checkUpdate];
    };
    item02.horizontalMargin = margin;
    
    TTCommonArrowItem *item10 = [TTCommonArrowItem itemWithTitle:@"帮助与反馈"];
    item10.jumpVClass = [TTFeedbackViewController class];
    item10.isJumpVC = YES;
//    item10.jumpMode = TTCommonItemJumpModePresent;
    item10.horizontalMargin = margin;
    TTCommonArrowItem *item11 = [TTCommonArrowItem itemWithTitle:@"给软件评分"];
    item11.horizontalMargin = margin;
    item11.OperationBlock = ^() {
        NSURL *url = [NSURL URLWithString:kJumpAppStoreUrl];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [[UIApplication sharedApplication] openURL:url];
#pragma clang diagnostic pop
        }
        else {
            NSLog(@"can't open");
        }
    };
    
    self.group0.items = @[item01, item02];
    
    TTCommonGroup *group1 = [TTCommonGroup group];
    [self.datas addObject:group1];
    
    group1.items = @[item10, item11];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initGroup];
    
    // 进入前台事件
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onEnterForeground)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getServerVersionInfo];
    });
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    // 移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                             name:UIApplicationWillEnterForegroundNotification
                                                 object:nil];
    NSLog(@"%s", __func__);
}

#pragma mark - private methods

- (void)onEnterForeground {
    NSLog(@"onEnterForeground.");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getServerVersionInfo];
    });
}

// 公司服务器做法
- (void)getServerVersionInfo {
    // 判断当前版本和网络版本以及该app是否在审核期间 服务器通过修改一个字段判断是否已经上线
    TTCommonLabelItem *item02 = (TTCommonLabelItem *)self.group0.items[1];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic valueForKey:@"CFBundleShortVersionString"];
//    NSDictionary *param = @{@"ver":currentVersion, @"os":@"ios"};
    // 网络请求
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//    __weak typeof(self) weakSelf = self;
//    [TTDataRequest requestVersionUpdateWithParam:param Handler:^(NSDictionary *resultDict, NSInteger code, NSString *message) {
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
//        @strongify(self);
    NSDictionary *resultDict;
    NSInteger code = 0;
        if (code == 0) {
            if (resultDict) {
                CGFloat versionOnline = [[resultDict objectForKey:@"latestVersion"] floatValue];
                NSString *downloadUrl = [resultDict objectForKey:@"latestUrl"];
                NSInteger type = [[resultDict objectForKey:@"type"] integerValue];
                NSString *upgradeMessage = [resultDict objectForKey:@"upgradeMessage"];
                NSLog(@"upgradeMessage:%@", upgradeMessage);
                if (type == 2) {
                    NSLog(@"弹出框提示");
                }
                else if (type == 0) {
                    NSLog(@"无升级");
                }
                else if (type == 1) {
                    NSLog(@"手动检查升级时提示");
                }
                else if (type == 3) {
                    NSLog(@"强制升级");
                }
                // 记录新版本url
                self.downloadUrl = downloadUrl;
                /** NO 为没有更新，YES 为有新版本*/
                if (versionOnline <= [currentVersion floatValue] || type == 0) {
                    // 无新版
                    item02.rightTitle = @"无新版";
                    [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
                }
                else {
                    // 有更新
                    item02.rightTitle = @"有新版";
                    [[TTSettingManager shareInstance] setBool:YES forKey:kNewVersionCheck];
                }
            }
            else {
                // 无新版
                // 审核期间隐藏新版更新功能
                item02.rightTitle = @"无新版";
                [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
            }
            self.group0.items = @[self.group0.items[0], item02];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else {
            [[TTSettingManager shareInstance] setBool:NO forKey:kNewVersionCheck];
            // 审核期间隐藏新版更新功能
            item02.rightTitle = @"无新版";
            self.group0.items = @[self.group0.items[0], item02];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
//    }];
}

- (void)checkUpdate {
//    __weak typeof(self) weakSelf = self;
    
    if ((self.trackViewUrl && ![self.trackViewUrl isEqualToString:@""]) || [[TTSettingManager shareInstance] boolValueWithKey:kNewVersionCheck defaultValue:NO]) {
        NSLog(@"有新版本");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发现新版本" message:[NSString stringWithFormat:@"赶快到AppStore下载更新体验%@最新版本吧！", self.onlineVersion] preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"稍后更新" style:UIAlertActionStyleCancel handler:nil]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"立即更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
//            NSString *str = @"https://itunes.apple.com/cn/app/id466321750?mt=8";
            if (self.trackViewUrl && ![self.trackViewUrl isEqualToString:@""]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackViewUrl]];
            }
            else {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.downloadUrl]];
            }
        }]];
        
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
    else {
        NSLog(@"无新版本");
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前版本已是最新" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark - getter method

- (TTCommonGroup *)group0 {
    if (!_group0) {
        _group0 = [TTCommonGroup group];
        [self.datas insertObject:_group0 atIndex:0];
    }
    return _group0;
}

@end
