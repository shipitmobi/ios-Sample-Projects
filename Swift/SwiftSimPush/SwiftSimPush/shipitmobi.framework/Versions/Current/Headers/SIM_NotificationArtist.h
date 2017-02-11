//
//  SIM_NotificationArtist.h
//  shipitmobi
//
//  Created by gaurav dwivedi on 01/01/17.
//  Copyright © 2017 Karmatics. All rights reserved.
//

#ifndef SIM_NotificationArtist_h
#define SIM_NotificationArtist_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <objc/runtime.h>
#import "shipitmobi.h"

@interface SIM_NotificationArtist : NSObject<UIAlertViewDelegate>
+ (void) SIM_DrawAll:(NSDictionary *)userInfo;
@end

#endif /* SIM_NotificationArtist_h */
