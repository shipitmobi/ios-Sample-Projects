//
//  shipitNotificationArtist.h
//  shipit
//
//  Created by gaurav dwivedi on 12/28/15.
//  Copyright © 2015 kickboard. All rights reserved.
//

#ifndef shipitNotificationArtist_h
#define shipitNotificationArtist_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <objc/runtime.h>
#import "shipit.h"



#define BASIC_MSG_CATEGORY              @"shipit_MSG_category_id"
#define ACCEPT_REJECT_REPLY_CATEGORY    @"shipit_ARR_category_id"
#define DECLINE_REPLY_CATEGORY          @"shipit_DR_category_id"

@interface shipitNotificationArtist : NSObject<UIAlertViewDelegate>
@property (nonatomic, copy) NSString *dummy;

+ (void) shipitDrawAll:(NSDictionary *)userInfo;
+ (NSMutableSet*) initAcceptRejectReplyCategory ;
+ (NSMutableSet *)initDeclineReplyCategory;

@end


#endif /* shipitNotificationArtist_h */
