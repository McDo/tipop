//
//  CAMediaTimingFunction+ExtendedFunc.h
//
//  Created by Do Lin on 14/10/27.
//  Copyright (c) 2014-present Do Lin. All rights reserved.
//

#import "CAMediaTimingFunction+ExtendedFunc.h"

@implementation CAMediaTimingFunction (ExtendedFunc)

NSString * const kCAMediaTimingFunctionEaseInSine = @"easeInSine";
NSString * const kCAMediaTimingFunctionEaseOutSine = @"easeOutSine";
NSString * const kCAMediaTimingFunctionEaseInOutSine = @"easeInOutSine";

NSString * const kCAMediaTimingFunctionEaseInQuad = @"easeInQuad";
NSString * const kCAMediaTimingFunctionEaseOutQuad = @"easeOutQuad";
NSString * const kCAMediaTimingFunctionEaseInOutQuad = @"easeInOutQuad";

NSString * const kCAMediaTimingFunctionEaseInCubic = @"easeInCubic";
NSString * const kCAMediaTimingFunctionEaseOutCubic = @"easeOutCubic";
NSString * const kCAMediaTimingFunctionEaseInOutCubic = @"easeInOutCubic";

NSString * const kCAMediaTimingFunctionEaseInQuart = @"easeInQuart";
NSString * const kCAMediaTimingFunctionEaseOutQuart = @"easeOutQuart";
NSString * const kCAMediaTimingFunctionEaseInOutQuart = @"easeInOutQuart";

NSString * const kCAMediaTimingFunctionEaseInQuint = @"easeInQuint";
NSString * const kCAMediaTimingFunctionEaseOutQuint = @"easeOutQuint";
NSString * const kCAMediaTimingFunctionEaseInOutQuint = @"easeInOutQuint";

NSString * const kCAMediaTimingFunctionEaseInExpo = @"easeInExpo";
NSString * const kCAMediaTimingFunctionEaseOutExpo = @"easeOutExpo";
NSString * const kCAMediaTimingFunctionEaseInOutExpo = @"easeInOutExpo";

NSString * const kCAMediaTimingFunctionEaseInCirc = @"easeInCirc";
NSString * const kCAMediaTimingFunctionEaseOutCirc = @"easeOutCirc";
NSString * const kCAMediaTimingFunctionEaseInOutCirc = @"easeInOutCirc";

NSString * const kCAMediaTimingFunctionEaseInBack = @"easeInBack";
NSString * const kCAMediaTimingFunctionEaseOutBack = @"easeOutBack";
NSString * const kCAMediaTimingFunctionEaseInOutBack = @"easeInOutBack";


+ (instancetype)functionWithExtendedFuncName:(NSString *)name {
    
    if ( [name isEqualToString:kCAMediaTimingFunctionEaseInSine] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.47 :0 :0.745 :0.715];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseOutSine] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.39 :0.575 :0.565 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInOutSine] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.445 :0.05 :0.55 :0.95];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInQuad] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.55 :0.085 :0.68 :0.53];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseOutQuad] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.25 :0.46 :0.45 :0.94];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInOutQuad] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.455 :0.03 :0.515 :0.955];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInCubic] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.55 :0.055 :0.675 :0.19];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseOutCubic] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.215 :0.61 :0.355 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInOutCubic] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.645 :0.045 :0.355 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInQuart] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.895 :0.03 :0.685 :0.22];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseOutQuart] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.165 :0.84 :0.44 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInOutQuart] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.77 :0 :0.175 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInQuint] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.755 :0.05 :0.855 :0.06];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseOutQuint] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.23 :1 :0.32 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInOutQuint] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.86 :0 :0.07 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInExpo] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.95 :0.05 :0.795 :0.035];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseOutExpo] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.19 :1 :0.22 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInOutExpo] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:1 :0 :0 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInCirc] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.6 :0.04 :0.98 :0.335];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseOutCirc] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.075 :0.82 :0.165 :1];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInOutCirc] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.785 :0.135 :0.15 :0.86];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInBack] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.6 :-0.28 :0.735 :0.045];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseOutBack] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.175 :0.885 :0.32 :1.275];
        
    } else if ( [name isEqualToString:kCAMediaTimingFunctionEaseInOutBack] ) {
        
        return [CAMediaTimingFunction functionWithControlPoints:0.68 :-0.55 :0.265 :1.55];
        
    }
    
    return nil;
    
}

@end
