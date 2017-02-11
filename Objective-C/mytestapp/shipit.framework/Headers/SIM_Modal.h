//
//  SIM_Modal.h
//  shipit
//
//  Created by gaurav dwivedi on 07/10/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#ifndef SIM_Modal_h
#define SIM_Modal_h
#import <UIKit/UIKit.h>

extern NSString *const SIM_ModalWillShowNotification;
extern NSString *const SIM_ModalDidShowNotification;
extern NSString *const SIM_ModalWillHideNotification;
extern NSString *const SIM_ModalDidHideNotification;

typedef NS_ENUM(NSUInteger, SIM_ModalBackgroundDisplayStyle){
    SIM_ModalBackgroundDisplayStyleGradient,
    SIM_ModalBackgroundDisplayStyleSolid
};

typedef NS_ENUM(NSUInteger, SIM_ModalCloseButtonType){
    SIM_ModalCloseButtonTypeNone,
    SIM_ModalCloseButtonTypeLeft,
    SIM_ModalCloseButtonTypeRight
};

@interface SIM_Modal : NSObject

// Determines if the modal should dismiss if the user taps outside of the modal view
// Defaults to YES
@property (nonatomic) BOOL tapOutsideToDismiss;

// Determines if the close button or tapping outside the modal should animate the dismissal
// Defaults to YES
@property (nonatomic) BOOL animateWhenDismissed;

// Determins close button type (None/Left/Right)
// Defaults to Left
@property (nonatomic) SIM_ModalCloseButtonType closeButtonType;

// The background color of the modal window
// Defaults black with 0.5 opacity
@property (strong, nonatomic) UIColor *modalBackgroundColor;

// The background display style, can be a transparent radial gradient or a transparent black
// Defaults to gradient, this looks better but takes a bit more time to display on the retina iPad
@property (nonatomic) SIM_ModalBackgroundDisplayStyle backgroundDisplayStyle;

// Determines if the modal should rotate when the device rotates
// Defaults to YES, only applies to iOS5
@property (nonatomic) BOOL shouldRotate;

// The shared instance of the modal
+ (instancetype)sharedInstance;

// Set the content view to display in the modal and display with animations
- (void)showWithContentView:(UIView *)contentView;

// Set the content view to display in the modal and whether the modal should animate in
- (void)showWithContentView:(UIView *)contentView andAnimated:(BOOL)animated;

// Set the content view controller to display in the modal and display with animations
- (void)showWithContentViewController:(UIViewController *)contentViewController;

// Set the content view controller to display in the modal and whether the modal should animate in
- (void)showWithContentViewController:(UIViewController *)contentViewController andAnimated:(BOOL)animated;

// Hide the modal with animations
- (void)hide;

// Hide the modal with animations,
// run the completion after the modal is hidden
- (void)hideWithCompletionBlock:(void(^)())completion;

// Hide the modal and whether the modal should animate away
- (void)hideAnimated:(BOOL)animated;

// Hide the modal and whether the modal should animate away,
// run the completion after the modal is hidden
- (void)hideAnimated:(BOOL)animated withCompletionBlock:(void(^)())completion;

@end

#endif /* SIM_Modal_h */
