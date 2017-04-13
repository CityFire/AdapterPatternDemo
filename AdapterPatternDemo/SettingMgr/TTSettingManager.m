//
//  TTSettingManager.m
//  TTKanKan
//
//  Created by wjc on 2017/1/5.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import "TTSettingManager.h"

NSString * const kdefaultNetworkPlaySettingSwitch = @"com.kankan.TTKanKan.kdefaultNetworkPlaySettingSwitch";
NSString * const kdefaultNetworkDownloadSettingSwitch = @"com.kankan.TTKanKan.kdefaultNetworkDownloadSettingSwitch";
NSString * const kNewVersionCheck = @"kNewVersionCheck";

@implementation TTSettingManager

+ (instancetype)shareInstance{
    static TTSettingManager *settingManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        settingManager = [[TTSettingManager alloc]init];
    });
    return settingManager;
}

#pragma mark - setting tool methods

- (void)setNetworkPlayDefaultSetting:(BOOL)boolValue forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setNetworkDownloadDefaultSetting:(BOOL)boolValue forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)getNetworkPlayDefaultSettingByKey:(NSString *)key {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:key] boolValue];
}

- (BOOL)getNetworkDownloadDefaultSettingByKey:(NSString *)key {
    return [[[NSUserDefaults standardUserDefaults] valueForKey:key] boolValue];
}

#pragma mark - universal methods

// setter
- (void)setBool:(BOOL)boolValue          forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"[%@]=%d", key, (int)boolValue);
}

- (void)setInt:(NSInteger)IntValue       forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setInteger:IntValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"[%@]=%d", key, (int)IntValue);
}

- (void)setFloat:(CGFloat)floatValue     forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setFloat:floatValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"[%@]=%f", key, floatValue);
}

- (void)setString:(NSString*)stringValue forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setObject:stringValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"[%@]=%@", key, stringValue);
}

// getter

- (BOOL)boolValueWithKey:(NSString *)key         defaultValue:(BOOL)defaultValue {
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    BOOL result;
    if (value) {
        result = [value boolValue];
    }
    else {
        result = defaultValue;
    }
    NSLog(@"[%@]=%d", key, (int)result);
    return result;
}

- (NSInteger)intValueWithKey:(NSString *)key     defaultValue:(NSInteger)defaultValue {
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    NSInteger result;
    if (value) {
        result= [value intValue];
    }
    else {
        result = defaultValue;
    }
    NSLog(@"[%@]=%d", key, (int)result);
    return result;
}

- (CGFloat)floatValueWithKey:(NSString *)key     defaultValue:(CGFloat)defaultValue {
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    CGFloat result;
    if (value) {
        result = [value floatValue];
    }
    else {
        result = defaultValue;
    }
    NSLog(@"[%@]=%f", key, result);
    return result;
}

- (NSString *)stringValueWithKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    NSString *result;
    if (value) {
        result = value;
    }
    else {
        result = defaultValue;
    }
    NSLog(@"[%@]=%@", key, result);
    return  result;
}

@end
