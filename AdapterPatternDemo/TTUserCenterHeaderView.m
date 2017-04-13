//
//  TTPersonCenterHeaderView.m
//  TTKanKan
//
//  Created by wjc on 2016/12/26.
//  Copyright © 2016年 kankan. All rights reserved.
//

#import "TTUserCenterHeaderView.h"
#import <UIImageView+WebCache.h>
#import "UIImage+Extension.h"
#import "UIColor+HexString.h"
#import "UIView+ExtFrame.h"

static const CGFloat kImageWidth = 85.0;
static const CGFloat kbtnWidth = 95.0;
static const CGFloat klineHeight = 0.5;
static const CGFloat kHalfValue = 0.5;

@interface TTUserCenterHeaderView () {
    BOOL _isLogin;
}

@property (nonatomic, strong) UIView   *headView;

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UILabel  *userNameLb;

@property (nonatomic, strong) UIView   *topLineView;

@property (nonatomic, strong) UIView   *bottomLineView;

@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation TTUserCenterHeaderView

#pragma mark - Initilized

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
    self.offsetY = 0;
    
    UIImageView *backgroundView = [UIImageView new];
    backgroundView.image = [UIImage imageNamed:@"uploader_homepage_background"];
    backgroundView.contentMode = UIViewContentModeScaleToFill;
    backgroundView.layer.masksToBounds = YES;
    [self addSubview:_backgroundView = backgroundView];
    [self insertSubview:_backgroundView atIndex:0];
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor clearColor];
    [self addSubview:_headView = headView];
    
    // 一个只画阴影的外图层和一个只裁剪的内图层
    CGFloat topMargin = 54.0;
    CALayer *shadowLayer = [CALayer layer];
    shadowLayer.backgroundColor = [UIColor clearColor].CGColor;
    shadowLayer.frame = CGRectMake((self.bounds.size.width-kImageWidth)*0.5, topMargin, kImageWidth, kImageWidth);
    shadowLayer.cornerRadius = kImageWidth*kHalfValue;
    shadowLayer.borderColor = [UIColor colorWithHexString:@"#f5f5f5"].CGColor;
    shadowLayer.borderWidth = 1.5;
    shadowLayer.shadowOffset = CGSizeZero;
    shadowLayer.shadowRadius = 3.0;
    shadowLayer.shadowColor = [UIColor blackColor].CGColor;
    shadowLayer.shadowOpacity = 0.85;
    
    [headView.layer addSublayer:shadowLayer];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_img_default"]];
    imageView.backgroundColor = [UIColor clearColor];
    imageView.layer.cornerRadius = kImageWidth*kHalfValue;
    imageView.layer.borderColor = [UIColor colorWithHexString:@"#f5f5f5"].CGColor;
    imageView.layer.borderWidth = 1.5;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.userInteractionEnabled = YES;
    self.imageView = imageView;
    
    [headView addSubview:self.imageView];
    
    [headView.layer insertSublayer:shadowLayer below:self.imageView.layer];
    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.imageView addGestureRecognizer:tgr];

    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor colorWithHexString:@"FE4153"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [loginBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"fe4153"]] forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    loginBtn.layer.borderColor = [UIColor colorWithHexString:@"fe4153"].CGColor;
    loginBtn.layer.borderWidth = 1.0;
    loginBtn.layer.cornerRadius = 15.0;
    loginBtn.layer.masksToBounds = YES;
    [headView addSubview:_loginBtn = loginBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.hidden = YES;
    label.adjustsFontSizeToFitWidth = YES;
    [headView addSubview:_userNameLb = label];
    
    UIView *lineV = [[UIView alloc] init];
    lineV.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [headView addSubview:_topLineView = lineV];
    
    lineV = [[UIView alloc] init];
    lineV.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    [headView addSubview:_bottomLineView = lineV];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-15.0);
    if (self.offsetY < 0) {
        self.backgroundView.frame = CGRectMake(self.offsetY*kHalfValue, self.offsetY, self.bounds.size.width-self.offsetY, self.headView.bounds.size.height-self.offsetY);
    }
    else {
        self.backgroundView.frame = self.headView.frame;
    }
    CGFloat topMargin = 54.0;
    self.imageView.frame = CGRectMake((self.bounds.size.width-kImageWidth)*kHalfValue, topMargin, kImageWidth, kImageWidth);
    self.loginBtn.frame = CGRectMake((self.bounds.size.width-kbtnWidth)*kHalfValue, self.imageView.bottom+15, kbtnWidth, 30.0);
    self.userNameLb.frame = CGRectMake(0, self.imageView.bottom+15, self.bounds.size.width, 30.0);
    self.topLineView.frame = CGRectMake(0, self.headView.size.height-klineHeight, self.bounds.size.width, klineHeight);
    self.bottomLineView.frame = CGRectMake(0, self.bounds.size.height-klineHeight, self.bounds.size.width, klineHeight);
}

- (void)updateUserInfo:(KanKanUserModel *)model login:(BOOL)isLogin {
    
    _isLogin = isLogin;
    self.loginBtn.hidden = isLogin;
    self.userNameLb.hidden = !isLogin;
    
    if (isLogin) {
            self.imageView.image = [UIImage imageNamed:@"user_img_default"];
    }
    else {
        self.imageView.image = [UIImage imageNamed:@"user_img_default"];
    }
    
}

- (void)viewScrollOffset:(CGFloat)offset {
    self.offsetY = offset;
//    TTLog(@"offsetY:%f", offset);
    self.backgroundView.frame = CGRectMake(self.offsetY*kHalfValue, self.offsetY, self.bounds.size.width-self.offsetY, self.headView.bounds.size.height-self.offsetY);
}

#pragma mark - btn pressed

- (void)btnPressed {
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewDidClickButton:)]) {
        [self.delegate headerViewDidClickButton:self];
    }
}

#pragma mark - gestureRecognizer

- (void)tapAction:(UITapGestureRecognizer *)tgr {
    if (_isLogin) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewDidClickEdit:)]) {
            [self.delegate headerViewDidClickEdit:self];
        }
    }
}

@end
