//
//  FBPOPAnimator.m
//  tipop
//
//  Created by Do(mcdooooo@gmail.com) on 14/11/4.
//
//

#import "FBPOPAnimator.h"

@implementation FBPOPAnimator

#define ERR_DIMENSION -100000000.f

#pragma mark - public API

-(void)basicAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties {
    
#define BASIC_POP_ATTR( animation ) do { \
    if ( nil != duration ) animation.duration = duration.floatValue / 1000.f; \
    if ( nil != delay ) animation.beginTime = CACurrentMediaTime() + ( delay.floatValue / 1000.f ); \
    if ( nil != repeatCount ) animation.repeatCount = repeatCount.integerValue; \
    animation.repeatForever = repeatForever; \
    animation.additive = addictive; \
    animation.autoreverses = autoreverse; \
    animation.removedOnCompletion = true; \
    animation.timingFunction = [self ease:easing]; \
} while(0)
    
    TiDimension left = [TiUtils dimensionValue:@"left" properties:properties def:TiDimensionUndefined];
    TiDimension top = [TiUtils dimensionValue:@"top" properties:properties def:TiDimensionUndefined];
    TiDimension width = [TiUtils dimensionValue:@"width" properties:properties def:TiDimensionUndefined];
    TiDimension height = [TiUtils dimensionValue:@"height" properties:properties def:TiDimensionUndefined];
    
    NSNumber *opacity = [TiUtils numberFromObject:[properties objectForKey:@"opacity"]];
    NSNumber *zIndex = [TiUtils numberFromObject:[properties objectForKey:@"zIndex"]];
    
    TiColor *color = [TiUtils colorValue:@"color" properties:properties def:nil];
    TiColor *backgroundColor = [TiUtils colorValue:@"backgroundColor" properties:properties def:nil];
    TiColor *tintColor = [TiUtils colorValue:@"tintColor" properties:properties def:nil];
    
    NSNumber *borderRadius = [TiUtils numberFromObject:[properties objectForKey:@"borderRadius"]];
    NSNumber *borderWidth = [TiUtils numberFromObject:[properties objectForKey:@"borderWidth"]];
    TiColor *borderColor = [TiUtils colorValue:@"borderColor" properties:properties def:nil];
    
    TiColor *shadowColor = [TiUtils colorValue:@"shadowColor" properties:properties def:nil];
    NSNumber *shadowOpacity = [TiUtils numberFromObject:[properties objectForKey:@"shadowOpacity"]];
    
    NSNumber *strokeStart = [TiUtils numberFromObject:[properties objectForKey:@"strokeStart"]];
    NSNumber *strokeEnd = [TiUtils numberFromObject:[properties objectForKey:@"strokeEnd"]];
    TiColor *strokeColor = [TiUtils colorValue:@"strokeColor" properties:properties def:nil];
    TiColor *fillColor = [TiUtils colorValue:@"fillColor" properties:properties def:nil];
    NSNumber *lineWidth = [TiUtils numberFromObject:[properties objectForKey:@"lineWidth"]];
    
    NSNumber *delay = [TiUtils numberFromObject:[properties objectForKey:@"delay"]];
    NSNumber *duration = [TiUtils numberFromObject:[properties objectForKey:@"duration"]];
    NSString *easing = [TiUtils stringValue:@"easing" properties:properties def:@"default"];
    NSNumber *repeatCount = [TiUtils numberFromObject:[properties objectForKey:@"repeatCount"]];
    
    BOOL addictive = [TiUtils boolValue:@"addictive" properties:properties def:false];
    BOOL repeatForever = [TiUtils boolValue:@"repeatForever" properties:properties def:false];
    BOOL autoreverse = [TiUtils boolValue:@"autoreverse" properties:properties def:false];
    
    [proxy.view setOpaque:YES];
    layoutConstraint = proxy.layoutProperties;
    [self recalcConstraint:proxy width:width height:height left:left top:top center:[properties objectForKey:@"center"]];
    
    if ( !TiDimensionIsUndefined(left) ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationPositionX"];
        
        POPBasicAnimation *animPositionX = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        animPositionX.toValue = @(frameCache.origin.x);
        animPositionX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setLeft:[properties objectForKey:@"left"]];
            }
        };
        BASIC_POP_ATTR( animPositionX );
        
        [proxy.view.layer pop_addAnimation:animPositionX forKey:@"BasicAnimationPositionX"];
        
    }
    
    if ( !TiDimensionIsUndefined(top) ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationPositionY"];
        
        POPBasicAnimation *animPositionY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        animPositionY.toValue = @(frameCache.origin.y);
        animPositionY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setTop:[properties objectForKey:@"top"]];
            }
        };
        BASIC_POP_ATTR( animPositionY );
        
        [proxy.view.layer pop_addAnimation:animPositionY forKey:@"BasicAnimationPositionY"];
        
    }
    
    if ( !TiDimensionIsUndefined(width) ||
         !TiDimensionIsUndefined(height) ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationSize"];
        POPBasicAnimation *animSize = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSize];
        
        if ( !TiDimensionIsUndefined(width) &&
              TiDimensionIsUndefined(height) ) {
            
            animSize.toValue = [NSValue valueWithCGSize:CGSizeMake(frameCache.size.width, proxy.view.layer.bounds.size.height)];
            animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                if ( completed ) {
                    [proxy setWidth:[properties objectForKey:@"width"]];
                }
            };
            BASIC_POP_ATTR( animSize );
            
            [proxy.view.layer pop_addAnimation:animSize forKey:@"BasicAnimationSize"];
                
        } else if ( TiDimensionIsUndefined(width) &&
                   !TiDimensionIsUndefined(height) ) {
            
            animSize.toValue = [NSValue valueWithCGSize:CGSizeMake(proxy.view.layer.bounds.size.width, frameCache.size.height)];
            animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                if ( completed ) {
                    [proxy setHeight:[properties objectForKey:@"height"]];
                }
            };
            BASIC_POP_ATTR( animSize );
            
            [proxy.view.layer pop_addAnimation:animSize forKey:@"BasicAnimationSize"];
            
        } else if ( !TiDimensionIsUndefined(width) &&
                    !TiDimensionIsUndefined(height) ) {
            
            animSize.toValue = [NSValue valueWithCGSize:CGSizeMake(frameCache.size.width, frameCache.size.height)];
            animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                if ( completed ) {
                    [proxy setWidth:[properties objectForKey:@"width"]];
                    [proxy setHeight:[properties objectForKey:@"height"]];
                }
            };
            BASIC_POP_ATTR( animSize );
            
            [proxy.view.layer pop_addAnimation:animSize forKey:@"BasicAnimationSize"];
        }
        
    }
    
    if ( nil != opacity ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationOpacity"];
        
        POPBasicAnimation *animOpacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        animOpacity.toValue = @(opacity.floatValue);
        animOpacity.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:opacity forKey:@"opacity"];
            }
        };
        BASIC_POP_ATTR( animOpacity );
        
        [proxy.view.layer pop_addAnimation:animOpacity forKey:@"BasicAnimationOpacity"];
        
    }
    
    if ( nil != backgroundColor ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationBackgroundColor"];
        
        POPBasicAnimation *animBackgroundColor = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        animBackgroundColor.toValue = backgroundColor.color;
        animBackgroundColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:backgroundColor forKey:@"backgroundColor"];
            }
        };
        BASIC_POP_ATTR( animBackgroundColor );
        
        [proxy.view.layer pop_addAnimation:animBackgroundColor forKey:@"BasicAnimationBackgroundColor"];
        
    }
    
    if ( [proxy.view isKindOfClass:[TiUILabel class]] && nil != color ) {
        
        [[(TiUILabel *)proxy.view label] pop_removeAnimationForKey:@"BasicAnimationLabelTextColor"];
        
        POPBasicAnimation *animColor = [POPBasicAnimation animationWithPropertyNamed:kPOPLabelTextColor];
        animColor.toValue = color.color;
        animColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:color forKey:@"color"];
            }
        };
        BASIC_POP_ATTR( animColor );
        
        [[(TiUILabel *)proxy.view label] pop_addAnimation:animColor forKey:@"BasicAnimationLabelTextColor"];
    }
    
    if ( nil != tintColor ) {
        
        [proxy.view pop_removeAnimationForKey:@"BasicAnimationTintColor"];
        
        POPBasicAnimation *animTintColor = [POPBasicAnimation animationWithPropertyNamed:kPOPViewTintColor];
        animTintColor.toValue = tintColor.color;
        animTintColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:tintColor forKey:@"tintColor"];
            }
        };
        BASIC_POP_ATTR( animTintColor );
        
        [proxy.view pop_addAnimation:animTintColor forKey:@"BasicAnimationTintColor"];
        
    }
    
    if ( nil != borderWidth ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationBorderWidth"];
        
        POPBasicAnimation *animBorderWidth = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBorderWidth];
        animBorderWidth.toValue = @(borderWidth.floatValue);
        animBorderWidth.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:borderWidth forKey:@"borderWidth"];
            }
        };
        BASIC_POP_ATTR( animBorderWidth );
        
        [proxy.view.layer pop_addAnimation:animBorderWidth forKey:@"BasicAnimationBorderWidth"];
        
    }
    
    if ( nil != borderColor ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationBorderColor"];
        
        POPBasicAnimation *animBorderColor = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerBorderColor];
        animBorderColor.toValue = borderColor.color;
        animBorderColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:borderColor forKey:@"borderColor"];
            }
        };
        BASIC_POP_ATTR( animBorderColor );
        
        [proxy.view.layer pop_addAnimation:animBorderColor forKey:@"BasicAnimationBorderColor"];
        
    }
    
    if ( nil != borderRadius ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationBorderRadius"];
        
        POPBasicAnimation *animBorderRadius = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
        animBorderRadius.toValue = @(borderRadius.floatValue);
        animBorderRadius.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if (completed) {
                [proxy setValue:borderRadius forKey:@"borderRadius"];
            }
        };
        BASIC_POP_ATTR( animBorderRadius );
        
        [proxy.view.layer pop_addAnimation:animBorderRadius forKey:@"BasicAnimationBorderRadius"];
        
    }
    
    if ( nil != [properties objectForKey:@"rotate"] ) {
        
        id rotate = [properties objectForKey:@"rotate"];
        
        if ( [rotate isKindOfClass:[NSDictionary class]] ) {
            
            id rotateX = [rotate objectForKey:@"x"];
            id rotateY = [rotate objectForKey:@"y"];
            id rotateZ = [rotate objectForKey:@"z"];
            
            if ( nil != rotateX &&
                 nil == rotateY &&
                 nil == rotateZ ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationRotationX"];
                POPBasicAnimation *animRotationX = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationX];
                animRotationX.toValue = @( degreesToRadians([rotateX doubleValue]) );
                animRotationX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                BASIC_POP_ATTR( animRotationX );
                [proxy.view.layer pop_addAnimation:animRotationX forKey:@"BasicAnimationRotationX"];
                
            } else if ( nil != rotateY &&
                        nil == rotateX &&
                        nil == rotateZ ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationRotationY"];
                POPBasicAnimation *animRotationY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotationY];
                animRotationY.toValue = @( degreesToRadians([rotateY doubleValue]) );
                animRotationY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                BASIC_POP_ATTR( animRotationY );
                [proxy.view.layer pop_addAnimation:animRotationY forKey:@"BasicAnimationRotationY"];
                
            } else if ( nil != rotateZ &&
                        nil == rotateX &&
                        nil == rotateY ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationRotationZ"];
                POPBasicAnimation *animRotationZ = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
                animRotationZ.toValue = @( degreesToRadians([rotateZ doubleValue]) );
                animRotationZ.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                BASIC_POP_ATTR( animRotationZ );
                [proxy.view.layer pop_addAnimation:animRotationZ forKey:@"BasicAnimationRotationZ"];
                
            } else {
                
                CGFloat rx = rotateX ? [rotateX doubleValue] : 0.f;
                CGFloat ry = rotateY ? [rotateY doubleValue] : 0.f;
                CGFloat rz = rotateZ ? [rotateZ doubleValue] : 0.f;
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationRotation3D"];
                POPBasicAnimation *animRotation3D = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation3D];
                animRotation3D.toValue = [NSValue valueWithCGRect:CGRectMake( degreesToRadians(rx), degreesToRadians(ry), degreesToRadians(rz), /* placeholder with meaningless value. suggest support 3d vector. */-1)];
                animRotation3D.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                BASIC_POP_ATTR( animRotation3D );
                [proxy.view.layer pop_addAnimation:animRotation3D forKey:@"BasicAnimationRotation3D"];
                
            }
            
        }
        
    }
    
    if ( nil != [properties objectForKey:@"scale"] ) {
        
        id scale = [properties objectForKey:@"scale"];
        
        if ( [scale isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [scale objectForKey:@"x"] &&
                 nil == [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationScaleX"];
                POPBasicAnimation *animScaleX = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleX];
                animScaleX.toValue = @( [[scale objectForKey:@"x"] floatValue] );
                animScaleX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                BASIC_POP_ATTR( animScaleX );
                [proxy.view.layer pop_addAnimation:animScaleX forKey:@"BasicAnimationScaleX"];
                
            } else if ( nil == [scale objectForKey:@"x"] &&
                        nil != [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationScaleY"];
                POPBasicAnimation *animScaleY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleY];
                animScaleY.toValue = @( [[scale objectForKey:@"y"] floatValue] );
                animScaleY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                BASIC_POP_ATTR( animScaleY );
                [proxy.view.layer pop_addAnimation:animScaleY forKey:@"BasicAnimationScaleY"];
                
            } else if ( nil != [scale objectForKey:@"x"] &&
                        nil != [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationScaleXY"];
                POPBasicAnimation *animScaleXY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                animScaleXY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                animScaleXY.toValue = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[scale objectForKey:@"x"] floatValue],
                                                                            [[scale objectForKey:@"y"] floatValue]
                                                                            )];
                BASIC_POP_ATTR( animScaleXY );
                [proxy.view.layer pop_addAnimation:animScaleXY forKey:@"BasicAnimationScaleXY"];
                
            }
            
        }
        
    }
    
    if ( nil != [properties objectForKey:@"translate"] ) {
        
        id translate = [properties objectForKey:@"translate"];
        
        if ( [translate isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [translate objectForKey:@"x"] &&
                 nil == [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationTranslateX"];
                POPBasicAnimation *animTranslateX = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
                animTranslateX.toValue = @( [[translate objectForKey:@"x"] floatValue] );
                animTranslateX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                    
                BASIC_POP_ATTR( animTranslateX );
                [proxy.view.layer pop_addAnimation:animTranslateX forKey:@"BasicAnimationTranslateX"];
                
            } else if ( nil == [translate objectForKey:@"x"] &&
                        nil != [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationTranslateY"];
                POPBasicAnimation *animTranslateY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
                animTranslateY.toValue = @( [[translate objectForKey:@"y"] floatValue] );
                animTranslateY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                    
                BASIC_POP_ATTR( animTranslateY );
                [proxy.view.layer pop_addAnimation:animTranslateY forKey:@"BasicAnimationTranslateY"];
                
                
            } else if ( nil != [translate objectForKey:@"x"] &&
                        nil != [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationTranslateXY"];
                POPBasicAnimation *animTranslateXY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationXY];
                animTranslateXY.toValue = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[translate objectForKey:@"x"] floatValue],
                                                                            [[translate objectForKey:@"y"] floatValue]
                                                                            )];
                animTranslateXY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                BASIC_POP_ATTR( animTranslateXY );
                [proxy.view.layer pop_addAnimation:animTranslateXY forKey:@"BasicAnimationTranslateXY"];
                
            }
            
            if ( nil != [translate objectForKey:@"z"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationTranslateZ"];
                POPBasicAnimation *animTranslateZ = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationZ];
                // set transform perspective
                CATransform3D matrix = proxy.view.layer.transform;
                if ( !matrix.m34 ) {
                    matrix.m34 = 1.f / -1000.f;
                    proxy.view.layer.transform = matrix;
                }
                animTranslateZ.toValue = @( [[translate objectForKey:@"z"] floatValue] );
                animTranslateZ.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                BASIC_POP_ATTR( animTranslateZ );
                [proxy.view.layer pop_addAnimation:animTranslateZ forKey:@"BasicAnimationTranslateZ"];
                
            }
            
        }
        
    }
    
    if ( nil != proxy.view.layer.sublayers[0] &&
         [proxy.view.layer.sublayers[0] isKindOfClass:[CAShapeLayer class]] ) {
    
        if ( nil != strokeStart ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"BasicAnimationStrokeStart"];
            
            POPBasicAnimation *animStrokeStart = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
            animStrokeStart.toValue = @(strokeStart.floatValue);
            BASIC_POP_ATTR( animStrokeStart );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animStrokeStart forKey:@"BasicAnimationStrokeStart"];
            
        }
        
        if ( nil != strokeEnd ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"BasicAnimationStrokeEnd"];
            
            POPBasicAnimation *animStrokeEnd = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
            animStrokeEnd.toValue = @(strokeEnd.floatValue);
            BASIC_POP_ATTR( animStrokeEnd );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animStrokeEnd forKey:@"BasicAnimationStrokeEnd"];
            
        }
        
        if ( nil != lineWidth ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"BasicAnimationLineWidth"];
            
            POPBasicAnimation *animLineWidth = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerLineWidth];
            animLineWidth.toValue = @(lineWidth.floatValue);
            BASIC_POP_ATTR( animLineWidth );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animLineWidth forKey:@"BasicAnimationLineWidth"];
            
        }
        
        if ( nil != strokeColor ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"BasicAnimationStrokeColor"];
            
            POPBasicAnimation *animStrokeColor = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeColor];
            animStrokeColor.toValue = strokeColor.color;
            BASIC_POP_ATTR( animStrokeColor );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animStrokeColor forKey:@"BasicAnimationStrokeColor"];
            
        }
        
        if ( nil != fillColor ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"BasicAnimationFillColor"];
            
            POPBasicAnimation *animFillColor = [POPBasicAnimation animationWithPropertyNamed:kPOPShapeLayerFillColor];
            animFillColor.toValue = fillColor.color;
            BASIC_POP_ATTR( animFillColor );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animFillColor forKey:@"BasicAnimationFillColor"];
            
        }
        
    }
    
