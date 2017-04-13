//
//  TTBadgeView.m
//  TTKanKan
//
//  Created by wjc on 2017/1/5.
//  Copyright © 2017年 kankan. All rights reserved.
//

#import "TTBadgeView.h"
#import "UIView+ExtFrame.h"

@implementation TTBadgeView

#pragma mark - initialize method

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor redColor]];
        self.layer.cornerRadius = 10.0;
        self.layer.masksToBounds = YES;
        self.height = 20.0;
    }
    return self;
}

#pragma mark - setter method

- (void)setBadgeValue:(NSString *)badgeValue {
    _badgeValue = [badgeValue copy];
    
//    [self setTitle:badgeValue forState:UIControlStateNormal];
    CGSize titleSize = [badgeValue boundingRectWithSize:CGSizeMake(MAXFLOAT, 20.0)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:11.0]}
                                                context:nil].size;
    CGFloat w = self.size.width;
    if (titleSize.width < w) {
        self.width = w;
    }
    else {
        // 左右加5个间距
        self.width = titleSize.width + 10;
    }
}

@end
