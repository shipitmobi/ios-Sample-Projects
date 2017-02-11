//
//  AppDelegate.m
//  simtestapp
//
//  Created by gaurav dwivedi on 12/01/17.
//  Copyright © 2017 Karmatics. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[shipitmobi docker] SIM_SetLaunch:launchOptions];
    
    
    //1. add the image to the front of the view...
    UIImageView *splashImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [splashImage setImage: [UIImage imageNamed:@"LaunchImage"]];
    [self.window addSubview:splashImage];
    [self.window bringSubviewToFront:splashImage];
    
    //2. set an anchor point on the image view so it opens from the left
    splashImage.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //reset the image view frame
    splashImage.frame = CGRectMake(0, 0, 320, 480);
    
    //3. animate the open
    [UIView animateWithDuration:1.0
                          delay:0.6
                        options:(UIViewAnimationCurveEaseOut)
                     animations:^{
                         
                         splashImage.layer.transform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1, 0);
                     } completion:^(BOOL finished){
                         
                         //remove that imageview from the view
                         [splashImage removeFromSuperview];
                     }];
    
    
    [self requestTagActivity];
    
    return YES;
}


- (void) requestTagActivity
{
    NSString *dateString = @"22-Dec-15";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd-MMM-yy";
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    NSDictionary *tags = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"India",@"Country",
                          @"false",@"Working",
                          nil];
    
    [shipitmobi SIM_SetTags:tags];
    NSArray *delTags = [NSArray arrayWithObjects: @"Country", @"Gaurav", nil];
    [shipitmobi SIM_DelTags:delTags];
    
    tags = [NSDictionary dictionaryWithObjectsAndKeys:
            @"India",@"Country",
            @"false",@"Working",
            @"India", @"Alias",
            @123456, @"FavNumber",
            @156745, @"price",
            @"true", @"isAdult",
            [NSArray arrayWithObjects:@"Item1", @"Item2", @"Item3", nil], @"MyList",
            nil];
    [shipitmobi SIM_SetTags:tags];
    delTags = [NSArray arrayWithObjects: @"Country", @"Working", nil];
    
    [shipitmobi SIM_DelTags:delTags];
    
    NSArray *tagList = [shipitmobi SIM_GetTags];
    NSLog(@"%@",tagList);
    return;
}


@end
