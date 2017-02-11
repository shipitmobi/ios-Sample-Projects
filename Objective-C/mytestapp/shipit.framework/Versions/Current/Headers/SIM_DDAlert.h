//
//  SIM_DDAlert.h
//  shipit
//
//  Created by gaurav dwivedi on 24/10/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#ifndef SIM_DDAlert_h
#define SIM_DDAlert_h


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "shipit.h"

typedef void (^YRTapBlock)(void);

@interface SIM_DDAlert : UIView
{
    NSString *titleText;
    NSString *detailText;
    UILabel *titleLabel;
    UILabel *detailLabel;
    //UIImage *backgroundImage;
    UIImageView *backgroundImageView;
    //UIImage *accessoryImage;
    UIImageView *accessoryImageView;
    UIColor *titleLabelColor;
    UIColor *detailLabelColor;
    SEL onTouch;
    NSDate *showStarted;
    BOOL shouldAnimate;
    
    YRTapBlock          _tapBlock;
    dispatch_queue_t    _tapQueue;
}

@property (copy) NSString *titleText;
@property (copy) NSString *detailText;

#if !(__has_feature(objc_arc))
@property (nonatomic, retain) UIImage *accessoryImage;
@property (nonatomic, retain) UIImage *backgroundImage;
#else
@property (nonatomic, strong) UIImage *accessoryImage;
@property (nonatomic, strong) UIImage *backgroundImage;
#endif

@property (assign) float minHeight;
@property (retain) UIColor *titleLabelColor;
@property (retain) UIColor *detailLabelColor;
@property (nonatomic, assign) SEL onTouch;
@property (assign) BOOL shouldAnimate;

@property (nonatomic, copy) YRTapBlock  tapBlock;

#pragma mark - View methods

+ (SIM_DDAlert *)showDropdownInView:(UIView *)view
                                 title:(NSString *)title;

+ (SIM_DDAlert *)showDropdownInView:(UIView *)view
                                 title:(NSString *)title
                                detail:(NSString *)detail;

+ (SIM_DDAlert *)showDropdownInView:(UIView *)view
                                 title:(NSString *)title
                                detail:(NSString *)detail
                              animated:(BOOL)animated;

+ (SIM_DDAlert *)showDropdownInView:(UIView *)view
                                 title:(NSString *)title
                                detail:(NSString *)detail
                                 image:(UIImage *)image
                              animated:(BOOL)animated;

+ (SIM_DDAlert *)showDropdownInView:(UIView *)view
                                 title:(NSString *)title
                                detail:(NSString *)detail
                                 image:(UIImage *)image
                              animated:(BOOL)animated
                             hideAfter:(float)delay;

+ (SIM_DDAlert *)showDropdownInView:(UIView *)view
                                 title:(NSString *)title
                                detail:(NSString *)detail
                                 image:(UIImage *)image
                       backgroundImage:(UIImage *)backgroundImage
                              animated:(BOOL)animated
                             hideAfter:(float)delay;

+ (SIM_DDAlert *)showDropdownInView:(UIView *)view
                                 title:(NSString *)title
                                detail:(NSString *)detail
                                 image:(UIImage *)image
                       backgroundImage:(UIImage *)backgroundImage
                       titleLabelColor:(UIColor *)titleLabelColor
                      detailLabelColor:(UIColor *)detailLabelColor
                              animated:(BOOL)animated
                             hideAfter:(float)delay;

+ (BOOL)hideDropdownInView:(UIView *)view;
+ (BOOL)hideDropdownInView:(UIView *)view animated:(BOOL)animated;

#pragma mark -
- (void)show:(BOOL)animated;
- (void)hide:(BOOL)animated;

-(void)setTapBlock:(YRTapBlock)tapBlock
         withQueue:(dispatch_queue_t)dispatchQueue;


@end


#endif /* SIM_DDAlert_h */
