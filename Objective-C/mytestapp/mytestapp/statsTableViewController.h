//
//  statsTableViewController.h
//  mytestapp
//
//  Created by gaurav dwivedi on 1/23/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "shipit.h"

@interface statsTableViewController : UITableViewController
@property (retain,  nonatomic) NSMutableArray *statsListArrayNames;
@property (retain,  nonatomic) NSMutableArray *statsListArrayVals;
@end
