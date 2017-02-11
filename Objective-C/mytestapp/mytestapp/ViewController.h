//
//  ViewController.h
//  mytestapp
//
//  Created by gaurav dwivedi on 12/5/15.
//  Copyright © 2015 kickboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "shipit.h"


// Same as python source for emoji
#define EMJ_STEPS               @"\U0001F463"  //👣
#define EMJ_LAUGH               @"\U0001F604"  //😄
#define EMJ_FRWON               @"\U0001F463"  //☹️
#define EMJ_STEPS               @"\U0001F463"  //👣
#define EMJ_STEPS               @"\U0001F463"  //👣
#define EMJ_STEPS               @"\U0001F463"  //👣
#define EMJ_STEPS               @"\U0001F463"  //👣


@interface ViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate, CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UITextField *msgTxt;
//@property (strong, nonatomic) IBOutlet UITextField *radius;
@property (strong, nonatomic) IBOutlet UIButton *sendTxt;

-(void) addFenceBackDoor;

@end

