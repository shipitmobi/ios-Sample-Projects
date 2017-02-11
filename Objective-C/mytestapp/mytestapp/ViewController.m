//
//  ViewController.m
//  mytestapp
//
//  Created by gaurav dwivedi on 12/5/15.
//  Copyright © 2015 kickboard. All rights reserved.
//

#import "ViewController.h"
#import "shipit/shipit.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)msgTxtCtrl:(id)sender {    
    NSLog(@"Custome Txt Message is %@  \n", self.msgTxt.text);
}


- (IBAction)pushTxtCtrl:(id)sender {
    [self sendRemoteMsg];
    return;
}

- (void) addDelay {
    double delayInSeconds = 50.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
    });
    return;
}

- (void)viewDidLoad {
    [super viewDidLoad];    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void) sendRemoteMsg {   
    
    if (false == [self isInternetAvail])
        return;
    
    //  Get the current dictionary from NSUserDefaults //
    
    NSMutableDictionary* shipitCfg = [[[NSUserDefaults standardUserDefaults] objectForKey:SHIPIT_DICT_CFG]mutableCopy];
    NSMutableDictionary *sendJson = [[NSMutableDictionary alloc]init];
    //NSLog(@"Printing all Configs ....\n  %@", shipitCfg);
    // NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"<|>"];
    NSString *shipitAppKey      = [shipitCfg objectForKey:@"shipitAppKey"];
    NSString *devToken          = [shipitCfg objectForKey:@"devToken"];
    NSString *channelID         = [shipitCfg objectForKey:@"channelID"];
    NSString *name              = [shipitCfg objectForKey:@"name"];
    NSString *email             = [shipitCfg objectForKey:@"email"];
    NSString *platformType      = @"1";
    NSString *emoji             =[NSString stringWithFormat:EMJ_LAUGH];
    //NSString *alert             = [self.msgTxt.text stringByAppendingString:emoji];
    NSString *alert             = self.msgTxt.text;
    NSString *msgTxt            = alert;
    NSString *msgTitle          = @"TITLE: New Message";
    NSString *isPriority        = @"false";
    NSString *sound             = @"default";
    NSString *badge             = [self getBadgeCnt];
    NSString *category          = @"shipit_ARR_category_id" ; // @"shipit_ARR_category_id"
    NSString *msgID             = [@"ABCD" stringByAppendingString:badge];
    NSString *msgInfo           = @"8";
    NSString *msgContent        = @"0";
    
    if ([self checkForParseStr:alert] ==TRUE)
    {
        msgContent          = @"1";
        msgInfo             = @"3";
        msgTxt              = [alert stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Encoding special symbols in Alert");
    }
    
    // Create the basic JSON PAcket
    [sendJson setObject:badge           forKey:@"badge"];
    [sendJson setObject:msgContent      forKey:@"msgContent"];
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
    [sendJson setObject:msgInfo         forKey:@"msgInfo"];
    [sendJson setObject:msgTxt          forKey:@"msgTxt"];
  

    NSData *json = [NSJSONSerialization dataWithJSONObject:sendJson
                                                   options:0
                                                     error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
    // This will be the json string in the preferred format
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    // And this will be the json data object
    //NSData *processedData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
#ifdef SHIPIT_DEBUG
    NSLog(@"Sent JSON Data is : \n %@", jsonString);
#endif
    
    NSData *postData = [jsonString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    NSLog(@" Length of payload is %@", postLength);
    
    NSString *myUrl = SERVERP_TEST;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:myUrl]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    NSLog(@"your response is :%@",response);
    return;
    
}


- (void) showStats {
    
    NSMutableDictionary* shipitStats = [[[NSUserDefaults standardUserDefaults] objectForKey:SHIPIT_DICT_STATS]mutableCopy];
    if (!shipitStats)
        return;
    int APP_OPEN_CNT = (int)[shipitStats[STATS_APP_OPEN_ALL_CNT] integerValue];
    int MSG_OPEN_CNT = (int)[shipitStats [STATS_MSG_ONLY_OPEN_CNT] integerValue];
    int ALL_MSG_CNT = (int)[shipitStats[STATS_ALL_MSG_CNT] integerValue];

    NSLog(@"APP_OPEN_CNT ==> %d ", APP_OPEN_CNT);
    NSLog(@"MSG_OPEN_CNT ==> %d ", MSG_OPEN_CNT);
    NSLog(@"ALL_MSG_CNT ==> %d ", ALL_MSG_CNT);
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return;
}

- (BOOL) checkForParseStr :(NSString *)inputStr
{
    NSCharacterSet *cset = [NSCharacterSet characterSetWithCharactersInString:@"<|>"];
    NSRange range = [inputStr rangeOfCharacterFromSet:cset];
    if (range.location == NSNotFound)
        return FALSE;
    else
        return TRUE;

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

@end

