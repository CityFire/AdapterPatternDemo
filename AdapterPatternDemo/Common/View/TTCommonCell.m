//
//  TTCommonCell.m
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "TTCommonCell.h"
#import "TTCommonItem.h"
#import "TTCommonArrowItem.h"
#import "TTCommonSwitchItem.h"
#import "TTCommonLabelItem.h"
#import "TTBadgeView.h"
#import "TTSettingManager.h"
#import "UIColor+HexString.h"
#import "UIView+ExtFrame.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

#define kCellSeperatLineColor [UIColor colorWithHexString:@"eaeaea"]

static const CGFloat kCellLineHeight = 0.5;
static const CGFloat kCellOffset = 15.0;

@interface TTCommonCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIImageView *rightArrow;

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UISwitch *rightSwitch;

@property (nonatomic, strong) TTBadgeView *badgeView;

@property (nonatomic, strong) UIView *lineView;

@property (nonnull, nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation TTCommonCell

#pragma mark - initialize

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        [self addSubview:self.lineView];
        [self addSubview:self.badgeView];
        [self addSubview:self.rightArrow];
        [self addSubview:self.rightSwitch];
        [self addSubview:self.rightLabel];
        
        [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).with.offset(45.0);
            make.left.mas_equalTo(self.mas_left).with.offset(4*kCellOffset);
            make.size.mas_equalTo(CGSizeMake(250.0, 20.0));
        }];
        
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).with.offset(-kCellLineHeight);
            make.height.mas_equalTo(kCellLineHeight);
            make.left.mas_equalTo(self.mas_left).with.offset(kCellOffset-5.0);
            make.right.mas_equalTo(self.mas_right);
        }];
        
        [self.badgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(116.0);
            make.top.mas_equalTo(self).with.offset(11.0);
            make.size.mas_equalTo(CGSizeMake(kCellOffset*0.5, kCellOffset*0.5));
        }];
        
        [self.rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).with.offset(-5);
            make.top.mas_equalTo(self).with.offset(11.0);
            make.size.mas_equalTo(CGSizeMake(22.0, 22.0));
        }];
        
        [self.rightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).with.offset(-kCellOffset);
            make.top.mas_equalTo(self).with.offset(7.0);
            make.bottom.mas_equalTo(self).with.offset(-7.0);
            make.width.equalTo(@(45.0));
        }];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).with.offset(-kCellOffset-2.0);
            make.centerY.mas_equalTo(self);
            make.width.equalTo(@(145.0));
        }];
    }
    return self;
}

#pragma mark - cell内部约束
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    if (_item.iconName) {
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(kCellOffset-2);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(22.0, 22.0));
        }];
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (_item.subTitle) {
            make.centerY.mas_equalTo(self).with.offset(-kCellOffset+3);
        }
        else {
            make.centerY.mas_equalTo(self);
        }
        if (_item.iconName) {
            make.left.mas_equalTo(self.iconImageView.mas_right).with.offset(12.0);
        }
        else {
            if (_item.horizontalMargin) {
                make.left.mas_equalTo(self.mas_left).with.offset(_item.horizontalMargin);
            }
            else {
                make.left.mas_equalTo(self.mas_left).with.offset(kCellOffset);
            }
        }
        make.size.mas_equalTo(CGSizeMake(250.0, 20.0));
    }];
    
    if (_item.horizontalMargin) {
        [self.rightArrow mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).with.offset(-10.0);
        }];
    }
    
    [super updateConstraints];
}

#pragma mark - event method

- (void)switchPressed:(UISwitch *)s {
    if (_indexPath.row == 0) {
        // 播放
        [[TTSettingManager shareInstance] setNetworkPlayDefaultSetting:s.on forKey:kdefaultNetworkPlaySettingSwitch];
    }
    else {
        // 下载
        [[TTSettingManager shareInstance] setNetworkDownloadDefaultSetting:s.on forKey:kdefaultNetworkDownloadSettingSwitch];
    }
    if ([_item isKindOfClass:[TTCommonSwitchItem class]]) {
        TTCommonSwitchItem *item = (TTCommonSwitchItem *)_item;
        if (item.OperationWithParamBlock) {
            item.OperationWithParamBlock(s);
        }
    }
}

