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


typedef NS_OPTIONS(NSUInteger, TIPOPANIMATIONS) {
    TIPOPEMPTY                      = 0,
    
    TIPOPLEFT                       = 1 << 0,
    TIPOPTOP                        = 1 << 1,
    TIPOPWIDTH                      = 1 << 2,
    TIPOPHEIGHT                     = 1 << 3,
    
    TIPOPOPACITY                    = 1 << 4,
    TIPOPZINDEX                     = 1 << 5,
    
    TIPOPCOLOR                      = 1 << 6,
    TIPOPBACKGROUNDCOLOR            = 1 << 7,
    TIPOPTINTCOLOR                  = 1 << 8,
    
    TIPOPBORDERRADIUS               = 1 << 9,
    TIPOPBORDERWIDTH                = 1 << 10,
    TIPOPBORDERCOLOR                = 1 << 11,
    
    TIPOPSHADOWCOLOR                = 1 << 12,
    TIPOPSHADOWOPACITY              = 1 << 13,
    
    TIPOPSTROKESTART                = 1 << 14,
    TIPOPSTROKEEND                  = 1 << 15,
    TIPOPSTROKECOLOR                = 1 << 16,
    TIPOPFILLCOLOR                  = 1 << 17,
    TIPOPLINEWIDTH                  = 1 << 18,
    
    TIPOPROTATEX                    = 1 << 19,
    TIPOPROTATEY                    = 1 << 20,
    TIPOPROTATEZ                    = 1 << 21,
    
    TIPOPSCALEX                     = 1 << 22,
    TIPOPSCALEY                     = 1 << 23,
    
    TIPOPTRANSLATEX                 = 1 << 24,
    TIPOPTRANSLATEY                 = 1 << 25,
    TIPOPTRANSLATEZ                 = 1 << 26,
    
    TIPOPSUBTRANSLATEX              = 1 << 27,
    TIPOPSUBTRANSLATEY              = 1 << 28,
    
    TIPOPSCROLLVIEWCONTETNOFFSET    = 1 << 29
};


@interface FBPOPAnimator : NSObject<POPAnimationDelegate> {
    CGPoint positionCache;
    CGRect sizeCache;
    UIViewAutoresizing autoresizeCache;
    LayoutConstraint *layoutConstraint;
    CGRect frameCache;
    __block TIPOPANIMATIONS basicMask;
    __block TIPOPANIMATIONS springMask;
    __block TIPOPANIMATIONS decayMask;
}

-(void)basicAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties completed:(KrollCallback*)callback;

-(void)springAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties completed:(KrollCallback*)callback;

-(void)decayAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties completed:(KrollCallback*)callback;

-(void)clearAllAnimations:(TiViewProxy *)proxy;

@end
