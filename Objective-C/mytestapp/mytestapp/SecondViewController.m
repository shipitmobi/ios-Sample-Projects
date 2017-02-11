//
//  SecondViewController.m
//  mytestapp
//
//  Created by gaurav dwivedi on 1/15/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.radArray  = [[NSArray alloc] initWithObjects:@"10",@"100",@"500",@"1000",@"5000", nil];
    // Do any additional setup after loading the view, typically from a nib.
    self.inputRadius.delegate = self;
    self.inputRadius.dataSource = self;
    
    if (self.locationManager == nil)
    {
        shipitRegMon *rm = [shipitRegMon regMon];
        if (rm == nil)
            NSLog(@"cannot get shipit Region Monitor");
        else
            self.locationManager = rm.shipitLocManager;                                                                                                                                                   
        
        if (self.locationManager == nil)
            NSLog(@"cannot get location manager");
    }
    self.locationManager.delegate = self; // we set the delegate of locationManager to self.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // setting the accuracy
    [self.locationManager startUpdatingLocation];  //requesting location updates

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)msgTxtCtrl:(id)sender {
    NSLog(@" Geofence Identifier value is %@ \n", self.msgTxt.text);
}


-(NSInteger) getIdnt
{
    NSInteger ident = [[NSUserDefaults standardUserDefaults] integerForKey:@"geoFenceCnt"];
    if(ident == 0) {
        ident = 1000;
        NSLog(@"ident value: %ld", (long)ident);
        [[NSUserDefaults standardUserDefaults] setInteger:ident forKey:@"geoFenceCnt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return ident;
}

-(void) setIdnt:(NSInteger)ident
{
    [[NSUserDefaults standardUserDefaults] setInteger:ident forKey:@"geoFenceCnt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return;
}

- (IBAction)addFence:(id)sender {
    NSLog(@"Inside function %s", __FUNCTION__);
    if (false == [self isInternetAvail]) {
        // use backend
        [self addFenceBackDoor];
        return;
    }
    
    
    NSInteger ident = [self getIdnt];
    NSLog(@"ident value: %ld", (long)ident);
    CLLocation *currL = [shipitRegMon regMon].currentLoc;
    CLRegion *newRegion = nil;
    CLLocationDegrees latitude  = currL.coordinate.latitude;
    CLLocationDegrees longitude = currL.coordinate.longitude;
    CLLocationDistance regionRadius = 100; // fixed for now[self.radius.text  doubleValue ];
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    NSString *version = [[UIDevice currentDevice] systemVersion];
    NSString *identifier = ([self.msgTxt.text length] != 0 )? self.msgTxt.text:[NSString stringWithFormat:@"%d", (int)ident];
    
    NSMutableDictionary* shipitCfg = [[[NSUserDefaults standardUserDefaults] objectForKey:SHIPIT_DICT_CFG]mutableCopy];
    NSMutableDictionary *sendJson = [[NSMutableDictionary alloc]init];
    //NSLog(@"Printing all Configs ....\n  %@", shipitCfg);
    NSNumber *tmpNum = nil;
    NSString *shipitAppKey = [shipitCfg objectForKey:@"shipitAppKey"];
    NSString *devToken     = [shipitCfg objectForKey:@"devToken"];
    NSString *channelID    = [shipitCfg objectForKey:@"channelID"];
    NSString *name         = [shipitCfg objectForKey:@"name"];
    NSString *email        = [shipitCfg objectForKey:@"email"];
    NSString *platformType = @"1";
    NSString *alert        = @"geozone";
    NSString *msgInfo      = @"8";
    NSString *msgTitle     = @" GEO-ZONE ";
    NSString *isPriority   = @"false";
    NSString *badge        = [self getBadgeCnt];
    NSString *category     = @"shipit_ARR_category_id" ; // @"shipit_ARR_category_id"
    NSString *msgID        = [@"ABCD" stringByAppendingString:badge];
    NSMutableDictionary *aps      = [[NSMutableDictionary alloc]init];
    NSMutableArray *geoZone  = [[NSMutableArray alloc]init];
    
    NSString *contentAvail  = @"1";
    int row = (int)[self.inputRadius selectedRowInComponent:0];
    self.dist = [[self.radArray objectAtIndex:row] integerValue];
    NSLog(@"Selected row number is %d  and distcace is %ld Metres", row, (long)self.dist);
    regionRadius = self.dist;
    
    ident++;
    NSMutableDictionary *zoneVal =[[NSMutableDictionary alloc]init];
    [zoneVal setObject:identifier forKey:@"identifier"];
    tmpNum = [[NSNumber alloc] initWithDouble:latitude];
    [zoneVal setObject:tmpNum   forKey:@"latitude"];
    tmpNum = [[NSNumber alloc] initWithDouble:longitude];
    [zoneVal setObject:tmpNum   forKey:@"longitude"];
    tmpNum = [[NSNumber alloc] initWithDouble:regionRadius];
    [zoneVal setObject:tmpNum   forKey:@"radius"];
    
    [geoZone addObject:zoneVal];
    
    // Create the basic JSON PAcket
    [sendJson setObject:badge           forKey:@"badge"];
    [sendJson setObject:msgInfo         forKey:@"msgInfo"];
    [sendJson setObject:alert           forKey:@"alert"];
    [sendJson setObject:msgTitle        forKey:@"msgTitle"];
    [sendJson setObject:isPriority      forKey:@"isPriority"];
    [sendJson setObject:category        forKey:@"category"];
    [sendJson setObject:msgID           forKey:@"msgID"];
    [sendJson setObject:shipitAppKey    forKey:@"shipitAppKey"];
    [sendJson setObject:devToken        forKey:@"devToken"];
    [sendJson setObject:channelID       forKey:@"channelID"];
    [sendJson setObject:name            forKey:@"name"];
    [sendJson setObject:email           forKey:@"email"];
    [sendJson setObject:platformType    forKey:@"platformType"];
    [sendJson setObject:aps             forKey:@"aps"];
    [sendJson setObject:geoZone         forKey:@"geoZone"];
    
    NSData *json = [NSJSONSerialization dataWithJSONObject:sendJson
                                                   options:0
                                                     error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    // This will be the json string in the preferred format
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    // And this will be the json data object
    //NSData *processedData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
#ifdef SHIPIT_DEBUG
    NSLog(@"JSON Data is : \n %@", jsonString);
#endif
    
    NSData *postData = [jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSLog(@" Length of payload is %@", postLength);
    
    NSString *myUrl = @"http://api.shipit.mobi/RestApi/testDeviceRemote";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:myUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    NSLog(@"your response is :%@",response);
    [self setIdnt:ident];
    return;
    
}


-(void) addFenceBackDoor {
    NSLog(@"Inside function %s", __FUNCTION__);
    NSInteger ident = [[NSUserDefaults standardUserDefaults] integerForKey:@"geoFenceCnt"];
    if(ident == 0)
        ident = 1001;
    else
        ident++;
    NSLog(@"ident value: %ld", (long)ident);
    CLLocation *currL = [shipitRegMon regMon].currentLoc;
    CLRegion *newRegion = nil;
    CLLocationDegrees latitude  = currL.coordinate.latitude;
    CLLocationDegrees longitude = currL.coordinate.longitude;
    CLLocationDistance regionRadius = 100; // fixed for now[self.radius.text  doubleValue ];
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    NSString *version = [[UIDevice currentDevice] systemVersion];
    NSString *identifier = ([self.msgTxt.text length] != 0 )? self.msgTxt.text:[NSString stringWithFormat:@"%d", (int)ident];
    int row = (int)[self.inputRadius selectedRowInComponent:0];
    self.dist = [[self.radArray objectAtIndex:row] integerValue];
    NSLog(@"Selected row number is %d  and distcace is %ld Metres", row, (long)self.dist);
    regionRadius = self.dist;
    
    
    if([version floatValue] >= 7.0f) //for iOS7
    {
        newRegion =  [[CLCircularRegion alloc] initWithCenter:centerCoordinate
                                                       radius:regionRadius
                                                   identifier:identifier];
    }
    else // iOS 7 below
    {
        newRegion = [[CLRegion alloc] initCircularRegionWithCenter:centerCoordinate
                                                            radius:regionRadius
                                                        identifier:identifier];
    }
    
    NSLog(@"Adding new geofence with Identifier::  %ld", (long)ident);
    // use backend
    shipitRegMon *rm = [shipitRegMon regMon];
    [rm addMonitoringRegion:newRegion];
    [[NSUserDefaults standardUserDefaults] setInteger:ident forKey:@"geoFenceCnt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return;
}

// Data Source Begin....
// Picker view implementataion
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [self.radArray count];
}
// Data Source End .....



// delegate  begin......
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.radArray objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    
    NSLog(@"Selected Row %ld", (long)row);
    
    NSString *opTxt = [self.radArray objectAtIndex:row];
    self.selRadius.text = opTxt;
    
}
// delegate end......

- (void)update:(CLLocation *)location {
    self.showLat.text= [NSString stringWithFormat:@"Latitude: %f", [location coordinate].latitude];
    self.showLong.text = [NSString stringWithFormat:@"Longitude: %f", [location coordinate].longitude];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.showLat.text= [NSString stringWithFormat:@"%f", [location coordinate].latitude];
    self.showLong.text = [NSString stringWithFormat:@"%f", [location coordinate].longitude];
    self.showAlt.text = [NSString stringWithFormat:@"%.0f m",location.altitude];
    self.showSpeed.text = [NSString stringWithFormat:@"%.1f m/s", location.speed];
}


- (bool) isInternetAvail
{
    bool chk = true;
    //Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    //NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    NSURL *scriptUrl = [NSURL URLWithString:@"http://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scriptUrl];
    //if (networkStatus == NotReachable)
    //    NSLog(@"Device is connected to the internet");
    // else
    //    NSLog(@"Device is not connected to the internet");
    if (data == nil) {
        NSLog(@"There IS NO internet connection");
        chk = false;
    } else {
        NSLog(@"There IS internet connection");
        chk = true;
    }
    
    return chk;
}


- (NSString *) getBadgeCnt
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    int badgeCnt = 1;
    if([defaults objectForKey:@"badgeCnt"] != nil)
        badgeCnt = (int)[defaults integerForKey:@"badgeCnt"] + 1;
    
    [defaults setInteger:badgeCnt forKey:@"badgeCnt"];
    // Dont forget to synchronize UserDefaults
    [defaults synchronize];
    return [NSString stringWithFormat:@"%i", badgeCnt];
}




@end
