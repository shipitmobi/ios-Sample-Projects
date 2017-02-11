//
//  statsTableViewController.m
//  mytestapp
//
//  Created by gaurav dwivedi on 1/23/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import "statsTableViewController.h"

@interface statsTableViewController ()

@end

@implementation statsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchStatsData];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.tableView.tableFooterView = [UIView new];
    
}


- (void)refresh:(UIRefreshControl *)refreshControl {
    [self fetchStatsData];
    [refreshControl endRefreshing];
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
   // NSLog(@" Inside %s", __FUNCTION__);
   // NSLog(@"Number of rows %lu", (unsigned long)[self.statsListArrayNames count]);
    return [self.statsListArrayNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@" Inside %s", __FUNCTION__);
    NSString *ident = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    
   // NSLog(@"Calling for section %ld and Index %ld \n", (long)indexPath.section, (long)indexPath.row);
    
    
    // Configure the cell...
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ident];
    }
    

        cell.textLabel.text = self.statsListArrayNames[indexPath.row];
        cell.detailTextLabel.text = self.statsListArrayVals[indexPath.row];;
    
    return cell;
}

- (void) fetchStatsData {
    if (!self.statsListArrayNames)
        self.statsListArrayNames = [[NSMutableArray alloc] init];
    if (!self.statsListArrayVals)
        self.statsListArrayVals = [[NSMutableArray alloc] init];
    
    [self.statsListArrayNames removeAllObjects];
    [self.statsListArrayVals removeAllObjects];

    
    NSMutableDictionary* shipitStats = [[[NSUserDefaults standardUserDefaults] objectForKey:SHIPIT_DICT_STATS]mutableCopy];
    if (shipitStats) {
        
        NSString* APP_OPEN_CNT = [shipitStats[STATS_APP_OPEN_ALL_CNT] stringValue];
        NSString* MSG_OPEN_CNT = [shipitStats [STATS_MSG_ONLY_OPEN_CNT] stringValue];
        NSString* ALL_MSG_CNT = [shipitStats[STATS_ALL_MSG_CNT] stringValue];
        NSString *inAppTime =  [shipitStats[STATS_IN_APP_TIME] stringValue];
        NSDate *lastTime = shipitStats[STATS_LAST_UPDT_TIME];
        
        NSTimeInterval timeElapsed = [[NSDate date] timeIntervalSinceDate:lastTime]; // In seconds
        timeElapsed = timeElapsed/60;   // Time elapsed in minutes
        NSString *intervalString = [NSString stringWithFormat:@"%f", timeElapsed];
        if (timeElapsed > STATS_SEND_INTERVAL)
            NSLog(@" Time elapsed since last server update is : %d mins ", (int)timeElapsed);
        
        
        [self.statsListArrayNames addObject:@"App Open Count :"];
        [self.statsListArrayNames addObject:@"Message Open Count :"];
        [self.statsListArrayNames addObject:@"Message Received Count :"];
        [self.statsListArrayNames addObject:@"In App Time Spent :"];
        [self.statsListArrayNames addObject:@"Elapsed Time Since last server update(Mins) :"];
        
        if (!inAppTime)
            inAppTime = @"Not Available Yet!!!!";
        
        [self.statsListArrayVals addObject:APP_OPEN_CNT];
        [self.statsListArrayVals addObject:MSG_OPEN_CNT];
        [self.statsListArrayVals addObject:ALL_MSG_CNT];
        [self.statsListArrayVals addObject:inAppTime];
        [self.statsListArrayVals addObject:intervalString];
    }
    
     [self.tableView reloadData];

    return;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return @"Shipit Stats Information";
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
