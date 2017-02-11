//
//  SecondViewController.h
//  mytestapp
//
//  Created by gaurav dwivedi on 1/15/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "shipit.h"

@interface SecondViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *addFence;
@property (strong, atomic) shipitRegMon *regM;
@property (strong, nonatomic) IBOutlet UIPickerView *inputRadius;
@property (strong, nonatomic)          NSArray *radArray;
@property (strong, nonatomic) IBOutlet UILabel *selRadius;
@property (nonatomic) NSInteger dist;

@property CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UILabel *showLat;
@property (strong, nonatomic) IBOutlet UILabel *showLong;
@property (strong, nonatomic) IBOutlet UILabel *showAlt;
@property (strong, nonatomic) IBOutlet UILabel *showSpeed;
@property (strong, nonatomic) IBOutlet UITextField *msgTxt;

@end
