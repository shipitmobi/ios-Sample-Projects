//
//  MyCollectionViewController.m
//  mytestapp
//
//  Created by gaurav dwivedi on 07/11/16.
//  Copyright © 2016 kickboard. All rights reserved.
//

#import "MyCollectionViewController.h"

@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _myImages = [@[@"sendpush.png",
                    @"inapp.png",
                    @"geofencing.png",
                    @"showstats.png",
                    @"cart5.png"] mutableCopy];
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return _myImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                    forIndexPath:indexPath];
     
     UIImage *image;
     long row = [indexPath row];
     
     image = [UIImage imageNamed:_myImages[row]];
     CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - 10;
     //myCell.imageView.image = image;
     myCell.myImgView.image = image;

     myCell.myImgView.contentMode = UIViewContentModeScaleAspectFit;
     myCell.backgroundColor = [UIColor grayColor];
     return myCell;

    
    /*
    static NSString *identifier = @"MyCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[_myImages objectAtIndex:indexPath.row]];
    
    return cell;
     */

}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionView *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10; // This is the minimum inter item spacing, can be more
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [_myImages objectAtIndex:indexPath.row];
    //You may want to create a divider to scale the size by the way..
    CGFloat scrW = (CGRectGetWidth([UIScreen mainScreen].bounds) - 20)/2;
    return CGSizeMake(scrW, scrW);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int row = (int)[indexPath row];
    NSLog(@"Row accessed %ld", row);
    switch (row)
    {
        case 0:
            [self performSegueWithIdentifier:@"segue_messg" sender:self];
            //[self.parentViewController performSegueWithIdentifier:@"ViewController" sender:self.parentViewController];
            break;
        case 1:
             [self performSegueWithIdentifier:@"segue_messg" sender:self];
            //[self.parentViewController performSegueWithIdentifier:@"SecondViewController" sender:self.parentViewController];
            break;
        case 2:
            [self performSegueWithIdentifier:@"segue_messg" sender:self];
            // [self.parentViewController performSegueWithIdentifier:@"InAppTableViewController" sender:self.parentViewController];
            break;
        case 3:
            [self performSegueWithIdentifier:@"segue_messg" sender:self];
            // [self.parentViewController performSegueWithIdentifier:@"InAppTableViewController" sender:self.parentViewController];
            break;
        default:
            break;
            
    }
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"seg_01"]) {
        NSIndexPath *indexPath = [[self.collectionView indexPathsForSelectedItems] lastObject];
        UIImage * object = [_myImages objectAtIndex:indexPath.item];
        [[segue destinationViewController] getPub:object];
    }
}
 */
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MyCollectionViewCell *cell = (MyCollectionViewCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    UIViewController *sendMsgController = (UIViewController*)segue.destinationViewController;

    NSLog(@"Seqgue identifier is %@", [segue identifier]);
    //imageDetailViewController.truckImage = [UIImage imageNamed:[self.truckImages objectAtIndex:indexPath.row]];
    //imageDetailViewController.truckLabelText = [self.truckDescriptions objectAtIndex:indexPath.row];
}
*/

 

@end