//    if ( nil != [properties objectForKey:@"center"] ) {
//        
//        id center = [properties objectForKey:@"center"];
//        
//        if ( [center isKindOfClass:[NSDictionary class]] ) {
//            
//            TiDimension centerX = [TiUtils dimensionValue:@"x" properties:center def:TiDimensionUndefined];
//            TiDimension centerY = [TiUtils dimensionValue:@"y" properties:center def:TiDimensionUndefined];
//            
//            if ( !TiDimensionIsUndefined(centerX) &&
//                 !TiDimensionIsUndefined(centerY) ) {
//                
//                [proxy.view pop_removeAnimationForKey:@"BasicAnimationCenter"];
//                POPBasicAnimation *animCenter = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
//                animCenter.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX.value, centerY.value)];
                //XXX: setCenter would make our view moving back to the original position. need more debugs.
//                animCenter.completionBlock = ^(POPAnimation *anim, BOOL completed) {
//                    if ( completed ) {
//                        NSDictionary *c = [[NSDictionary alloc] initWithObjects:@[@(centerX.value), @(centerY.value)] forKeys:@[@"x", @"y"]];
//                        [proxy setCenter:c];
//                    }
//                };
//                BASIC_POP_ATTR( animCenter );
//                [proxy.view pop_addAnimation:animCenter forKey:@"BasicAnimationCenter"];
//                
//            }
//        }
//    }
    
    if ( nil != zIndex ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationZIndex"];
        
        POPBasicAnimation *animZIndex = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerZPosition];
        animZIndex.toValue = @(zIndex.intValue);
        animZIndex.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if (completed) {
                [proxy setZIndex:zIndex];
            }
        };
        BASIC_POP_ATTR( animZIndex );
        
        [proxy.view.layer pop_addAnimation:animZIndex forKey:@"BasicAnimationZIndex"];
        
    }
    
    if ( nil != shadowColor ) {
        
        [proxy.view.shadowLayer pop_removeAnimationForKey:@"BasicAnimationShadowColor"];
        
        POPBasicAnimation *animShadowColor = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerShadowColor];
        animShadowColor.toValue = shadowColor.color;
        animShadowColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if (completed) {
                [proxy setValue:shadowColor forKey:@"viewShadowColor"];
            }
        };
        BASIC_POP_ATTR( animShadowColor );
        
        [proxy.view.shadowLayer pop_addAnimation:animShadowColor forKey:@"BasicAnimationShadowColor"];
        
    }
    
    if ( nil != shadowOpacity ) {
        
        [proxy.view.shadowLayer pop_removeAnimationForKey:@"BasicAnimationShadowOpacity"];
        
        POPBasicAnimation *animShadowOpacity = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerShadowOpacity];
        animShadowOpacity.toValue = @(shadowOpacity.floatValue);
        
