//
//  FBPOPAnimator.h
//  tipop
//
//  Created by Do(mcdooooo@gmail.com) on 14/11/4.
//
//

//#define USE_TI_UISCROLLVIEW

#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import "TiViewProxy.h"
#import "TiUILabel.h"
#import "TiUIScrollView.h"
#import "Ti3DMatrix.h"
#import "KrollCallback.h"
#import "LayoutConstraint.h"
#import "POP.h"
#import "CAMediaTimingFunction+ExtendedFunc.h"

@interface FBPOPAnimator : NSObject<POPAnimationDelegate> {
    CGPoint positionCache;
    CGRect sizeCache;
    UIViewAutoresizing autoresizeCache;
    LayoutConstraint *layoutConstraint;
    CGRect frameCache;
}

-(void)basicAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties;

-(void)springAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties;

-(void)decayAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties;

-(void)clearAllAnimations:(TiViewProxy *)proxy;

@end
