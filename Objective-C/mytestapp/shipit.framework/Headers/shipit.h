//
//  shipit.h
//  shipit
//
//  Created by gaurav dwivedi on 12/3/15.
//  Copyright © 2015 kickboard. All rights reserved.
//

//#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <AddressBook/AddressBook.h>
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
#import "shipitNotificationArtist.h"
#import "shipitRegMon.h"
#import "SIM_InAppArtist.h"


#define SHIPIT_DEBUG 1
#define SHIPIT_TEST_SRVR 1
/*   SHIPIT Constants */
#ifdef SHIPIT_TEST_SRVR
#define SERVERP_REG                                 @"http://alterapi.shipit.mobi/RestApi/registerDevice"
#define SERVERP_TAG                                 @"http://alterapi.shipit.mobi/RestApi/setTags"
#define SERVERP_STATS                               @"http://alterapi.shipit.mobi/RestApi/updateAppStats"
#define SERVERP_TEST                                @"http://alterapi.shipit.mobi/RestApi/testDeviceRemote"
#else
#define SERVERP_REG                                 @"http://api.shipit.mobi/RestApi/registerDevice"
#define SERVERP_TAG                                 @"http://api.shipit.mobi/RestApi/setTags"
#define SERVERP_STATS                               @"http://api.shipit.mobi/RestApi/updateAppStats"
#define SERVERP_TEST                                @"http://api.shipit.mobi/RestApi/testDeviceRemote"
#endif

#define SHIPIT_DICT_CFG                             @"shipitCfg"
#define SHIPIT_DICT_TAGS                            @"shipitTags"
#define SHIPIT_DICT_STATS                           @"shipitStats"
#define SHIPIT_DICT_REGMON                          @"shipitRegMon"
#define SHIPIT_MAX_FENCE                            20

#define STATS_APP_OPEN_ALL_CNT                      @"app_all_open"         //"App Open Instances Count";
#define STATS_MSG_ONLY_OPEN_CNT                     @"msg_only_open"        //"Msg Open Instances Count";
#define STATS_ALL_MSG_CNT                           @"msg_all_rcvd"         //"All Received Instances Count";
#define STATS_LAST_UPDT_TIME                        @"last_updt_time"       // Last time the stats was updated.
#define STATS_IN_APP_TIME                           @"in_app_time"          // Last time the stats was updated.
#define STATS_SEND_INTERVAL                         10//1440                // Time interval in minutes

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SHIPIT_VERSION @"1.0.0"

#define isEqualStrCaseIgnore(string1, string2) ([string1 caseInsensitiveCompare:string2] == NSOrderedSame)

#ifdef SHIPIT_DEBUG
#define SIMLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DebugLog( s, ... )
#endif

@protocol shipitDelegate <NSObject>
@optional
@end


@interface shipit : NSObject

@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, strong)NSString *deviceToken;
@property (nonatomic, weak) id<shipitDelegate> delegate;
@property (nonatomic, assign, getter=SIM_isAutoSetupEn) Boolean enAutoSetup;
+ (void)shipitSendRequest;
+ (void) SIM_BkDoorMsg:(NSDictionary *)userInfo;




/**
 * Get the shared shipit instance
 */
+ (shipit *)docker;
/* handle push when app is not running */
- (void) shipitSetLaunch:(NSDictionary *)launchOptions;
/* Handle push when app is running in background/forground */
- (void) shipitRegisterDeviceToken:(NSData *)deviceToken;
// TBD: Fina a way to hide this
+ (void) updateNotifStats:(NSString *)event incrementedWith:(int)inc forMsgID:(NSString *)msgID;
/* Handle anyicoming notification data (while app is open)*/
- (void) shipitRcvdNotification:(NSDictionary *)userInfo;
- (void) shipitRcvdNotification:(NSDictionary *)userInfo :(UIApplicationState)appState fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void) shipitRcvdActionWithIdentifier:(NSString *)identifier :(NSDictionary *)userInfo :(UIApplicationState)appState completionHandler:(void (^)())handler;
/* APIs for TAG Operations */
+ (void) shipitSetTags: (NSDictionary *)tags;
+ (void) shipitDelTags:(NSArray *)tags;
+ (NSArray *) shipitGetTags;

/* APIs for App Activity State Tracking */
+ (void) shipitWillEnterForeground:(UIApplication *)application;
+ (void) shipitDidBecomeActive:(UIApplication *)application;
+ (void) shipitDidEnterBackground:(UIApplication *)application;
- (NSString *) shipitGetTagVal: (NSString* )tagName;

@end
