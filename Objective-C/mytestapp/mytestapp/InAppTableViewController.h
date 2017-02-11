//
//  InAppTableViewController.h
//  mytestapp
//
//  Created by gaurav dwivedi on 25/10/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#define EMJ_STEPS               @"\U0001F463"  //👣
#define EMJ_LAUGH               @"\U0001F604"  //😄
#define EMJ_FRWON               @"\U0001F463"  //☹️
#define EMJ_STEPS               @"\U0001F463"  //👣
#define EMJ_STEPS               @"\U0001F463"  //👣
#define EMJ_STEPS               @"\U0001F463"  //👣
#define EMJ_STEPS               @"\U0001F463"  //👣

#define NUM_INAPP 20

@interface InAppTableViewController : UITableViewController  <UITableViewDelegate, UITableViewDataSource>
@property (retain,  nonatomic) NSMutableArray *inAppList;
@end
