//
//  shipitTableViewController.m
//  mytestapp
//
//  Created by gaurav dwivedi on 1/15/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import "shipitTableViewController.h"

@interface shipitTableViewController ()

@end

@implementation shipitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (self.locMan == nil)
    {
        shipitRegMon *rm = [shipitRegMon regMon];
        if (rm == nil)
            NSLog(@"cannot get shipit Region Monitor");
        else
            self.locMan = rm.shipitLocManager;
        
        if (self.locMan == nil)
            NSLog(@"cannot get location manager");
        else
            NSLog(@" Location Manager is %@, count = %lu", self.locMan.description, (unsigned long)[self.locMan monitoredRegions].count);
    }
    
    if (!self.regListArray)
        self.regListArray = [[NSMutableArray alloc] init];
    
    [self.regListArray removeAllObjects];

    for (CLRegion *onReg in [self.locMan monitoredRegions])
        [self.regListArray addObject:onReg.identifier];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.regListArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"cellIdentifier";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
    
    // Configure the cell...
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    UIImage* img = [UIImage imageNamed:@"del.png"];
    
    //NSLog(@" Cell Matter is %@", self.regListArray[indexPath.row]);
    cell.textLabel.text = self.regListArray[indexPath.row];
    cell.imageView.image = img;
    cell.imageView.tag = indexPath.row;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClk:)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    [cell.imageView addGestureRecognizer:tap];
    [cell.imageView setUserInteractionEnabled:YES];
    return cell;
}

-(void)imgClk :(id) sender
{
    UITapGestureRecognizer *gesture = (UITapGestureRecognizer *) sender;
    //NSLog(@"Tag = %ld", gesture.view.tag);
    NSUInteger num = gesture.view.tag;
    NSMutableString *identi = [self.regListArray objectAtIndex:num];
    //NSLog(@"TAG Value is %@", identi);
    for (CLRegion *onReg in [self.locMan monitoredRegions]) {
        if ([onReg.identifier isEqualToString:identi]) {
            [self.locMan stopMonitoringForRegion:onReg];
            [self.regListArray removeObjectAtIndex:num];
             NSLog(@"Removing the Geo Fence for : %@ \n", identi);
        }
        
    }
    [self.tableView reloadData];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
