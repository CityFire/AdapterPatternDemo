//
//  TTCommonViewController.m
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "TTCommonViewController.h"
#import "TTCommonGroup.h"
#import "TTCommonItem.h"
#import "TTCommonCell.h"
#import "TTCommonLabelItem.h"
#import "UIColor+HexString.h"

#define KKDefaultBackgroundColor [UIColor colorWithHexString:@"f4f4f4"]
// 线条颜色
#define SeperatLineColor [UIColor colorWithHexString:@"e5e5e5"]
#define SCREENWIDTH (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#define SCREENHEIGHT (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))

static NSString * const cellIdentifier = @"TTCommonCell";
static CGFloat kCellLineHeight = 0.5;

@interface TTCommonViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *tableSectionView;

@property (nonnull, nonatomic, strong) NSMutableArray<TTCommonGroup *> *datas;

@end

@implementation TTCommonViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDefaultTableView];
}

- (void)initDefaultTableView {
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    TTCommonGroup *group = self.datas[section];
    return group.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCommonGroup *group = self.datas[indexPath.section];
    TTCommonItem *item = group.items[indexPath.row];
    return item.cellHeight;
}

- (__kindof UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[TTCommonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    // Configure the cell...
    TTCommonGroup *group = self.datas[indexPath.section];
    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    cell.item = group.items[indexPath.row];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self tableSectionView:tableView.sectionHeaderHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self tableSectionView:tableView.sectionFooterHeight];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTCommonGroup *group = self.datas[indexPath.section];
    TTCommonItem *item = group.items[indexPath.row];
    if ([item isKindOfClass:[TTCommonLabelItem class]] && !item.OperationBlock) {
        NSLog(@"无跳转");
        return;
    }
    // 跳转到对应的VC
    if (item.jumpVClass && item.isJumpVC) {
        UIViewController *vc = (UIViewController *)[[item.jumpVClass alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.title = item.title;
        if (item.jumpMode == TTCommonItemJumpModePresent) {
            if (self.navigationController) {
                [self.navigationController presentViewController:vc animated:YES completion:nil];
            }
            else {
                [self presentViewController:vc animated:YES completion:nil];
            }
        }
        else {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else {
        NSLog(@"无跳转");
    }
    
    // 执行的操作
    if (item.OperationBlock) {
        item.OperationBlock();
    }
    else {
        NSLog(@"无执行Block");
    }
    
    if (item.target && item.selector) {
        if ([item.target respondsToSelector:item.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if (item.params) {
                [item.target performSelector:item.selector withObject:item.params];
            }
            else {
                [item.target performSelector:item.selector];
            }
#pragma clang diagnostic pop
        }
        else {
            NSLog(@"无执行target-action");
        }
    }
    else {
        NSLog(@"无target-action代理");
    }
}

#pragma mark - getter methods

- (UIView *)tableSectionView:(CGFloat)height {
    if (!_tableSectionView) {
        _tableSectionView = [[UIView alloc] init];
        _tableSectionView.backgroundColor = KKDefaultBackgroundColor;
        
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, kCellLineHeight)];
        lineV.backgroundColor = SeperatLineColor;
        [_tableSectionView addSubview:lineV];
        
        lineV = [[UIView alloc] initWithFrame:CGRectMake(0, height-kCellLineHeight, SCREENWIDTH, kCellLineHeight)];
        lineV.backgroundColor = SeperatLineColor;
        [_tableSectionView addSubview:lineV];
    }
    return _tableSectionView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = KKDefaultBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.sectionHeaderHeight = 15.0;
        _tableView.sectionFooterHeight = 0.0;
        [_tableView registerClass:[TTCommonCell class] forCellReuseIdentifier:cellIdentifier];
        _tableView.contentInset = UIEdgeInsetsZero;
    }
    return _tableView;
}

- (NSMutableArray<TTCommonGroup *> *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

@end
