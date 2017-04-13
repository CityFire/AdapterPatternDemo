//
//  UIColor+HexString.h
//  PlayerComponent
//
//  Created by Carl Li on 1/6/15.
//
//

#import <UIKit/UIKit.h>

#define SCREENWIDTH (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))
#define SCREENHEIGHT (MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height))

@interface UIColor (HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString;

@end
