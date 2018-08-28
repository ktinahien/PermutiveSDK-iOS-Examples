//
//  AppDelegate.m
//  NewsMeUp
//
//  Created by Gregg Jaskiewicz on 15/05/2018.
//  Copyright © 2018 Permutive. All rights reserved.
//

#import "AppDelegate.h"
@import Permutive;
// Or use this, if you don't have modules enabled
//#import <Permutive/Permutive.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    NSUUID *projectId = [[NSUUID alloc] initWithUUIDString:@"8e47b735-a09c-4a78-9063-73148668cde6"];
    NSUUID *apiKey = [[NSUUID alloc] initWithUUIDString:@"45d033f0-b962-4bf8-83b1-067446d524b3"];
    PermutiveOptions *options = [PermutiveOptions optionsWithProjectId:projectId apiKey:apiKey];
    if (options != nil) {
        [Permutive configureWithOptions:options];
    } else {
        NSLog(@"configuration went wrong");
    }

//    [Permutive setIdentity:@"User"];

    id<PermutiveEventActionInterface> eventTracker = [[Permutive permutive] eventTracker];

    NSMutableDictionary *properties = [@{} mutableCopy];
    if (launchOptions != nil) {
        properties[@"launchOptions"] = launchOptions;
    }

    [eventTracker track:@"NewsMeUpFinishLaunching" properties:properties];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
