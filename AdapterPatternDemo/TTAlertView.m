//
//  TTAlertView.m
//  TTKanKan
//
//  Created by kankan on 15/12/14.
//  Copyright © 2015年 Nesound Kankan Inc. All rights reserved.
//

#import "TTAlertView.h"

static void(^_action)(NSInteger buttonIndex);

@implementation TTAlertView
+ (UIAlertView *)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    [alert show];
    
    return alert;
}

+ (UIAlertView *)showAlertWithTitle:( NSString *)title message:(NSString *)message clickAction:(void (^)(NSInteger))action cancelButtonTitle:(NSString *)cancel otherButtonTitles:(NSArray *)otherButtonTitles
{
    if (_action) return nil; // 防止重复弹出，请求回调的时候会出现
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancel otherButtonTitles:nil, nil];
    
    for (NSString *butTitles in otherButtonTitles) {
        [alertView addButtonWithTitle:butTitles];
    }
    
    _action = action;
    [alertView show];
    
    return alertView;
}

+ (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (_action) {
        _action = nil;
    }
}

+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_action) {
        _action(buttonIndex);
    }
    
    _action = nil;
}
@end