//        animShadowOpacity.completionBlock = ^(POPAnimation *anim, BOOL completed) {
//            if (completed) {
//                [proxy setValue:shadowColor forKey:@"viewShadowOpacity"];
//            }
//        };
        
        BASIC_POP_ATTR( animShadowOpacity );
        
        [proxy.view.shadowLayer pop_addAnimation:animShadowOpacity forKey:@"BasicAnimationShadowOpacity"];
        
    }
    
    if ( nil != [properties objectForKey:@"subTranslate"] ) {
        
        id subTranslate = [properties objectForKey:@"subTranslate"];
        
        if ( [subTranslate isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [subTranslate objectForKey:@"x"] &&
                 nil == [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationSubTranslateX"];
                POPBasicAnimation *animSubTranslateX = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSubtranslationX];
                animSubTranslateX.toValue = @( [[subTranslate objectForKey:@"x"] floatValue] );
                BASIC_POP_ATTR( animSubTranslateX );
                [proxy.view.layer pop_addAnimation:animSubTranslateX forKey:@"BasicAnimationSubTranslateX"];
                
            } else if ( nil == [subTranslate objectForKey:@"x"] &&
                        nil != [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationSubTranslateY"];
                POPBasicAnimation *animSubTranslateY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSubtranslationY];
                animSubTranslateY.toValue = @( [[subTranslate objectForKey:@"y"] floatValue] );
                BASIC_POP_ATTR( animSubTranslateY );
                [proxy.view.layer pop_addAnimation:animSubTranslateY forKey:@"BasicAnimationSubTranslateY"];
                
            } else if ( nil != [subTranslate objectForKey:@"x"] &&
                        nil != [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"BasicAnimationSubTranslateXY"];
                POPBasicAnimation *animSubTranslateXY = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerSubtranslationXY];
                animSubTranslateXY.toValue = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[subTranslate objectForKey:@"x"] floatValue],
                                                                            [[subTranslate objectForKey:@"y"] floatValue]
                                                                            )];
                BASIC_POP_ATTR( animSubTranslateXY );
                [proxy.view.layer pop_addAnimation:animSubTranslateXY forKey:@"BasicAnimationSubTranslateXY"];
                
            }
            
//            if ( nil != [subTranslate objectForKey:@"z"] ) {
//                
//                POPBasicAnimation *animSubTranslateZ = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerTranslationZ];
//                animSubTranslateZ.toValue = @( [[subTranslate objectForKey:@"z"] floatValue] );
//                BASIC_POP_ATTR( animSubTranslateZ );
//                
//                // set sublayers transform perspective
//                CATransform3D subMatrix = proxy.view.layer.sublayerTransform;
//                subMatrix.m34 = 1.f / -1000.f;
//                proxy.view.layer.sublayerTransform = subMatrix;
//                
//                [proxy.view.layer pop_addAnimation:animSubTranslateZ forKey:nil];
//                
//            }
            
        }
        
    }
    
    if ( [proxy.view isKindOfClass:[TiUIScrollView class]] ) {
        
        if ( nil != [properties objectForKey:@"scrollViewContentOffset"] ) {
            
            id scrollViewContentOffset = [properties objectForKey:@"scrollViewContentOffset"];
            
            if ( [scrollViewContentOffset isKindOfClass:[NSDictionary class]] ) {
                
                float x = ( nil != [scrollViewContentOffset objectForKey:@"x"] ) ?
                          [[scrollViewContentOffset objectForKey:@"x"] floatValue] : 0.f;
                
                float y = ( nil != [scrollViewContentOffset objectForKey:@"y"] ) ?
                          [[scrollViewContentOffset objectForKey:@"y"] floatValue] : 0.f;
                
                [[(TiUIScrollView *)proxy.view scrollView] pop_removeAnimationForKey:@"BasicAnimationScrollViewContentOffset"];
                POPBasicAnimation *animScrollViewContentOffset = [POPBasicAnimation animationWithPropertyNamed:kPOPScrollViewContentOffset];
                animScrollViewContentOffset.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
                BASIC_POP_ATTR( animScrollViewContentOffset );
                [[(TiUIScrollView *)proxy.view scrollView] pop_addAnimation:animScrollViewContentOffset forKey:@"BasicAnimationScrollViewContentOffset"];
                
            }
            
        }
        
//        if ( nil != [properties objectForKey:@"scrollViewContentInset"] ) {
//            
//            id scrollViewContentInset = [properties objectForKey:@"scrollViewContentInset"];
//            
//            if ( [scrollViewContentInset isKindOfClass:[NSDictionary class]] ) {
//                
//                float top = ( nil != [scrollViewContentInset objectForKey:@"top"] ) ?
//                            [[scrollViewContentInset objectForKey:@"top"] floatValue] : 0.f;
//                
//                float left = ( nil != [scrollViewContentInset objectForKey:@"left"] ) ?
//                            [[scrollViewContentInset objectForKey:@"left"] floatValue] : 0.f;
//                
//                float bottom = ( nil != [scrollViewContentInset objectForKey:@"bottom"] ) ?
//                            [[scrollViewContentInset objectForKey:@"bottom"] floatValue] : 0.f;
//                
//                float right = ( nil != [scrollViewContentInset objectForKey:@"right"] ) ?
//                            [[scrollViewContentInset objectForKey:@"right"] floatValue] : 0.f;
//                
//                POPBasicAnimation *animScrollViewContentInset = [POPBasicAnimation animationWithPropertyNamed:kPOPScrollViewContentInset];
//                if ( nil != duration ) animScrollViewContentInset.duration = ( duration.floatValue / 1000.f );
//                if ( nil != delay ) animScrollViewContentInset.beginTime = CACurrentMediaTime() + ( delay.floatValue / 1000.f );
//                animScrollViewContentInset.timingFunction = [self ease:easing];
//                animScrollViewContentInset.toValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
//                
//                [[(TiUIScrollView *)proxy.view scrollView] pop_addAnimation:animScrollViewContentInset forKey:nil];
//                    
//            }
//            
//        }
        
    }
    
}

