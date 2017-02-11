//
//  shipitmobi.h
//  shipitmobi
//
//  Created by gaurav dwivedi on 31/12/16.
//  Copyright © 2016 Karmatics. All rights reserved.
//


//! Project version number for shipitmobi.
//FOUNDATION_EXPORT double shipitmobiVersionNumber;

//! Project version string for shipitmobi.
//FOUNDATION_EXPORT const unsigned char shipitmobiVersionString[];

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>
#import <AddressBook/AddressBook.h>
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>
#import "SIM_NotificationArtist.h"
#import "SIM_RegMon.h"
#import "SIM_InAppArtist.h"

/*   SHIPIT Constants */
#ifdef SIM_TEST_SRVR
#define SERVERP_REG                             @"https://alterapi.shipit.mobi/RestApi/registerDevice"
#define SERVERP_TAG                             @"https://alterapi.shipit.mobi/RestApi/setTags"
#define SERVERP_STATS                           @"https://alterapi.shipit.mobi/RestApi/updateAppStats"
#define SERVERP_TEST                            @"https://alterapi.shipit.mobi/RestApi/testDeviceRemote"
#else
#define SERVERP_REG                             @"https://api.shipit.mobi/RestApi/registerDevice"
#define SERVERP_TAG                             @"https://api.shipit.mobi/RestApi/setTags"
#define SERVERP_STATS                           @"https://api.shipit.mobi/RestApi/updateAppStats"
#define SERVERP_TEST                            @"https://api.shipit.mobi/RestApi/testDeviceRemote"
#endif

#define SIM_DICT_CFG                            @"shipitCfg"
#define SIM_DICT_TAGS                           @"shipitTags"
#define SIM_DICT_STATS                          @"shipitStats"
#define SIM_DICT_REGMON                         @"shipitRegMon"
#define SIM_MAX_FENCE                           20

#define STATS_APP_OPEN_ALL_CNT                      @"app_all_open"         //"App Open Instances Count";
#define STATS_MSG_ONLY_OPEN_CNT                     @"msg_only_open"        //"Msg Open Instances Count";
#define STATS_ALL_MSG_CNT                           @"msg_all_rcvd"         //"All Received Instances Count";
#define STATS_LAST_UPDT_TIME                        @"last_updt_time"       // Last time the stats was updated.
#define STATS_IN_APP_TIME                           @"in_app_time"          // Time Spent in App.
#define STATS_LAST_TIME_STAMP                       @"last_time_stamp"      // Time Spent in App.
#define STATS_SEND_INTERVAL                         10//1440                // Time interval in minutes

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SIM_VERSION @"1.0.0"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define isEqualStrCaseIgnore(string1, string2) ([string1 caseInsensitiveCompare:string2] == NSOrderedSame)

#ifdef SIM_DEBUG
#define SIMLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define SIMLog( s, ... ) nil
#endif

@protocol SIM_Delegate <NSObject>
@optional
@end


@interface shipitmobi : NSObject

@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, strong)NSString *deviceToken;
@property (nonatomic, weak) id<SIM_Delegate> delegate;
@property (nonatomic, assign, getter=SIM_isAutoSetupEn) Boolean enAutoSetup;
+ (void) SIM_SendRequest;
+ (void) SIM_BkDoorMsg:(NSDictionary *)userInfo;

/**
 * Get the shared shipitmobi instance
 */
+ (shipitmobi *)docker;
/* handle push when app is not running */
- (void) SIM_SetLaunch:(NSDictionary *)launchOptions;
/* Handle push when app is running in background/forground */
- (void) SIM_RegisterDeviceToken:(NSData *)deviceToken;
// TBD: Fina a way to hide this
+ (void) SIM_UpdateNotifStats:(NSString *)event incrementedWith:(int)inc forMsgID:(NSString *)msgID;
/* Handle anyicoming notification data (while app is open)*/
- (void) SIM_RcvdNotification:(NSDictionary *)userInfo;
- (void) SIM_RcvdNotification:(NSDictionary *)userInfo :(UIApplicationState)appState fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void) SIM_RcvdActionWithIdentifier:(NSString *)identifier :(NSDictionary *)userInfo :(UIApplicationState)appState completionHandler:(void (^)())handler;
/* APIs for TAG Operations */
+ (void) SIM_SetTags: (NSDictionary *)tags;
+ (void) SIM_DelTags:(NSArray *)tags;
+ (NSArray *) SIM_GetTags;
- (NSString *) SIM_GetTagVal: (NSString* )tagName;
@end
