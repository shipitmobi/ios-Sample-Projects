//
//  AppDelegate.m
//  mytestapp
//
//  Created by gaurav dwivedi on 12/5/15.
//  Copyright © 2015 kickboard. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[shipit docker] shipitSetLaunch:launchOptions];
    //[[shipit docker] startConv];
    UIViewController *myController = [UIApplication sharedApplication].keyWindow.rootViewController;

    
    
    NSLog(@"CHK 30!!!");
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:myController];
    
    [self.window makeKeyAndVisible];
    //[self.window addSubview:navController.view];
    return YES;
}

/*

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)token
{
    [[shipit docker] shipitRegisterDeviceToken:token];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Registering Notification failed with Error :: %@", [err userInfo]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
   [[shipit docker] shipitRcvdNotification: userInfo];
}
    

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"Application received remote notification: %@", userInfo);
    [[shipit docker] shipitRcvdNotification:userInfo :application.applicationState   fetchCompletionHandler:completionHandler];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())handler {
    NSLog(@"Received remote notification button interaction: %@ notification: %@", identifier, userInfo);
    [[shipit docker] shipitRcvdActionWithIdentifier:identifier :userInfo :application.applicationState  completionHandler:(void (^)())handler];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [shipit shipitDidEnterBackground:(UIApplication *)application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [shipit shipitWillEnterForeground:(UIApplication *)application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [shipit shipitDidBecomeActive:(UIApplication *)application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
 
 */

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)notification completionHandler:(void(^)())completionHandler {
    NSString *category = notification[@"aps"][@"category"];
    NSLog(@"%s \n", __PRETTY_FUNCTION__);
    NSLog(@"Category received is %@", category);
    
    if ([category isEqualToString:@"SIM_categ_02"]) {
        if ([identifier isEqualToString:@"SIM_ACT1"]) {
            //do something
            NSLog(@"Action Button Clicked is SIM_ACT1 \n");
        }
        else if ([identifier isEqualToString:@"SIM_ACT2"]) {
            //do something else
            NSLog(@"Action Button Clicked is SIM_ACT2 \n");
        } else if ([identifier isEqualToString:@"SIM_ACT3"]) {
            //do something else
            NSLog(@"Action Button Clicked is SIM_ACT3 \n");
        }
    }
    else {
        //handle other category
    }
    
    //must be called when finished
    completionHandler();
}

// Extra Methods to be added for Vanilla style push Notification handling
// TBD: remove this ionce we have proxy delegate running....
//==========================================================================

#pragma mark PUSH NOTIFICATION


- (void) requestTagActivity
{
    NSString *dateString = @"22-Dec-15";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MMM-yy";
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSDictionary *tags = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"India",@"Country",
                          @"false",@"Working",
                          nil];
    
    [shipit shipitSetTags:tags];
    NSArray *delTags = [NSArray arrayWithObjects: @"Country", @"Gaurav", nil];
    [shipit shipitDelTags:delTags];
    
    tags = [NSDictionary dictionaryWithObjectsAndKeys:
            @"India",@"Country",
            @"false",@"Working",
            @"India", @"Alias",
            @123456, @"FavNumber",
            @156745, @"price",
            @"true", @"isAdult",
            date, @"MyDate",
            [NSArray arrayWithObjects:@"Item1", @"Item2", @"Item3", nil], @"MyList",
            nil];
    [shipit shipitSetTags:tags];
    delTags = [NSArray arrayWithObjects: @"Country", @"Working", nil];
    
    [shipit shipitDelTags:delTags];
    
    NSArray *tagList = [shipit shipitGetTags];
    NSLog(@"%@",tagList);
    return;
}


//===========================================================================
@end
