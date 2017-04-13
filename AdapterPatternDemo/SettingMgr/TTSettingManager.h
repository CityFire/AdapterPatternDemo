//
//  TTSettingManager.h
//  TTKanKan
//
//  Created by wjc on 2017/1/5.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString * const kdefaultNetworkPlaySettingSwitch;     // 网络播放开关
UIKIT_EXTERN NSString * const kdefaultNetworkDownloadSettingSwitch; // 网络下载开关
UIKIT_EXTERN NSString * const kNewVersionCheck;                     // 新版本检测

@interface TTSettingManager : NSObject

+ (instancetype)shareInstance;

#pragma mark - setting methods
/** 设置3G/4G网络播放开启状态 */
- (void)setNetworkPlayDefaultSetting:(BOOL)boolValue forKey:(NSString *)key;
/** 设置3G/4G下载播放开启状态 */
- (void)setNetworkDownloadDefaultSetting:(BOOL)boolValue forKey:(NSString *)key;
/** 获取3G/4G网络播放开启状态 */
- (BOOL)getNetworkPlayDefaultSettingByKey:(NSString *)key;
/** 获取3G/4G下载播放开启状态 */
- (BOOL)getNetworkDownloadDefaultSettingByKey:(NSString *)key;


#pragma mark - universal methods

// setter
- (void)setBool:(BOOL)boolValue          forKey:(NSString *)key;
- (void)setInt:(NSInteger)IntValue       forKey:(NSString *)key;
- (void)setFloat:(CGFloat)floatValue     forKey:(NSString *)key;
- (void)setString:(NSString*)stringValue forKey:(NSString *)key;

// getter

- (BOOL)boolValueWithKey:(NSString *)key         defaultValue:(BOOL)defaultValue;
- (NSInteger)intValueWithKey:(NSString *)key     defaultValue:(NSInteger)defaultValue;
- (CGFloat)floatValueWithKey:(NSString *)key     defaultValue:(CGFloat)defaultValue;
- (NSString *)stringValueWithKey:(NSString *)key defaultValue:(NSString *)defaultValue;

@end
