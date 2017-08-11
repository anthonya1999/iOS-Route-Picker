//
//  ViewController.h
//  RouteTest
//
//  Created by Anthony Agatiello on 8/8/17.
//  Copyright © 2017 Anthony Agatiello. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kAirPlayRouterName = @"Apple TV";

@interface ViewController : UIViewController

@property (strong, nonatomic) NSObject *routingController;

@end

@interface NSObject (MPAVRoutingController)

- (void)clearCachedRoutes;
- (void)fetchAvailableRoutesWithCompletionHandler:(void(^)(NSArray *routes))completion;
- (BOOL)pickRoute:(id)arg1 withPassword:(id)arg2;

@end
