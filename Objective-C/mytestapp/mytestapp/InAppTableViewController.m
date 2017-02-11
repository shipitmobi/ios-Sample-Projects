//
//  InAppTableViewController.m
//  mytestapp
//
//  Created by gaurav dwivedi on 25/10/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import "InAppTableViewController.h"
#import "shipit.h"

#define IMG_9_16    @"http://images.parkrun.com/website/wallpapers/parkrun_Bird_9-16.png" // 9:16 image
#define IMG_16_9    @"http://webplantmedia.com/starter-themes/wordpresscanvas-structure1/wp-content/uploads/2014/04/16-9-dummy-image6.jpg" // 16:9 image

#define IMG_4_3     @"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Aspect_ratio_-_4x3.svg/2000px-Aspect_ratio_-_4x3.svg.png"    // 4:3 Image
#define IMG_3_4     @"http://digital-photography-school.com/wp-content/uploads/2013/02/2x3-portrait-diptych.jpg"

#define IMG_3_2     @"https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Aspect-ratio-3x2.svg/1280px-Aspect-ratio-3x2.svg.png"
#define IMG_2_3     @"https://webstyle.unicomm.fsu.edu/img/placeholders/ratio-2-3.png"
#define IMG_1_1     @"http://3.bp.blogspot.com/_5pqCqLjs8WA/TGmMutN5ISI/AAAAAAAAACw/rMgIXNxHSN8/s400/Aspect1x1.png"
/*
 //@"https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Aspect_ratio_-_4x3.svg/2000px-Aspect_ratio_-_4x3.svg.png"; // 4:3 Image

 //@"http://cdn.wallpapersafari.com/21/80/Aw1L9o.jpg";
 //@"http://i.bnet.com/blogs/vertical_farm_in_desert_chris_jacobs.jpg";
 //@"https://www.isubscribe.co.uk/_assets/shared/images/sale.png";

 */


@interface InAppTableViewController ()

@end



@implementation InAppTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableFooterView.backgroundColor = [UIColor redColor];
    

    
    // Initialize table data
    _inAppList = [[NSMutableArray alloc] init];
    for(int i = 0; i < NUM_INAPP; i++)
    {
        NSString *s = [NSString stringWithFormat:@"In App Notification %d", i];
        [_inAppList  addObject:s];
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_inAppList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"InAppTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [_inAppList objectAtIndex:indexPath.row];
    switch(indexPath.row)
    {
        case 0:
            cell.detailTextLabel.text = @"Scaled Image with Label Overlay and Max 3 Buttons";
            break;
        case 1:
            cell.detailTextLabel.text = @"Switch Control with Text Label";
            break;
        case 2:
            cell.detailTextLabel.text = @"Segmented Control with Text Label";
            break;
        case 3:
            cell.detailTextLabel.text = @"Modal with dynamic close button and overlay Label";
            break;
        case 4:
            cell.detailTextLabel.text = @"Image with Laebl and MsgTxt and One Button";
            break;

        case 10:
            cell.detailTextLabel.text = @"Middle Level IOS Type Notification with image";
            break;
        case 11:
            cell.detailTextLabel.text = @"Top Level IOS Type Notification with image";
            break;
        default:
            cell.detailTextLabel.text = @"InApp Notification for ShipitMobi Demo";
            break;
            
    }
    
    cell.imageView.image = [UIImage imageNamed:@"mainlogo"];
    
    return cell;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UIAlertView *messageAlert = [[UIAlertView alloc]
    //                             initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    // Display Alert Message
    //[messageAlert show];
    NSLog(@"Calling for section %ld and Index %ld \n", (long)indexPath.section, (long)indexPath.row);
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    sendRemoteMsgBkDoor((int)indexPath.row + 50);
}


BOOL sendRemoteMsgBkDoor(int msgIdx)
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *aps = [[NSMutableDictionary alloc]init];
    NSString *platformType      = @"1";
    NSString *emoji             =[NSString stringWithFormat:EMJ_LAUGH];
    NSString *myString          = @"My little horse must think it queer \n To stop without a farmhouse near, \n Between the woods and frozen lake, \n The darkest evening of the year. \n";
    NSString *alert             = [myString stringByAppendingString:emoji];
    //NSString *alert             = self.msgTxt.text;
    NSString *msgTxt            = alert;
    NSString *msgTitle          = @"Title: This is how it Looks !!";
    NSString *isPriority        = @"false";
    NSString *sound             = @"default";
    NSString *category          = @"shipit_ARR_category_id" ; // @"shipit_ARR_category_id"
    //NSString *msgID             = [@"ABCD" stringByAppendingString:badge];
    NSString *msgInfo           = @"8";
    NSString *msgContent        = @"0";
    NSString *msgTyp            = @(msgIdx).stringValue;
    NSString *imgPath           = @"http://www.dsource.in/sites/default/files/resource/story-indian-animation/episodes/images/09-800.jpg";
    
    //if ([ianNum intValue] == 20)
    {
        imgPath = @"http://christmas-images.clipartonline.net/_/rsrc/1349126411345/home/Disney_Christmas_Cartoon_Characters-7.png?height=320&width=320";
    }
    /*else
        imgPath           = @"http://www.dsource.in/sites/default/files/resource/story-indian-animation/episodes/images/09-800.jpg";
     */

    
    
    aps[@"alert"] = alert;
    aps[@"sound"] = sound;
    // aps[@"badge"] = badge;
    aps[@"category"] = category;
    
    [userInfo setObject:aps                 forKey:@"aps"];
    [userInfo setObject:msgContent          forKey:@"msgContent"];
    [userInfo setObject:msgTitle            forKey:@"msgTitle"];
    [userInfo setObject:@"blackColor"       forKey:@"titleClr"];
    [userInfo setObject:isPriority          forKey:@"isPriority"];
    //[userInfo setObject:msgID             forKey:@"msgID"];
    [userInfo setObject:platformType        forKey:@"platformType"];
    [userInfo setObject:msgInfo             forKey:@"msgInfo"];
    [userInfo setObject:msgTxt              forKey:@"msgTxt"];
    [userInfo setObject:msgTyp              forKey:@"msgTyp"];
    [userInfo setObject:imgPath             forKey:@"imgPath"];
    [userInfo setObject:@"\U00002611 Now"   forKey:@"b1Name"];
    [userInfo setObject:@"\U000023F0 Remind Me Later"  forKey:@"b2Name"];
    //[userInfo setObject:@"Close"          forKey:@"b3Name"]; <optional>
    [userInfo setObject:@"blackColor"       forKey:@"titleClr"];
    [userInfo setObject:@"Top"              forKey:@"titPos"];
    
  
    if ([msgTyp intValue] == 55)
    {
        aps[@"alert"] = @"If you love our App, Please take a moment to Rate Us...";
        [userInfo setObject:@"Rate Us"          forKey:@"msgTitle"];
        [userInfo setObject:aps                 forKey:@"aps"];
        [userInfo setObject:@"yellowColor"      forKey:@"starClr"];
        [userInfo setObject:@"lightGrayColor"     forKey:@"msgBgClr"];
        [userInfo setObject:@"greenColor"       forKey:@"txtClr"];
    }
    
    if ([msgTyp intValue] == 60)
    {
        [userInfo setObject:@"New Disney Movie released in your nearest theater"
                     forKey:@"msgTitle"];
        [userInfo setObject:@"\U00002611 Book Now"   forKey:@"b1Name"];
        [userInfo setObject:@"\U000023F0 Remind Me Later"  forKey:@"b2Name"];
    }
    
    [shipit  SIM_BkDoorMsg:userInfo];
    return TRUE;
}


@end
