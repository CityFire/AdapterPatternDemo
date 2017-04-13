//
//  TTMyFocusViewController.m
//  TTKanKan
//
//  Created by wjc on 2017/1/3.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import "TTMyFocusViewController.h"

@interface TTMyFocusViewController ()

@end

@implementation TTMyFocusViewController

#pragma mark - LifeCycle

- (void)initView {
    self.title = @"我的关注";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 重写父类方法

- (void)popSelf {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