-(void)springAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties {
    
#define SPRING_POP_ATTR( animation ) do { \
if ( nil != delay ) animation.beginTime = CACurrentMediaTime() + ( delay.floatValue / 1000.f ); \
if ( nil != springBounciness ) animation.springBounciness = springBounciness.floatValue; \
if ( nil != springSpeed ) animation.springSpeed = springSpeed.floatValue; \
if ( nil != tension ) animation.dynamicsTension = tension.floatValue; \
if ( nil != friction ) animation.dynamicsFriction = friction.floatValue; \
if ( nil != mass ) animation.dynamicsMass = mass.floatValue; \
if ( nil != repeatCount ) animation.repeatCount = repeatCount.integerValue; \
animation.repeatForever = repeatForever; \
animation.additive = addictive; \
animation.autoreverses = autoreverse; \
animation.removedOnCompletion = true; \
} while(0)
    
    TiDimension left = [TiUtils dimensionValue:@"left" properties:properties def:TiDimensionUndefined];
    TiDimension top = [TiUtils dimensionValue:@"top" properties:properties def:TiDimensionUndefined];
    TiDimension width = [TiUtils dimensionValue:@"width" properties:properties def:TiDimensionUndefined];
    TiDimension height = [TiUtils dimensionValue:@"height" properties:properties def:TiDimensionUndefined];
    
    NSNumber *opacity = [TiUtils numberFromObject:[properties objectForKey:@"opacity"]];
    NSNumber *zIndex = [TiUtils numberFromObject:[properties objectForKey:@"zIndex"]];
    
    TiColor *color = [TiUtils colorValue:@"color" properties:properties def:nil];
    TiColor *backgroundColor = [TiUtils colorValue:@"backgroundColor" properties:properties def:nil];
    TiColor *tintColor = [TiUtils colorValue:@"tintColor" properties:properties def:nil];
    
    NSNumber *borderRadius = [TiUtils numberFromObject:[properties objectForKey:@"borderRadius"]];
    NSNumber *borderWidth = [TiUtils numberFromObject:[properties objectForKey:@"borderWidth"]];
    TiColor *borderColor = [TiUtils colorValue:@"borderColor" properties:properties def:nil];
    
    TiColor *shadowColor = [TiUtils colorValue:@"shadowColor" properties:properties def:nil];
    NSNumber *shadowOpacity = [TiUtils numberFromObject:[properties objectForKey:@"shadowOpacity"]];
    
    NSNumber *strokeStart = [TiUtils numberFromObject:[properties objectForKey:@"strokeStart"]];
    NSNumber *strokeEnd = [TiUtils numberFromObject:[properties objectForKey:@"strokeEnd"]];
    TiColor *strokeColor = [TiUtils colorValue:@"strokeColor" properties:properties def:nil];
    TiColor *fillColor = [TiUtils colorValue:@"fillColor" properties:properties def:nil];
    NSNumber *lineWidth = [TiUtils numberFromObject:[properties objectForKey:@"lineWidth"]];
    
    NSNumber *delay = [TiUtils numberFromObject:[properties objectForKey:@"delay"]];
    NSNumber *springBounciness = [TiUtils numberFromObject:[properties objectForKey:@"springBounciness"]];
    NSNumber *springSpeed = [TiUtils numberFromObject:[properties objectForKey:@"springSpeed"]];
    NSNumber *tension = [TiUtils numberFromObject:[properties objectForKey:@"tension"]];
    NSNumber *friction = [TiUtils numberFromObject:[properties objectForKey:@"friction"]];
    NSNumber *mass = [TiUtils numberFromObject:[properties objectForKey:@"mass"]];
    NSNumber *repeatCount = [TiUtils numberFromObject:[properties objectForKey:@"repeatCount"]];
    
    BOOL addictive = [TiUtils boolValue:@"addictive" properties:properties def:false];
    BOOL repeatForever = [TiUtils boolValue:@"repeatForever" properties:properties def:false];
    BOOL autoreverse = [TiUtils boolValue:@"autoreverse" properties:properties def:false];
    
    // set opaque to YES to gain more performance.
    [proxy.view setOpaque:YES];
    layoutConstraint = proxy.layoutProperties;
    [self recalcConstraint:proxy width:width height:height left:left top:top center:[properties objectForKey:@"center"]];
    
    if ( !TiDimensionIsUndefined(left) ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationPositionX"];
        
        POPSpringAnimation *animPositionX = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        animPositionX.toValue = @(frameCache.origin.x);
        animPositionX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setLeft:[properties objectForKey:@"left"]];
            }
        };
        SPRING_POP_ATTR( animPositionX );
        
        [proxy.view.layer pop_addAnimation:animPositionX forKey:@"SpringAnimationPositionX"];
        
    }
    
    if ( !TiDimensionIsUndefined(top) ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationPositionY"];
        
        POPSpringAnimation *animPositionY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        animPositionY.toValue = @(frameCache.origin.y);
        animPositionY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setTop:[properties objectForKey:@"top"]];
            }
        };
        SPRING_POP_ATTR( animPositionY );
        
        [proxy.view.layer pop_addAnimation:animPositionY forKey:@"SpringAnimationPositionY"];
        
    }
    
    if ( !TiDimensionIsUndefined(width) ||
         !TiDimensionIsUndefined(height) ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationSize"];
        POPSpringAnimation *animSize = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
        
        if ( !TiDimensionIsUndefined(width) &&
              TiDimensionIsUndefined(height) ) {
            
            animSize.toValue = [NSValue valueWithCGSize:CGSizeMake(frameCache.size.width, proxy.view.layer.bounds.size.height)];
            animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                if ( completed ) {
                    [proxy setWidth:[properties objectForKey:@"width"]];
                }
            };
            
            SPRING_POP_ATTR( animSize );
            [proxy.view.layer pop_addAnimation:animSize forKey:@"SpringAnimationSize"];
            
        } else if ( TiDimensionIsUndefined(width) &&
                   !TiDimensionIsUndefined(height) ) {
            
            animSize.toValue = [NSValue valueWithCGSize:CGSizeMake(proxy.view.layer.bounds.size.width, frameCache.size.height)];
            animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                if ( completed ) {
                    [proxy setHeight:[properties objectForKey:@"height"]];
                }
            };
            
            SPRING_POP_ATTR( animSize );
            [proxy.view.layer pop_addAnimation:animSize forKey:@"SpringAnimationSize"];
            
        } else if ( !TiDimensionIsUndefined(width) &&
                    !TiDimensionIsUndefined(height) ) {
            
            animSize.toValue = [NSValue valueWithCGSize:CGSizeMake(frameCache.size.width, frameCache.size.height)];
            animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                if ( completed ) {
                    [proxy setWidth:[properties objectForKey:@"width"]];
                    [proxy setHeight:[properties objectForKey:@"height"]];
                }
            };
            
            SPRING_POP_ATTR( animSize );
            [proxy.view.layer pop_addAnimation:animSize forKey:@"SpringAnimationSize"];
            
        }
        
    }
    
    if ( nil != opacity ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationOpacity"];
        
        POPSpringAnimation *animOpaticy = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        animOpaticy.toValue = @(opacity.floatValue);
        animOpaticy.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:opacity forKey:@"opacity"];
            }
        };
        SPRING_POP_ATTR( animOpaticy );
        
        [proxy.view.layer pop_addAnimation:animOpaticy forKey:@"SpringAnimationOpacity"];
        
    }
    
    if ( nil != backgroundColor ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationBackgroundColor"];
        
        POPSpringAnimation *animBackgroundColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBackgroundColor];
        animBackgroundColor.toValue = backgroundColor.color;
        animBackgroundColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:backgroundColor forKey:@"backgroundColor"];
            }
        };
        
        SPRING_POP_ATTR( animBackgroundColor );
        [proxy.view.layer pop_addAnimation:animBackgroundColor forKey:@"SpringAnimationBackgroundColor"];
        
    }
    
    if ( [proxy.view isKindOfClass:[TiUILabel class]] && nil != color ) {
        
        [[(TiUILabel *)proxy.view label] pop_removeAnimationForKey:@"SpringAnimationLabelTextColor"];
        
        POPSpringAnimation *animColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLabelTextColor];
        animColor.toValue = color.color;
        animColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:color forKey:@"color"];
            }
        };
        SPRING_POP_ATTR( animColor );
        
        [[(TiUILabel *)proxy.view label] pop_addAnimation:animColor forKey:@"SpringAnimationLabelTextColor"];
        
    }
    
    if ( nil != tintColor ) {
        
        [proxy.view pop_removeAnimationForKey:@"SpringAnimationTintColor"];
        
        POPSpringAnimation *animTintColor = [POPSpringAnimation animationWithPropertyNamed:kPOPViewTintColor];
        animTintColor.toValue = tintColor.color;
        animTintColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:tintColor forKey:@"tintColor"];
            }
        };
        SPRING_POP_ATTR( animTintColor );
        
        [proxy.view pop_addAnimation:animTintColor forKey:@"SpringAnimationTintColor"];
        
    }
    
    if ( nil != borderWidth ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationBorderWidth"];
        
        POPSpringAnimation *animBorderWidth = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBorderWidth];
        animBorderWidth.toValue = @(borderWidth.floatValue);
        animBorderWidth.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:borderWidth forKey:@"borderWidth"];
            }
        };
        SPRING_POP_ATTR( animBorderWidth );
        
        [proxy.view.layer pop_addAnimation:animBorderWidth forKey:@"SpringAnimationBorderWidth"];
        
    }
    
    if ( nil != borderColor ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationBorderColor"];
        
        POPSpringAnimation *animBorderColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBorderColor];
        animBorderColor.toValue = borderColor.color;
        animBorderColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:borderColor forKey:@"borderColor"];
            }
        };
        SPRING_POP_ATTR( animBorderColor );
        
        [proxy.view.layer pop_addAnimation:animBorderColor forKey:@"SpringAnimationBorderColor"];
        
    }
    
    if ( nil != borderRadius ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationBorderRadius"];
        
        POPSpringAnimation *animBorderRadius = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
        animBorderRadius.toValue = @(borderRadius.floatValue);
        animBorderRadius.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if (completed) {
                [proxy setValue:borderRadius forKey:@"borderRadius"];
            }
        };
        
        SPRING_POP_ATTR( animBorderRadius );
        [proxy.view.layer pop_addAnimation:animBorderRadius forKey:@"SpringAnimationBorderRadius"];
        
    }
    
    if ( nil != [properties objectForKey:@"rotate"] ) {
        
        id rotate = [properties objectForKey:@"rotate"];
        
        if ( [rotate isKindOfClass:[NSDictionary class]] ) {
            
            id rotateX = [rotate objectForKey:@"x"];
            id rotateY = [rotate objectForKey:@"y"];
            id rotateZ = [rotate objectForKey:@"z"];
            
            if ( nil != rotateX &&
                 nil == rotateY &&
                 nil == rotateZ ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationRotationX"];
                POPSpringAnimation *animRotationX = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationX];
                animRotationX.toValue = @( degreesToRadians([rotateX doubleValue]) );
                animRotationX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animRotationX );
                [proxy.view.layer pop_addAnimation:animRotationX forKey:@"SpringAnimationRotationX"];
                
            } else if ( nil != rotateY &&
                        nil == rotateX &&
                        nil == rotateZ ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationRotationY"];
                POPSpringAnimation *animRotationY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotationY];
                animRotationY.toValue = @( degreesToRadians([rotateY doubleValue]) );
                animRotationY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animRotationY );
                [proxy.view.layer pop_addAnimation:animRotationY forKey:@"SpringAnimationRotationY"];
                
            } else if ( nil != rotateZ &&
                        nil == rotateX &&
                        nil == rotateY ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationRotationZ"];
                POPSpringAnimation *animRotationZ = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
                animRotationZ.toValue = @( degreesToRadians([rotateZ doubleValue]) );
                animRotationZ.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animRotationZ );
                [proxy.view.layer pop_addAnimation:animRotationZ forKey:@"SpringAnimationRotationZ"];
                
            } else {
                
                CGFloat rx = rotateX ? [rotateX doubleValue] : 0.f;
                CGFloat ry = rotateY ? [rotateY doubleValue] : 0.f;
                CGFloat rz = rotateZ ? [rotateZ doubleValue] : 0.f;
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationRotation3D"];
                POPSpringAnimation *animRotation3D = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation3D];
                animRotation3D.toValue = [NSValue valueWithCGRect:CGRectMake( degreesToRadians(rx), degreesToRadians(ry), degreesToRadians(rz), /* placeholder with meaningless value. suggest support 3d vector. */-1)];
                animRotation3D.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animRotation3D );
                [proxy.view.layer pop_addAnimation:animRotation3D forKey:@"SpringAnimationRotation3D"];
                
            }
            
        }
        
    }
    
    if ( nil != [properties objectForKey:@"scale"] ) {
        
        id scale = [properties objectForKey:@"scale"];
        
        if ( [scale isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [scale objectForKey:@"x"] &&
                 nil == [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationScaleX"];
                POPSpringAnimation *animScaleX = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleX];
                animScaleX.toValue = @( [[scale objectForKey:@"x"] floatValue] );
                animScaleX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animScaleX );
                [proxy.view.layer pop_addAnimation:animScaleX forKey:@"SpringAnimationScaleX"];
                
            } else if ( nil == [scale objectForKey:@"x"] &&
                        nil != [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationScaleY"];
                POPSpringAnimation *animScaleY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleY];
                animScaleY.toValue = @( [[scale objectForKey:@"y"] floatValue] );
                animScaleY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animScaleY );
                [proxy.view.layer pop_addAnimation:animScaleY forKey:@"SpringAnimationScaleY"];
                
            } else if ( nil != [scale objectForKey:@"x"] &&
                        nil != [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationScaleXY"];
                POPSpringAnimation *animScaleXY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                animScaleXY.toValue = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[scale objectForKey:@"x"] floatValue],
                                                                            [[scale objectForKey:@"y"] floatValue]
                                                                            )];
                animScaleXY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animScaleXY );
                [proxy.view.layer pop_addAnimation:animScaleXY forKey:@"SpringAnimationScaleXY"];
                
            }
            
        }
        
    }
    
    if ( nil != [properties objectForKey:@"translate"] ) {
        
        id translate = [properties objectForKey:@"translate"];
        
        if ( [translate isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [translate objectForKey:@"x"] &&
                 nil == [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationTranslateX"];
                POPSpringAnimation *animTranslateX = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
                animTranslateX.toValue = @( [[translate objectForKey:@"x"] floatValue] );
                animTranslateX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animTranslateX );
                [proxy.view.layer pop_addAnimation:animTranslateX forKey:@"SpringAnimationTranslateX"];
                
            } else if ( nil == [translate objectForKey:@"x"] &&
                        nil != [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationTranslateY"];
                POPSpringAnimation *animTranslateY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
                animTranslateY.toValue = @( [[translate objectForKey:@"y"] floatValue] );
                animTranslateY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animTranslateY );
                [proxy.view.layer pop_addAnimation:animTranslateY forKey:@"SpringAnimationTranslateY"];
                
            } else if ( nil != [translate objectForKey:@"x"] &&
                        nil != [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationTranslateXY"];
                POPSpringAnimation *animTranslateXY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationXY];
                animTranslateXY.toValue = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[translate objectForKey:@"x"] floatValue],
                                                                            [[translate objectForKey:@"y"] floatValue]
                                                                            )];
                animTranslateXY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                    
                SPRING_POP_ATTR( animTranslateXY );
                [proxy.view.layer pop_addAnimation:animTranslateXY forKey:@"SpringAnimationTranslateXY"];
                
            }
            
            if ( nil != [translate objectForKey:@"z"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationTranslateZ"];
                POPSpringAnimation *animTranslateZ = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationZ];
                
                // set transform perspective
                CATransform3D matrix = proxy.view.layer.transform;
                if ( !matrix.m34 ) {
                    matrix.m34 = 1.f / -1000.f;
                    proxy.view.layer.transform = matrix;
                }
                
                animTranslateZ.toValue = @( [[translate objectForKey:@"z"] floatValue] );
                animTranslateZ.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                
                SPRING_POP_ATTR( animTranslateZ );
                [proxy.view.layer pop_addAnimation:animTranslateZ forKey:@"SpringAnimationTranslateZ"];
                
            }
            
        }
        
    }
    
    if ( nil != proxy.view.layer.sublayers[0] &&
         [proxy.view.layer.sublayers[0] isKindOfClass:[CAShapeLayer class]] ) {
    
        if ( nil != strokeStart ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"SpringAnimationStrokeStart"];
            
            POPSpringAnimation *animStrokeStart = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
            animStrokeStart.toValue = @(strokeStart.floatValue);
            SPRING_POP_ATTR( animStrokeStart );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animStrokeStart forKey:@"SpringAnimationStrokeStart"];
            
        }
        
        if ( nil != strokeEnd ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"SpringAnimationStrokeEnd"];
            
            POPSpringAnimation *animStrokeEnd = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
            animStrokeEnd.toValue = @(strokeEnd.floatValue);
            SPRING_POP_ATTR( animStrokeEnd );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animStrokeEnd forKey:@"SpringAnimationStrokeEnd"];
            
        }
        
        if ( nil != lineWidth ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"SpringAnimationLineWidth"];
            
            POPSpringAnimation *animLineWidth = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerLineWidth];
            animLineWidth.toValue = @(lineWidth.floatValue);
            SPRING_POP_ATTR( animLineWidth );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animLineWidth forKey:@"SpringAnimationLineWidth"];
            
        }
        
        if ( nil != strokeColor ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"SpringAnimationStrokeColor"];
            
            POPSpringAnimation *animStrokeColor = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeColor];
            animStrokeColor.toValue = strokeColor.color;
            SPRING_POP_ATTR( animStrokeColor );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animStrokeColor forKey:@"SpringAnimationStrokeColor"];
            
        }
        
        if ( nil != fillColor ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"SpringAnimationFillColor"];
            
            POPSpringAnimation *animFillColor = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerFillColor];
            animFillColor.toValue = fillColor.color;
            SPRING_POP_ATTR( animFillColor );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animFillColor forKey:@"SpringAnimationFillColor"];
            
        }
        
    }
    
