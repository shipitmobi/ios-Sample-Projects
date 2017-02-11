//
//  SIm_StarRating.h
//  shipit
//
//  Created by gaurav dwivedi on 16/10/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#ifndef SIm_StarRating_h
#define SIm_StarRating_h
#import <UIKit/UIKit.h>


typedef BOOL(^SIM_StarRatingShouldBeginGestureRecognizerBlock)(UIGestureRecognizer *gestureRecognizer);

IB_DESIGNABLE
@interface SIM_StarRating : UIControl
@property (nonatomic) IBInspectable NSUInteger maximumValue;
@property (nonatomic) IBInspectable CGFloat minimumValue;
@property (nonatomic) IBInspectable CGFloat value;
@property (nonatomic) IBInspectable CGFloat spacing;
@property (nonatomic) IBInspectable BOOL allowsHalfStars;
@property (nonatomic) IBInspectable BOOL accurateHalfStars;
@property (nonatomic) IBInspectable BOOL continuous;

@property (nonatomic) BOOL shouldBecomeFirstResponder;

// Optional: if `nil` method will return `NO`.
@property (nonatomic, copy) SIM_StarRatingShouldBeginGestureRecognizerBlock shouldBeginGestureRecognizerBlock;

@property (nonatomic, strong) IBInspectable UIImage *emptyStarImage;
@property (nonatomic, strong) IBInspectable UIImage *halfStarImage;
@property (nonatomic, strong) IBInspectable UIImage *filledStarImage;
@end

#endif /* SIm_StarRating_h */
