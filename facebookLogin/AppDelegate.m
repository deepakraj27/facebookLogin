//
//  AppDelegate.m
//  facebookLogin
//
//  Created by Deepakraj Murugesan on 12/10/15.
//  Copyright © 2015 tecsol. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate (){
    UIStoryboard *mainStoryboard;
    UIViewController *homeScreen;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"loginSuccess"]isEqualToString: @"facebookSuccess"])
    {
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                   bundle: nil];
        homeScreen = (UIViewController*)[mainStoryboard
                                         instantiateViewControllerWithIdentifier: @"Dashboard"];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController  = homeScreen;
        [self.window makeKeyAndVisible];
        
    }
    
    else {
        mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                   bundle: nil];
        homeScreen = (UIViewController*)[mainStoryboard
                                         instantiateViewControllerWithIdentifier: @"Home"];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController  = homeScreen;
        [self.window makeKeyAndVisible];
    }
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end