//    if ( nil != [properties objectForKey:@"center"] ) {
//        
//        id center = [properties objectForKey:@"center"];
//        
//        if ( [center isKindOfClass:[NSDictionary class]] ) {
//            
//            TiDimension centerX = [TiUtils dimensionValue:@"x" properties:center def:TiDimensionUndefined];
//            TiDimension centerY = [TiUtils dimensionValue:@"y" properties:center def:TiDimensionUndefined];
//            
//            if ( !TiDimensionIsUndefined(centerX) &&
//                !TiDimensionIsUndefined(centerY) ) {
//                
//                CGFloat centerXVal = [self calcTiDimensionValue:centerX withKey:@"center.x" andProxy:proxy isDecay:NO];
//                CGFloat centerYVal = [self calcTiDimensionValue:centerY withKey:@"center.y" andProxy:proxy isDecay:NO];
//                
//                if ( centerXVal != ERR_DIMENSION && centerYVal != ERR_DIMENSION ) {
//                
//                    [proxy.view pop_removeAnimationForKey:@"SpringAnimationCenter"];
//                    POPSpringAnimation *animCenter = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
//                    animCenter.toValue = [NSValue valueWithCGPoint:CGPointMake(centerXVal, centerYVal)];
                //XXX: setCenter would make our view moving back to the original position. need more debugs.
//                    animCenter.completionBlock = ^(POPAnimation *anim, BOOL completed) {
//                        if ( completed ) {
//                            NSDictionary *c = [[NSDictionary alloc] initWithObjects:@[@(centerXVal), @(centerYVal)] forKeys:@[@"x", @"y"]];
//                            [proxy setCenter:c];
//                        }
//                    };
                    
//                    SPRING_POP_ATTR( animCenter );
//                    [proxy.view pop_addAnimation:animCenter forKey:@"SpringAnimationCenter"];
//                    
//                }
//            }
//        }
//    }
    
    if ( nil != zIndex ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationZIndex"];
        
        POPSpringAnimation *animZIndex = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerZPosition];
        animZIndex.toValue = @(zIndex.intValue);
        animZIndex.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if (completed) {
                [proxy setZIndex:zIndex];
            }
        };
        
        SPRING_POP_ATTR( animZIndex );
        [proxy.view.layer pop_addAnimation:animZIndex forKey:@"SpringAnimationZIndex"];
        
    }
    
    if ( nil != shadowColor ) {
        
        [proxy.view.shadowLayer pop_removeAnimationForKey:@"SpringAnimationShadowColor"];
        
        POPSpringAnimation *animShadowColor = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowColor];
        animShadowColor.toValue = shadowColor.color;
        animShadowColor.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if (completed) {
                [proxy setValue:shadowColor forKey:@"viewShadowColor"];
            }
        };
        
        SPRING_POP_ATTR( animShadowColor );
        [proxy.view.shadowLayer pop_addAnimation:animShadowColor forKey:@"SpringAnimationShadowColor"];
        
    }
    
    if ( nil != shadowOpacity ) {
        
        [proxy.view.shadowLayer pop_removeAnimationForKey:@"SpringAnimationShadowOpacity"];
        POPSpringAnimation *animShadowOpacity = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerShadowOpacity];
        animShadowOpacity.toValue = @(shadowOpacity.floatValue);
        
//        animShadowOpacity.completionBlock = ^(POPAnimation *anim, BOOL completed) {
//            if (completed) {
//                [proxy setValue:shadowColor forKey:@"viewShadowOpacity"];
//            }
//        };
        
        SPRING_POP_ATTR( animShadowOpacity );
        [proxy.view.shadowLayer pop_addAnimation:animShadowOpacity forKey:@"SpringAnimationShadowOpacity"];
        
    }
    
    if ( nil != [properties objectForKey:@"subTranslate"] ) {
        
        id subTranslate = [properties objectForKey:@"subTranslate"];
        
        if ( [subTranslate isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [subTranslate objectForKey:@"x"] &&
                 nil == [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationSubTranslateX"];
                POPSpringAnimation *animSubTranslateX = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSubtranslationX];
                animSubTranslateX.toValue = @( [[subTranslate objectForKey:@"x"] floatValue] );
                SPRING_POP_ATTR( animSubTranslateX );
                [proxy.view.layer pop_addAnimation:animSubTranslateX forKey:@"SpringAnimationSubTranslateX"];
                
            } else if ( nil == [subTranslate objectForKey:@"x"] &&
                        nil != [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationSubTranslateY"];
                POPSpringAnimation *animSubTranslateY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSubtranslationY];
                animSubTranslateY.toValue = @( [[subTranslate objectForKey:@"y"] floatValue] );
                SPRING_POP_ATTR( animSubTranslateY );
                [proxy.view.layer pop_addAnimation:animSubTranslateY forKey:@"SpringAnimationSubTranslateY"];
                
            } else if ( nil != [subTranslate objectForKey:@"x"] &&
                        nil != [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"SpringAnimationSubTranslateXY"];
                POPSpringAnimation *animSubTranslateXY = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSubtranslationXY];
                animSubTranslateXY.toValue = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[subTranslate objectForKey:@"x"] floatValue],
                                                                            [[subTranslate objectForKey:@"y"] floatValue]
                                                                            )];
                SPRING_POP_ATTR( animSubTranslateXY );
                [proxy.view.layer pop_addAnimation:animSubTranslateXY forKey:@"SpringAnimationSubTranslateXY"];
                
            }
            