#pragma mark - setter methods

- (void)setItem:(TTCommonItem *)item {
    _item = item;
    
    self.iconImageView.image = [UIImage imageNamed:_item.iconName];
    self.titleLabel.text = item.title;
    if (item.subTitle) {
        self.subTitleLabel.text = item.subTitle;
    }
    else {
        self.subTitleLabel.text = nil;
    }
    self.rightArrow.hidden = YES;
    self.rightSwitch.hidden = YES;
    self.rightLabel.hidden = YES;
    // 有提醒badge
    if (item.badgeValue) {
        NSInteger badgeV = [item.badgeValue integerValue];
        self.badgeView.hidden = badgeV <= 0;
        self.badgeView.badgeValue = item.badgeValue;
    }
    else {
        self.badgeView.hidden = YES;
    }

    if ([_item isKindOfClass:[TTCommonArrowItem class]]) {
        self.rightArrow.hidden = NO;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = kCellSeperatLineColor;
//        self.accessoryView = self.rightArrow;
    }
    else if ([_item isKindOfClass:[TTCommonSwitchItem class]]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        TTCommonSwitchItem *switchItem = (TTCommonSwitchItem *)item;
        if (switchItem.switchType == TTCommonSwitchTypePlay) {
            self.rightSwitch.on = [[TTSettingManager shareInstance] getNetworkPlayDefaultSettingByKey:kdefaultNetworkPlaySettingSwitch];
        }
        else if (switchItem.switchType == TTCommonSwitchTypeDownload) {
            self.rightSwitch.on = [[TTSettingManager shareInstance] getNetworkDownloadDefaultSettingByKey:kdefaultNetworkDownloadSettingSwitch];
        }
        self.rightSwitch.hidden = NO;
//        self.accessoryView = self.rightSwitch;
    }
    else if ([_item isKindOfClass:[TTCommonLabelItem class]]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        TTCommonLabelItem *labelItem = (TTCommonLabelItem *)item;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        self.rightLabel.size = [labelItem.rightTitle sizeWithFont:self.rightLabel.font];
#pragma clang diagnostic pop
        self.rightLabel.text = labelItem.rightTitle;
        self.rightLabel.hidden = NO;
//        self.accessoryView = self.rightLabel;
    }
    else {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryView = nil;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowsInSection:(NSInteger)rows {
    _indexPath = indexPath;
    if (indexPath.row == rows - 1) {
        self.lineView.hidden = YES;
    }
    else {
        self.lineView.hidden = NO;
    }
}

#pragma mark - getter methods

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor clearColor];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHexString:@"303031"];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textColor = [UIColor blackColor];
        _subTitleLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _subTitleLabel;
}

- (UIImageView *)rightArrow {
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_more"]];
    }
    return _rightArrow;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor colorWithHexString:@"67676B"];
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _rightLabel;
}

- (UISwitch *)rightSwitch {
    if (!_rightSwitch) {
        _rightSwitch = [[UISwitch alloc] init];
        [_rightSwitch addTarget:self action:@selector(switchPressed:) forControlEvents:UIControlEventValueChanged];
    }
    return _rightSwitch;
}

- (TTBadgeView *)badgeView {
    if (!_badgeView) {
        _badgeView = [[TTBadgeView alloc] initWithFrame:CGRectZero];
        _badgeView.backgroundColor = [UIColor colorWithHexString:@"ff5a40"];
        _badgeView.layer.cornerRadius = 7.5*0.5;
        _badgeView.layer.masksToBounds = YES;
    }
    return _badgeView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kCellSeperatLineColor;
    }
    return _lineView;
}

@end
