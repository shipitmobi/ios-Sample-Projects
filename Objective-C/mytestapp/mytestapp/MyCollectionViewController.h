//
//  MyCollectionViewController.h
//  mytestapp
//
//  Created by gaurav dwivedi on 07/11/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionViewCell.h"

@interface MyCollectionViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSMutableArray *myImages;
@end