//            if ( nil != [subTranslate objectForKey:@"z"] ) {
//                
//                POPSpringAnimation *animSubTranslateZ = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerTranslationZ];
//                animSubTranslateZ.toValue = @( [[subTranslate objectForKey:@"z"] floatValue] );
//                SPRING_POP_ATTR( animSubTranslateZ );
//                
//                // set sublayers transform perspective
//                CATransform3D subMatrix = proxy.view.layer.sublayerTransform;
//                subMatrix.m34 = 1.f / -1000.f;
//                proxy.view.layer.sublayerTransform = subMatrix;
//                
//                [proxy.view.layer pop_addAnimation:animSubTranslateZ forKey:nil];
//                
//            }
            
        }
        
    }
    
    if ( [proxy.view isKindOfClass:[TiUIScrollView class]] ) {
        
        if ( nil != [properties objectForKey:@"scrollViewContentOffset"] ) {
            
            id scrollViewContentOffset = [properties objectForKey:@"scrollViewContentOffset"];
            
            if ( [scrollViewContentOffset isKindOfClass:[NSDictionary class]] ) {
                
                float x = ( nil != [scrollViewContentOffset objectForKey:@"x"] ) ?
                          [[scrollViewContentOffset objectForKey:@"x"] floatValue] : 0.f;
                
                float y = ( nil != [scrollViewContentOffset objectForKey:@"y"] ) ?
                          [[scrollViewContentOffset objectForKey:@"y"] floatValue] : 0.f;
                
                [[(TiUIScrollView *)proxy.view scrollView] pop_removeAnimationForKey:@"SpringAnimationScrollViewContentOffset"];
                
                POPSpringAnimation *animScrollViewContentOffset = [POPSpringAnimation animationWithPropertyNamed:kPOPScrollViewContentOffset];
                animScrollViewContentOffset.toValue = [NSValue valueWithCGPoint:CGPointMake(x, y)];
                SPRING_POP_ATTR( animScrollViewContentOffset );
                
                [[(TiUIScrollView *)proxy.view scrollView] pop_addAnimation:animScrollViewContentOffset forKey:@"SpringAnimationScrollViewContentOffset"];
                
            }
            
        }
        
//        if ( nil != [properties objectForKey:@"scrollViewContentInset"] ) {
//            
//            id scrollViewContentInset = [properties objectForKey:@"scrollViewContentInset"];
//            
//            if ( [scrollViewContentInset isKindOfClass:[NSDictionary class]] ) {
//                
//                float top = ( nil != [scrollViewContentInset objectForKey:@"top"] ) ?
//                            [[scrollViewContentInset objectForKey:@"top"] floatValue] : 0.f;
//                
//                float left = ( nil != [scrollViewContentInset objectForKey:@"left"] ) ?
//                            [[scrollViewContentInset objectForKey:@"left"] floatValue] : 0.f;
//                
//                float bottom = ( nil != [scrollViewContentInset objectForKey:@"bottom"] ) ?
//                            [[scrollViewContentInset objectForKey:@"bottom"] floatValue] : 0.f;
//                
//                float right = ( nil != [scrollViewContentInset objectForKey:@"right"] ) ?
//                            [[scrollViewContentInset objectForKey:@"right"] floatValue] : 0.f;
//                
//                POPBasicAnimation *animScrollViewContentInset = [POPBasicAnimation animationWithPropertyNamed:kPOPScrollViewContentInset];
//                if ( nil != duration ) animScrollViewContentInset.duration = ( duration.floatValue / 1000.f );
//                if ( nil != delay ) animScrollViewContentInset.beginTime = CACurrentMediaTime() + ( delay.floatValue / 1000.f );
//                animScrollViewContentInset.timingFunction = [self ease:easing];
//                animScrollViewContentInset.toValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
//                
//                [[(TiUIScrollView *)proxy.view scrollView] pop_addAnimation:animScrollViewContentInset forKey:nil];
//                    
//            }
//            
//        }
        
    }
    
}


