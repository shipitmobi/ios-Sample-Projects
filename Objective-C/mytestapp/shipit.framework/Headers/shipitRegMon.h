//
//  shipitRegMon.h
//  shipit
//
//  Created by gaurav dwivedi on 12/25/15.
//  Copyright Â© 2015 kickboard. All rights reserved.
//

#ifndef shipitRegMon_h
#define shipitRegMon_h

#import <MapKit/MapKit.h>
#import "shipit.h"

@interface shipitRegMon : NSObject <MKAnnotation, CLLocationManagerDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) CLLocationManager* shipitLocManager;

@property (atomic, retain, strong) CLLocation *currentLoc;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite) CLLocationDistance radius;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain, strong) NSString *subtitle;

+ (shipitRegMon *)regMon;
+ (void) showMessage :(NSString *)mainTitle :(NSString *)message :(id)delegate :(NSString *)CancelBtnTitle :(NSString *)otherBtnTitle;
- (BOOL) shipitChkRegMonPermissn;
- (void)shipitHandleNewFence:(NSDictionary *)userInfo;
- (void)addMonitoringRegion:(CLRegion *)addRegion;
@end


#endif /* shipitRegMon_h */