//
//  SIM_InAppArtist.h
//  shipit
//
//  Created by gaurav dwivedi on 02/10/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#ifndef SIM_InAppArtist_h
#define SIM_InAppArtist_h

#import "shipit.h"
#import <UIKit/UIKit.h>
#import "SIM_DDAlert.h"

#define BASIC_MSG_CATEGORY              @"shipit_MSG_category_id"
#define ACCEPT_REJECT_REPLY_CATEGORY    @"shipit_ARR_category_id"
#define DECLINE_REPLY_CATEGORY          @"shipit_DR_category_id"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
typedef enum {
    /** A view with a UIActivityIndicator and "Loading..." title. */
    FVAlertTypeLoading,
    /** A view with a checkmark and "Done" title. */
    FVAlertTypeDone,
    /** A view with a cross and "Error" title. */
    FVAlertTypeError,
    /** A view with an exclamation point and "Warning" title. */
    FVAlertTypeWarning,
    /** A view with a background shadow. */
    FVAlertTypeCustom,
} FVAlertType;



@interface SIM_InAppArtist : NSObject<UIAlertViewDelegate>
@property (nonatomic, copy) NSString *dummy;

+ (void) SIM_DrawAll:(NSDictionary *)userInfo;
@end


#endif /* SIM_InAppArtist_h */