-(void)decayAnimationWithProxy:(TiViewProxy *)proxy andProperties:(NSDictionary *)properties {
    
#define DECAY_POP_ATTR( animation ) do { \
if ( nil != delay ) animation.beginTime = CACurrentMediaTime() + ( delay.floatValue / 1000.f ); \
if ( nil != repeatCount ) animation.repeatCount = repeatCount.integerValue; \
if ( nil != deceleration ) animation.deceleration = deceleration.floatValue; \
animation.repeatForever = repeatForever; \
animation.additive = addictive; \
animation.removedOnCompletion = true; \
} while(0)
    
    TiDimension left = [TiUtils dimensionValue:@"left" properties:properties def:TiDimensionUndefined];
    TiDimension top = [TiUtils dimensionValue:@"top" properties:properties def:TiDimensionUndefined];
    TiDimension width = [TiUtils dimensionValue:@"width" properties:properties def:TiDimensionUndefined];
    TiDimension height = [TiUtils dimensionValue:@"height" properties:properties def:TiDimensionUndefined];
    
    NSNumber *opacity = [TiUtils numberFromObject:[properties objectForKey:@"opacity"]];
    
    NSNumber *borderRadius = [TiUtils numberFromObject:[properties objectForKey:@"borderRadius"]];
    NSNumber *borderWidth = [TiUtils numberFromObject:[properties objectForKey:@"borderWidth"]];
    
    NSNumber *shadowOpacity = [TiUtils numberFromObject:[properties objectForKey:@"shadowOpacity"]];
    
    NSNumber *strokeStart = [TiUtils numberFromObject:[properties objectForKey:@"strokeStart"]];
    NSNumber *strokeEnd = [TiUtils numberFromObject:[properties objectForKey:@"strokeEnd"]];
    NSNumber *lineWidth = [TiUtils numberFromObject:[properties objectForKey:@"lineWidth"]];
    
    NSNumber *delay = [TiUtils numberFromObject:[properties objectForKey:@"delay"]];
    NSNumber *deceleration = [TiUtils numberFromObject:[properties objectForKey:@"deceleration"]];
    NSNumber *repeatCount = [TiUtils numberFromObject:[properties objectForKey:@"repeatCount"]];
    
    BOOL addictive = [TiUtils boolValue:@"addictive" properties:properties def:false];
    BOOL repeatForever = [TiUtils boolValue:@"repeatForever" properties:properties def:false];
    BOOL autoreverse = [TiUtils boolValue:@"autoreverse" properties:properties def:false];
    
    // set opaque to YES to gain more performance.
    [proxy.view setOpaque:YES];
    
    
    if ( !TiDimensionIsUndefined(left) ) {
        
        CGFloat leftVal = [self calcTiDimensionValue:left withKey:@"left" andProxy:proxy isDecay:YES];
        
        if ( ERR_DIMENSION != leftVal ) {
            
            [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationPositionX"];
            
            POPDecayAnimation *animPositionX = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionX];
            __weak POPDecayAnimation *weakAnimPositionX = animPositionX;
            
            animPositionX.velocity = @(leftVal);
            animPositionX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                if ( completed ) {
                    [proxy replaceValue:weakAnimPositionX.toValue forKey:@"left" notification:NO];
                }
            };
            DECAY_POP_ATTR( animPositionX );
            
            [proxy.view.layer pop_addAnimation:animPositionX forKey:@"DecayAnimationPositionX"];
        
        }
        
    }
    
    if ( !TiDimensionIsUndefined(top) ) {
        
        CGFloat topVal = [self calcTiDimensionValue:top withKey:@"top" andProxy:proxy isDecay:YES];
        
        if ( ERR_DIMENSION != topVal ) {
            
            [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationPositoinY"];
            POPDecayAnimation *animPositionY = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerPositionY];
            __weak POPDecayAnimation *weakAnimPositoinY = animPositionY;
            
            animPositionY.velocity = @(topVal);
            animPositionY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                if ( completed ) {
                    [proxy replaceValue:weakAnimPositoinY.toValue forKey:@"top" notification:NO];
                }
            };
            DECAY_POP_ATTR( animPositionY );
            
            [proxy.view.layer pop_addAnimation:animPositionY forKey:@"DecayAnimationPositoinY"];
            
        }
        
    }
    
    if ( !TiDimensionIsUndefined(width) ||
         !TiDimensionIsUndefined(height) ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationSize"];
        POPDecayAnimation *animSize = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerSize];
        __weak POPDecayAnimation *weakAnimSize = animSize;
        
        if ( !TiDimensionIsUndefined(width) &&
              TiDimensionIsUndefined(height) ) {
            
            CGFloat widthVal = [self calcTiDimensionValue:width withKey:@"width" andProxy:proxy isDecay:YES];
            
            if ( ERR_DIMENSION != widthVal ) {
                
                animSize.velocity = [NSValue valueWithCGSize:CGSizeMake(widthVal, 0)];
                animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if ( completed ) {
                        [proxy replaceValue:@([weakAnimSize.toValue CGSizeValue].width) forKey:@"width" notification:NO];
                    }
                };
                DECAY_POP_ATTR( animSize );
                [proxy.view.layer pop_addAnimation:animSize forKey:@"DecayAnimationSize"];
                
            }
            
        } else if ( TiDimensionIsUndefined(width) &&
                   !TiDimensionIsUndefined(height) ) {
            
            CGFloat heightVal = [self calcTiDimensionValue:height withKey:@"height" andProxy:proxy isDecay:YES];
            
            if ( ERR_DIMENSION != heightVal ) {
                
                animSize.velocity = [NSValue valueWithCGSize:CGSizeMake(0, heightVal)];
                animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if ( completed ) {
                        [proxy replaceValue:@([weakAnimSize.toValue CGSizeValue].height) forKey:@"height" notification:NO];
                    }
                };
                DECAY_POP_ATTR( animSize );
                [proxy.view.layer pop_addAnimation:animSize forKey:@"DecayAnimationSize"];
            
            }
            
        } else if ( !TiDimensionIsUndefined(width) &&
                    !TiDimensionIsUndefined(height) ) {
            
            CGFloat wVal = [self calcTiDimensionValue:width withKey:@"width" andProxy:proxy isDecay:YES];
            CGFloat hVal = [self calcTiDimensionValue:height withKey:@"height" andProxy:proxy isDecay:YES];
            
            if ( ERR_DIMENSION != wVal &&
                 ERR_DIMENSION == hVal) {
                
                animSize.velocity = [NSValue valueWithCGSize:CGSizeMake(wVal, 0)];
                animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if ( completed ) {
                        [proxy replaceValue:@([weakAnimSize.toValue CGSizeValue].width) forKey:@"width" notification:NO];
                    }
                };
                DECAY_POP_ATTR( animSize );
                [proxy.view.layer pop_addAnimation:animSize forKey:@"DecayAnimationSize"];
                
            } else if ( ERR_DIMENSION == wVal &&
                        ERR_DIMENSION != hVal ) {
                
                animSize.velocity = [NSValue valueWithCGSize:CGSizeMake(0, hVal)];
                animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if ( completed ) {
                        [proxy replaceValue:@([weakAnimSize.toValue CGSizeValue].height) forKey:@"height" notification:NO];
                    }
                };
                DECAY_POP_ATTR( animSize );
                [proxy.view.layer pop_addAnimation:animSize forKey:@"DecayAnimationSize"];
                
            } else if ( ERR_DIMENSION != wVal &&
                        ERR_DIMENSION != hVal  ) {
                
                animSize.velocity = [NSValue valueWithCGSize:CGSizeMake(wVal, hVal)];
                animSize.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if ( completed ) {
                        [proxy replaceValue:@([weakAnimSize.toValue CGSizeValue].width) forKey:@"width" notification:NO];
                        [proxy replaceValue:@([weakAnimSize.toValue CGSizeValue].height) forKey:@"height" notification:NO];
                    }
                };
                DECAY_POP_ATTR( animSize );
                [proxy.view.layer pop_addAnimation:animSize forKey:@"DecayAnimationSize"];
                
            }
            
        }
        
    }
    
    if ( nil != opacity ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationOpacity"];
        POPDecayAnimation *animOpaticy = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        __weak POPDecayAnimation *weakAnimOpacity = animOpaticy;
        
        animOpaticy.velocity = @(opacity.floatValue);
        animOpaticy.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:weakAnimOpacity.toValue forKey:@"opacity"];
            }
        };
        DECAY_POP_ATTR( animOpaticy );
        
        [proxy.view.layer pop_addAnimation:animOpaticy forKey:@"DecayAnimationOpacity"];
        
    }
    
    if ( nil != borderWidth ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationBorderWidth"];
        POPDecayAnimation *animBorderWidth = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerBorderWidth];
        __weak POPDecayAnimation *weakAnimBorderWidth = animBorderWidth;
        
        animBorderWidth.velocity = @(borderWidth.floatValue);
        animBorderWidth.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if ( completed ) {
                [proxy setValue:weakAnimBorderWidth.toValue forKey:@"borderWidth"];
            }
        };
        DECAY_POP_ATTR( animBorderWidth );
        
        [proxy.view.layer pop_addAnimation:animBorderWidth forKey:@"DecayAnimationBorderWidth"];
        
    }
    
    if ( nil != borderRadius ) {
        
        [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationBorderRadius"];
        POPDecayAnimation *animBorderRadius = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerCornerRadius];
        __weak POPDecayAnimation *weakAnimBorderRadius = animBorderRadius;
        
        animBorderRadius.velocity = @(borderRadius.floatValue);
        animBorderRadius.completionBlock = ^(POPAnimation *anim, BOOL completed) {
            if (completed) {
                [proxy setValue:weakAnimBorderRadius.toValue forKey:@"borderRadius"];
            }
        };
        DECAY_POP_ATTR( animBorderRadius );
        
        [proxy.view.layer pop_addAnimation:animBorderRadius forKey:@"DecayAnimationBorderRadius"];
        
    }
    
    if ( nil != [properties objectForKey:@"rotate"] ) {
        
        id rotate = [properties objectForKey:@"rotate"];
        
        if ( [rotate isKindOfClass:[NSDictionary class]] ) {
            
            id rotateX = [rotate objectForKey:@"x"];
            id rotateY = [rotate objectForKey:@"y"];
            id rotateZ = [rotate objectForKey:@"z"];
            
            if ( nil != rotateX &&
                 nil == rotateY &&
                 nil == rotateZ ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationRotationX"];
                POPDecayAnimation *animRotationX = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerRotationX];
                
                animRotationX.velocity = @( degreesToRadians([rotateX doubleValue]) );
                animRotationX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animRotationX );
                
                [proxy.view.layer pop_addAnimation:animRotationX forKey:@"DecayAnimationRotationX"];
                
            } else if ( nil != rotateY &&
                        nil == rotateX &&
                        nil == rotateZ ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationRoationY"];
                POPDecayAnimation *animRotationY = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerRotationY];
                
                animRotationY.velocity = @( degreesToRadians([rotateY doubleValue]) );
                animRotationY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animRotationY );
                
                [proxy.view.layer pop_addAnimation:animRotationY forKey:@"DecayAnimationRoationY"];
                
            } else if ( nil != rotateZ &&
                        nil == rotateX &&
                        nil == rotateY ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationRotationZ"];
                POPDecayAnimation *animRotationZ = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerRotation];
                
                animRotationZ.velocity = @( degreesToRadians([rotateZ doubleValue]) );
                animRotationZ.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animRotationZ );
                
                [proxy.view.layer pop_addAnimation:animRotationZ forKey:@"DecayAnimationRotationZ"];
                
            } else {
                
                CGFloat rx = rotateX ? [rotateX doubleValue] : 0.f;
                CGFloat ry = rotateY ? [rotateY doubleValue] : 0.f;
                CGFloat rz = rotateZ ? [rotateZ doubleValue] : 0.f;
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationRotation3D"];
                POPDecayAnimation *animRotation3D = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerRotation3D];
                
                animRotation3D.velocity = [NSValue valueWithCGRect:CGRectMake( degreesToRadians(rx), degreesToRadians(ry), degreesToRadians(rz), /* placeholder with meaningless value. suggest support 3d vector. */-1)];
                animRotation3D.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animRotation3D );
                
                [proxy.view.layer pop_addAnimation:animRotation3D forKey:@"DecayAnimationRotation3D"];
                
            }
            
        }
        
    }
    
    if ( nil != [properties objectForKey:@"scale"] ) {
        
        id scale = [properties objectForKey:@"scale"];
        
        if ( [scale isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [scale objectForKey:@"x"] &&
                 nil == [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationScaleX"];
                POPDecayAnimation *animScaleX = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerScaleX];
                
                animScaleX.velocity = @( [[scale objectForKey:@"x"] floatValue] );
                animScaleX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animScaleX );
                
                [proxy.view.layer pop_addAnimation:animScaleX forKey:@"DecayAnimationScaleX"];
                
            } else if ( nil == [scale objectForKey:@"x"] &&
                        nil != [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationScaleY"];
                POPDecayAnimation *animScaleY = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerScaleY];
                
                animScaleY.velocity = @( [[scale objectForKey:@"y"] floatValue] );
                animScaleY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animScaleY );
                
                [proxy.view.layer pop_addAnimation:animScaleY forKey:@"DecayAnimationScaleY"];
                
            } else if ( nil != [scale objectForKey:@"x"] &&
                        nil != [scale objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationScaleXY"];
                POPDecayAnimation *animScaleXY = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
                
                animScaleXY.velocity = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[scale objectForKey:@"x"] floatValue],
                                                                            [[scale objectForKey:@"y"] floatValue]
                                                                            )];
                animScaleXY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animScaleXY );
                
                [proxy.view.layer pop_addAnimation:animScaleXY forKey:@"DecayAnimationScaleXY"];
                
            }
            
        }
        
    }
    
    if ( nil != [properties objectForKey:@"translate"] ) {
        
        id translate = [properties objectForKey:@"translate"];
        
        if ( [translate isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [translate objectForKey:@"x"] &&
                 nil == [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationTranslateX"];
                POPDecayAnimation *animTranslateX = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerTranslationX];
                
                animTranslateX.velocity = @( [[translate objectForKey:@"x"] floatValue] );
                animTranslateX.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animTranslateX );
                
                [proxy.view.layer pop_addAnimation:animTranslateX forKey:@"DecayAnimationTranslateX"];
                
            } else if ( nil == [translate objectForKey:@"x"] &&
                        nil != [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationTranslateY"];
                POPDecayAnimation *animTranslateY = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerTranslationY];
                
                animTranslateY.velocity = @( [[translate objectForKey:@"y"] floatValue] );
                animTranslateY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animTranslateY );
                
                [proxy.view.layer pop_addAnimation:animTranslateY forKey:@"DecayAnimationTranslateY"];
                    
            } else if ( nil != [translate objectForKey:@"x"] &&
                        nil != [translate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationTranslateXY"];
                POPDecayAnimation *animTranslateXY = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerTranslationXY];
                
                animTranslateXY.velocity = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[translate objectForKey:@"x"] floatValue],
                                                                            [[translate objectForKey:@"y"] floatValue]
                                                                            )];
                animTranslateXY.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animTranslateXY );
                
                [proxy.view.layer pop_addAnimation:animTranslateXY forKey:@"DecayAnimationTranslateXY"];
                
            }
            
            if ( nil != [translate objectForKey:@"z"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationTranslateZ"];
                POPDecayAnimation *animTranslateZ = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerTranslationZ];
                
                // set transform perspective
                CATransform3D matrix = proxy.view.layer.transform;
                if ( !matrix.m34 ) {
                    matrix.m34 = 1.f / -1000.f;
                    proxy.view.layer.transform = matrix;
                }
                
                animTranslateZ.velocity = @( [[translate objectForKey:@"z"] floatValue] );
                animTranslateZ.completionBlock = ^(POPAnimation *anim, BOOL completed) {
                    if (completed) {
                        [proxy.view setTransform_:[[Ti3DMatrix alloc] initWithMatrix:proxy.view.layer.transform]];
                    }
                };
                DECAY_POP_ATTR( animTranslateZ );
                
                [proxy.view.layer pop_addAnimation:animTranslateZ forKey:@"DecayAnimationTranslateZ"];
                
            }
            
        }
        
    }
    
    if ( nil != proxy.view.layer.sublayers[0] &&
         [proxy.view.layer.sublayers[0] isKindOfClass:[CAShapeLayer class]] ) {
    
        if ( nil != strokeStart ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"DecayAnimationStrokeStart"];
            
            POPDecayAnimation *animStrokeStart = [POPDecayAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeStart];
            animStrokeStart.toValue = @(strokeStart.floatValue);
            DECAY_POP_ATTR( animStrokeStart );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animStrokeStart forKey:@"DecayAnimationStrokeStart"];
            
        }
        
        if ( nil != strokeEnd ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"DecayAnimationStrokeEnd"];
            
            POPDecayAnimation *animStrokeEnd = [POPDecayAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
            animStrokeEnd.toValue = @(strokeEnd.floatValue);
            DECAY_POP_ATTR( animStrokeEnd );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animStrokeEnd forKey:@"DecayAnimationStrokeEnd"];
            
        }
        
        if ( nil != lineWidth ) {
            
            [proxy.view.layer.sublayers[0] pop_removeAnimationForKey:@"DecayAnimationLineWidth"];
            
            POPDecayAnimation *animLineWidth = [POPDecayAnimation animationWithPropertyNamed:kPOPShapeLayerLineWidth];
            animLineWidth.toValue = @(lineWidth.floatValue);
            DECAY_POP_ATTR( animLineWidth );
            
            [proxy.view.layer.sublayers[0] pop_addAnimation:animLineWidth forKey:@"DecayAnimationLineWidth"];
            
        }
        
    }
    
