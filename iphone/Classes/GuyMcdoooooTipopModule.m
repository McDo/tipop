/**
 * tipop
 *
 * Created by Do(mcdooooo@gmail.com)
 * Copyright (c) 2014 Do Lin. All rights reserved.
 */

#import "GuyMcdoooooTipopModule.h"

@implementation GuyMcdoooooTipopModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"0412dcd0-44be-4688-ab58-4529dcf45b11";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"guy.mcdooooo.tipop";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];

    popAnimator = [[FBPOPAnimator alloc] init];
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably

	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup
/* tipop fix: remove dealloc.
-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}
*/

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

-(void)basic:(id)args {
    
    TiViewProxy* proxy = nil;
    NSDictionary* properties = nil;
    KrollCallback* callback = nil;
    
    ENSURE_ARG_AT_INDEX(proxy, args, 0, TiViewProxy);
    ENSURE_ARG_OR_NIL_AT_INDEX(properties, args, 1, NSDictionary);
    ENSURE_ARG_OR_NIL_AT_INDEX(callback, args, 2, KrollCallback);
    
    TiThreadPerformOnMainThread(^{
        [popAnimator basicAnimationWithProxy:proxy andProperties:properties completed:callback];
    }, NO);
    
}

-(void)spring:(id)args {
    
    TiViewProxy* proxy = nil;
    NSDictionary* properties = nil;
    KrollCallback* callback = nil;
    
    ENSURE_ARG_AT_INDEX(proxy, args, 0, TiViewProxy);
    ENSURE_ARG_OR_NIL_AT_INDEX(properties, args, 1, NSDictionary);
    ENSURE_ARG_OR_NIL_AT_INDEX(callback, args, 2, KrollCallback);
    
    TiThreadPerformOnMainThread(^{
        [popAnimator springAnimationWithProxy:proxy andProperties:properties completed:callback];
    }, NO);
    
}

-(void)decay:(id)args {
    
    TiViewProxy* proxy = nil;
    NSDictionary* properties = nil;
    KrollCallback* callback = nil;
    
    ENSURE_ARG_AT_INDEX(proxy, args, 0, TiViewProxy);
    ENSURE_ARG_OR_NIL_AT_INDEX(properties, args, 1, NSDictionary);
    ENSURE_ARG_OR_NIL_AT_INDEX(callback, args, 2, KrollCallback);
    
    TiThreadPerformOnMainThread(^{
        [popAnimator decayAnimationWithProxy:proxy andProperties:properties completed:callback];
    }, NO);
    
}

-(instancetype)clear:(id)args {
    
    TiViewProxy* proxy = nil;
    ENSURE_ARG_AT_INDEX(proxy, args, 0, TiViewProxy);
    
    TiThreadPerformOnMainThread(^{
        [popAnimator clearAllAnimations:proxy];
    }, NO);
    
    return self;
    
}

@end
