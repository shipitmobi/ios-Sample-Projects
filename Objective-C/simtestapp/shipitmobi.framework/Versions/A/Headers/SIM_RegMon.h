//
//  SIM_RegMon.h
//  shipitmobi
//
//  Created by gaurav dwivedi on 01/01/17.
//  Copyright © 2017 Karmatics. All rights reserved.
//


#ifndef SIM_RegMon_h
#define SIM_RegMon_h

#import <MapKit/MapKit.h>
#import "shipitmobi.h"

@interface SIM_RegMon : NSObject <MKAnnotation, CLLocationManagerDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) CLLocationManager* SIM_LocManager;

@property (atomic, retain, strong) CLLocation *currentLoc;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@property (nonatomic, readwrite) CLLocationDistance radius;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain, strong) NSString *subtitle;

+ (SIM_RegMon *)regMon;
+ (void) SIM_showMessage :(NSString *)mainTitle :(NSString *)message :(id)delegate :(NSString *)CancelBtnTitle :(NSString *)otherBtnTitle;
- (BOOL) SIM_ChkRegMonPermissn;
- (void) SIM_HandleNewFence:(NSDictionary *)userInfo;
- (void) SIM_AddMonitoringRegion:(CLRegion *)addRegion;
@end


#endif /* SIM_RegMon_h */

