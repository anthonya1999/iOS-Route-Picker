//
//  ViewController.m
//  RouteTest
//
//  Created by Anthony Agatiello on 8/8/17.
//  Copyright © 2017 Anthony Agatiello. All rights reserved.
//

#import "ViewController.h"
#include <dlfcn.h>

@import ObjectiveC;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    void *MediaPlayer = dlopen("/System/Library/Frameworks/MediaPlayer.framework/MediaPlayer", RTLD_NOW);
    NSParameterAssert(MediaPlayer);
    
    Class MPAVRoutingController = objc_getClass("MPAVRoutingController");
    NSParameterAssert(MPAVRoutingController);
    self.routingController = [[MPAVRoutingController alloc] init];
    NSParameterAssert(self.routingController);
    
    [self.routingController setValue:self forKey:@"delegate"];
    [self.routingController setValue:@2 forKey:@"discoveryMode"]; /* DiscoveryMode_Detailed */
    
    /* dlclose(MediaPlayer); */
}

- (void)routingControllerAvailableRoutesDidChange:(NSObject *)routingController {
    NSLog(@"Available routes did change...");
    
    [self.routingController clearCachedRoutes];
    [self.routingController fetchAvailableRoutesWithCompletionHandler:^(NSArray *routes) {
        NSLog(@"Available routes: %@", routes);
        
        for (NSObject *route in routes) {
            if ([[route valueForKey:@"routeName"] isEqualToString:kAirPlayRouterName]) {
                NSLog(@"Calling function to pick route...");
                BOOL routePicked = [[route valueForKey:@"picked"] boolValue];
                if (!routePicked) {
                    BOOL pickRoute = [routingController pickRoute:route withPassword:nil];
                    if (pickRoute == YES) {
                        NSLog(@"pickRoute:withPassword: returned with success!");
                    }
                    else {
                        NSLog(@"pickRoute:withPassword: returned with failure!");
                    }
                }
                else {
                    NSLog(@"Route has been selected successfully!");
                }
            }
        }
    }];
}

@end
