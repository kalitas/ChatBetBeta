//
//  CBAppDelegate.m
//  chatBet
//
//  Created by dan g / applicaster on 9/5/14.
//  Copyright (c) 2014 chat bet ltd. All rights reserved.
//

#import "CBAppDelegate.h"
#import "CBViewController.h"
#import "CBTournamentTypeViewController.h"

@implementation CBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UINavigationController *nc = (UINavigationController *)self.window.rootViewController;
    
    nc.navigationBar.barStyle = UIBarStyleBlack;

    if (launchOptions != nil)
    {
        
        // Launch dictionary has data
        NSURL* launchURL = [launchOptions objectForKey: UIApplicationLaunchOptionsURLKey];
        self.urlOpened = YES;
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
    self.urlOpened = YES;
    UINavigationController *nc = (UINavigationController *)self.window.rootViewController;
    if ([nc.visibleViewController isKindOfClass:[CBViewController class]])
    {
        CBViewController *vc  = nc.visibleViewController;
        [vc.buttomButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else if ([nc.visibleViewController isKindOfClass:[CBTournamentTypeViewController class]])
    {
        CBTournamentTypeViewController *vc = nc.visibleViewController;
        [vc.buttomFriends sendActionsForControlEvents:UIControlEventTouchUpInside];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
