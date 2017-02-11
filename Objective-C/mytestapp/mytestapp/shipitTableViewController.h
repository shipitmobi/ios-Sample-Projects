//
//  shipitTableViewController.h
//  mytestapp
//
//  Created by gaurav dwivedi on 1/15/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "shipit.h"

@interface shipitTableViewController : UITableViewController
@property (retain,  nonatomic) NSMutableArray *regListArray;
@property (strong, nonatomic) CLLocationManager *locMan;

@end