//    if ( nil != [properties objectForKey:@"center"] ) {
//        
//        id center = [properties objectForKey:@"center"];
//        
//        if ( [center isKindOfClass:[NSDictionary class]] ) {
//            
//            TiDimension centerX = [TiUtils dimensionValue:@"x" properties:center def:TiDimensionUndefined];
//            TiDimension centerY = [TiUtils dimensionValue:@"y" properties:center def:TiDimensionUndefined];
//            
//            if ( !TiDimensionIsUndefined(centerX) &&
//                 !TiDimensionIsUndefined(centerY) ) {
//                
//                CGFloat centerXVal = [self calcTiDimensionValue:centerX withKey:@"center.x" andProxy:proxy isDecay:YES];
//                CGFloat centerYVal = [self calcTiDimensionValue:centerY withKey:@"center.y" andProxy:proxy isDecay:YES];
//                
//                if ( centerXVal != ERR_DIMENSION && centerYVal != ERR_DIMENSION ) {
//                    
//                    [proxy.view pop_removeAnimationForKey:@"DecayAnimationCenter"];
//                    POPDecayAnimation *animCenter = [POPDecayAnimation animationWithPropertyNamed:kPOPViewCenter];
//                    __weak POPDecayAnimation *weakAnimCenter = animCenter;
//                    
//                    animCenter.velocity = [NSValue valueWithCGPoint:CGPointMake(centerXVal, centerYVal)];
                //XXX: setCenter would make our view moving back to the original position. need more debugs.
//                    animCenter.completionBlock = ^(POPAnimation *anim, BOOL completed) {
//                        if ( completed ) {
//                            NSDictionary *c = [[NSDictionary alloc] initWithObjects:@[@([weakAnimCenter.toValue CGPointValue].x), @([weakAnimCenter.toValue CGPointValue].y)] forKeys:@[@"x", @"y"]];
//                            [proxy setCenter:c];
//                        }
//                    };
//                    DECAY_POP_ATTR( animCenter );
//                    
//                    [proxy.view pop_addAnimation:animCenter forKey:@"DecayAnimationCenter"];
//                    
//                }
//            }
//        }
//    }
    
    if ( nil != shadowOpacity ) {
        
        [proxy.view.shadowLayer pop_removeAnimationForKey:@"DecayAnimationShadowOpacity"];
        POPDecayAnimation *animShadowOpacity = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerShadowOpacity];
        
        animShadowOpacity.velocity = @(shadowOpacity.floatValue);
        
//        animShadowOpacity.completionBlock = ^(POPAnimation *anim, BOOL completed) {
//            if (completed) {
//                [proxy setValue:shadowColor forKey:@"viewShadowOpacity"];
//            }
//        };
        
        DECAY_POP_ATTR( animShadowOpacity );
        [proxy.view.shadowLayer pop_addAnimation:animShadowOpacity forKey:@"DecayAnimationShadowOpacity"];
        
    }
    
    if ( nil != [properties objectForKey:@"subTranslate"] ) {
        
        id subTranslate = [properties objectForKey:@"subTranslate"];
        
        if ( [subTranslate isKindOfClass:[NSDictionary class]] ) {
            
            if ( nil != [subTranslate objectForKey:@"x"] &&
                 nil == [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationSubTranslateX"];
                POPDecayAnimation *animSubTranslateX = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerSubtranslationX];
                animSubTranslateX.velocity = @( [[subTranslate objectForKey:@"x"] floatValue] );
                DECAY_POP_ATTR( animSubTranslateX );
                [proxy.view.layer pop_addAnimation:animSubTranslateX forKey:@"DecayAnimationSubTranslateX"];
                
            } else if ( nil == [subTranslate objectForKey:@"x"] &&
                        nil != [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationSubTranslateY"];
                POPDecayAnimation *animSubTranslateY = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerSubtranslationY];
                animSubTranslateY.velocity = @( [[subTranslate objectForKey:@"y"] floatValue] );
                DECAY_POP_ATTR( animSubTranslateY );
                [proxy.view.layer pop_addAnimation:animSubTranslateY forKey:@"DecayAnimationSubTranslateY"];
                
            } else if ( nil != [subTranslate objectForKey:@"x"] &&
                        nil != [subTranslate objectForKey:@"y"] ) {
                
                [proxy.view.layer pop_removeAnimationForKey:@"DecayAnimationSubTranslateXY"];
                POPDecayAnimation *animSubTranslateXY = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerSubtranslationY];
                animSubTranslateXY.velocity = [NSValue valueWithCGPoint:CGPointMake(
                                                                            [[subTranslate objectForKey:@"x"] floatValue],
                                                                            [[subTranslate objectForKey:@"y"] floatValue]
                                                                            )];
                DECAY_POP_ATTR( animSubTranslateXY );
                [proxy.view.layer pop_addAnimation:animSubTranslateXY forKey:@"DecayAnimationSubTranslateXY"];
                
            }
            
//            if ( nil != [subTranslate objectForKey:@"z"] ) {
//                
//                POPDecayAnimation *animSubTranslateZ = [POPDecayAnimation animationWithPropertyNamed:kPOPLayerTranslationZ];
//                animSubTranslateZ.velocity = @( [[subTranslate objectForKey:@"z"] floatValue] );
//                DECAY_POP_ATTR( animSubTranslateZ );
//                
//                // set sublayers transform perspective
//                CATransform3D subMatrix = proxy.view.layer.sublayerTransform;
//                subMatrix.m34 = 1.f / -1000.f;
//                proxy.view.layer.sublayerTransform = subMatrix;
//                
//                [proxy.view.layer pop_addAnimation:animSubTranslateZ forKey:nil];
//                
//            }
            
        }
        
    }
    
}

-(void)clearAllAnimations:(TiViewProxy *)proxy {
    
    [proxy.view pop_removeAllAnimations];
    [proxy.view.layer pop_removeAllAnimations];
    [proxy.view.shadowLayer pop_removeAllAnimations];
    
    if ( [proxy.view isKindOfClass:[TiUILabel class]] ) {
        
        [[(TiUILabel *)proxy.view label] pop_removeAllAnimations];
        
    } else if ( [proxy.view isKindOfClass:[TiUIScrollView class]] ) {
        
        [[(TiUIScrollView *)proxy.view scrollView] pop_removeAllAnimations];
        
    }
    
}


#pragma mark - helpers

-(CAMediaTimingFunction *)ease:(NSString *)easing {
    
    if ( [easing isEqualToString:@"default"] ) {
        
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
    } else if ( [easing isEqualToString:@"linear"] ) {
        
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
    } else if ( [easing isEqualToString:@"easeIn"] ) {
        
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
    } else if ( [easing isEqualToString:@"easeOut"] ) {
        
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        
    } else if ( [easing isEqualToString:@"easeInOut"] ) {
        
        return [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
    } else {
        
        return [CAMediaTimingFunction functionWithExtendedFuncName:easing];
        
    }
    
}

-(CGFloat)calcTiDimensionValue:(TiDimension)dimension withKey:(NSString *)key andProxy:(TiViewProxy *)proxy isDecay:(BOOL)decay {
    
    CGFloat value = ERR_DIMENSION;
    
    switch (dimension.type) {
            
        case TiDimensionTypeDip: {
            
            value = dimension.value;
            break;
            
        }
            
        case TiDimensionTypePercent: {
            
            if ( decay ) break;
            
            if ( [[key lowercaseString] isEqualToString:@"left"] ||
                 [[key lowercaseString] isEqualToString:@"width"] ||
                 [[key lowercaseString] isEqualToString:@"center.x"]) {
                
                if ( proxy.parent ) value = roundf( dimension.value * proxy.parent.view.bounds.size.width );
                
            } else if ( [[key lowercaseString] isEqualToString:@"top"] ||
                        [[key lowercaseString] isEqualToString:@"height"] ||
                        [[key lowercaseString] isEqualToString:@"center.y"]) {
                
                if ( proxy.parent ) value = roundf( dimension.value * proxy.parent.view.bounds.size.height );
                
            }
            
            break;
            
        }
            
        default: break;
            
    }
    
    return value;
    
}

// these 2 calculators are borrowed from LayoutConstraint.
-(CGSize)recalcSizeConstraint:(TiViewProxy *)proxy {
    
    CGSize referenceSize = ( nil != proxy.parent ) ? proxy.parent.view.bounds.size : proxy.view.bounds.size;
    
    sizeCache.size = SizeConstraintViewWithSizeAddingResizing(layoutConstraint, proxy.view, referenceSize, &autoresizeCache);
    
    return sizeCache.size;
}

-(CGPoint)recalcPositionConstraint:(TiViewProxy *)proxy {
    
    CGSize referenceSize = ( nil != proxy.parent ) ? proxy.parent.view.bounds.size : proxy.view.bounds.size;
    sizeCache.size = [self recalcSizeConstraint:proxy];
    
    positionCache = PositionConstraintGivenSizeBoundsAddingResizing(layoutConstraint, proxy, sizeCache.size,
                                                                    [proxy.view.layer anchorPoint], referenceSize, proxy.view.bounds.size, &autoresizeCache);
    
    positionCache.x += sizeCache.origin.x + proxy.view.bounds.origin.x;
    positionCache.y += sizeCache.origin.y + proxy.view.bounds.origin.y;
    
    return positionCache;
    
}

-(void)recalcConstraint: (TiViewProxy *)proxy
                  width: (TiDimension)width
                 height: (TiDimension)height
                   left: (TiDimension)left
                    top: (TiDimension)top
                 center: (id)center {
    
    TiDimension centerX = TiDimensionUndefined;
    TiDimension centerY = TiDimensionUndefined;
    
    if ( nil != center && [center isKindOfClass:[NSDictionary class]] ) {
            
        centerX = [TiUtils dimensionValue:@"x" properties:center def:TiDimensionUndefined];
        centerY = [TiUtils dimensionValue:@"y" properties:center def:TiDimensionUndefined];
        
    }
    
    if ( !TiDimensionIsUndefined(width) ) layoutConstraint->width = width;
    if ( !TiDimensionIsUndefined(height) ) layoutConstraint->height = height;
    if ( !TiDimensionIsUndefined(left) ) layoutConstraint->left = left;
    if ( !TiDimensionIsUndefined(top) ) layoutConstraint->top = top;
    if ( !TiDimensionIsUndefined(centerX) ) layoutConstraint->centerX = centerX;
    if ( !TiDimensionIsUndefined(centerY) ) layoutConstraint->centerY = centerY;
    
    frameCache.size = [self recalcSizeConstraint:proxy];
    frameCache.origin = [self recalcPositionConstraint:proxy];
    
//    NSLog(@"frameCache is (%f, %f, %f, %f)", frameCache.origin.x, frameCache.origin.y, frameCache.size.width, frameCache.size.height);
    
}

#pragma mark - POPAnimation Delegates.


@end
