//
//  SIM_InAppArtist.h
//  shipitmobi
//
//  Created by gaurav dwivedi on 01/01/17.
//  Copyright © 2017 Karmatics. All rights reserved.
//
#ifndef SIM_InAppArtist_h
#define SIM_InAppArtist_h

#import "shipitmobi.h"
#import <UIKit/UIKit.h>

@interface SIM_InAppArtist : NSObject<UIAlertViewDelegate>
+ (void) SIM_DrawAll:(NSDictionary *)userInfo;
@end


#endif /* SIM_InAppArtist_h */
