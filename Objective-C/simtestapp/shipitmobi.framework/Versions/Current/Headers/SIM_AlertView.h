//
//  SIM_AlertView.h
//  shipitmobi
//
//  Created by gaurav dwivedi on 01/01/17.
//  Copyright © 2017 Karmatics. All rights reserved.
//

#ifndef SIM_AlertView_h
#define SIM_AlertView_h


#import <UIKit/UIKit.h>
#import "SIM_StarRating.m"

@protocol SIM_AlertViewDelegate

- (void)customIOS7dialogButtonTouchUpInside:(id)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface SIM_AlertView : UIView<SIM_AlertViewDelegate>

@property (nonatomic, retain) UIView *parentView;    // The parent view this 'dialog' is attached to
@property (nonatomic, retain) UIView *dialogView;    // Dialog's container view
@property (nonatomic, retain) UIView *containerView; // Container within the dialog (place your ui elements here)

@property (nonatomic, assign) id<SIM_AlertViewDelegate> delegate;
@property (nonatomic, retain) NSArray *buttonTitles;
@property (nonatomic, assign) BOOL useMotionEffects;
@property (nonatomic, assign) BOOL closeOnTouchUpOutside;       // Closes the AlertView when finger is lifted outside the bounds.

@property (copy) void (^onButtonTouchUpInside)(SIM_AlertView *alertView, int buttonIndex) ;

- (id)init;

/*!
 DEPRECATED: Use the [SIM_AlertView init] method without passing a parent view.
 */
- (id)initWithParentView: (UIView *)_parentView __attribute__ ((deprecated));

- (void)show;
- (void)close;

- (IBAction)customIOS7dialogButtonTouchUpInside:(id)sender;
- (void)setOnButtonTouchUpInside:(void (^)(SIM_AlertView *alertView, int buttonIndex))onButtonTouchUpInside;

- (void)deviceOrientationDidChange: (NSNotification *)notification;
- (void)dealloc;

@end

#endif /* SIM_AlertView_h */
