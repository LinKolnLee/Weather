//
//  LOTAnimatableColorValue.h
//  LottieAnimator
//
//  Created by brandon_withrow on 6/23/16.
//  Copyright © 2016 Brandon Withrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "LOTAnimatableValue.h"
#import "TargetConditionals.h"

#if TARGET_OS_IPHONE || TARGET_IPHONE_SIMULATOR

#import <UIKit/UIKit.h>

#else

#import "LOTPlatformCompat.h"

#endif

@interface LOTAnimatableColorValue : NSObject <LOTAnimatableValue>

- (instancetype)initWithColorValues:(NSDictionary *)colorValues frameRate:(NSNumber *)frameRate;

@property (nonatomic, readonly) UIColor *initialColor;

@end
