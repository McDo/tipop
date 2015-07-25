//
//  CAMediaTimingFunction+ExtendedFunc.h
//
//  Created by Do Lin on 14/10/27.
//  Copyright (c) 2014-present Do Lin. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CAMediaTimingFunction (ExtendedFunc)

+ (instancetype)functionWithExtendedFuncName:(NSString *)name;

@end

/**
 * Extended timing function names.
 * Refer to http://easing.net for all the different possibilities of easings.
 **/
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInSine;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOutSine;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInOutSine;

CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInQuad;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOutQuad;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInOutQuad;

CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInCubic;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOutCubic;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInOutCubic;

CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInQuart;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOutQuart;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInOutQuart;

CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInQuint;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOutQuint;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInOutQuint;

CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInExpo;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOutExpo;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInOutExpo;

CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInCirc;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOutCirc;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInOutCirc;

CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInBack;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseOutBack;
CA_EXTERN NSString * const kCAMediaTimingFunctionEaseInOutBack;

