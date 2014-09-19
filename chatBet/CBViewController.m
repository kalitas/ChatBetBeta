//
//  CBViewController.m
//  chatBet
//
//  Created by dan g / applicaster on 9/5/14.
//  Copyright (c) 2014 chat bet ltd. All rights reserved.
//

#import "CBViewController.h"
#import "CBAppDelegate.h"

@interface CBViewController ()

@end

@implementation CBViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style: UIBarButtonItemStylePlain target:nil action:nil];
}

- (NSArray *)getDataByType:(int)type
{
    if (type == 1)
    {
        return [NSArray arrayWithObjects:@"Premier League", @"Series A", @"La Liga", @"Buondess League", nil];
    }
    else if (type == 0)
    {
        return [NSArray arrayWithObjects:@"NBA", @"WNBA", @"CBA", @"BLL", @"NCAA" , @"ACB", @"LA BNM", nil];
    }
    return [NSArray arrayWithObjects:@"Premier League", @"Series A", @"La Liga", @"Buondess League", nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundColor:[UIColor clearColor]];
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
    self.gamesType = [NSArray arrayWithObjects:@"basket", @"soccer", @"tennis", @"nf", nil];
    self.subGamesType = [NSArray arrayWithObjects:@"Premier League", @"Series A", @"La Liga", @"Buondess League", nil];
    
    UINavigationItem *item = self.navigationItem;
    UILabel *label = [[UILabel alloc] initWithFrame:self.navigationController.navigationBar.frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.text = @"Game List";
    item.titleView = label;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CBAppDelegate *appDelegate = (CBAppDelegate *)[[UIApplication sharedApplication] delegate];

    if ([appDelegate urlOpened] == YES)
    {
        [self.buttomButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self collectionView:self.gameTypeCollection didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
    [self collectionView:self.subGameTypeCollection didSelectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.gameTypeCollection)
    {
        return self.gamesType.count;
    }
    else
    {
        return self.subGamesType.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    UICollectionViewCell *cell = nil;
    if (collectionView == self.gameTypeCollection)
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GameTypeCell" forIndexPath:indexPath];
        UIImageView *image = (UIImageView *)[cell.contentView viewWithTag:2];
        image.image = [UIImage imageNamed:[self.gamesType objectAtIndex:indexPath.row]];
    }
    else
    {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SubGameTypeCell" forIndexPath:indexPath];
        UILabel *content = (UILabel *)[cell.contentView viewWithTag:2];
        content.text = [self.subGamesType objectAtIndex:indexPath.row];
    }

    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.gameTypeCollection)
    {
        UIImageView *image = (UIImageView *)[self.selectedCellGame.contentView viewWithTag:2];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [self.gamesType objectAtIndex:self.selectedIndexGame.row]]];
        
        
        CGFloat collectionViewWidth = CGRectGetWidth(self.gameTypeCollection.frame);
        [collectionView setContentInset:UIEdgeInsetsMake(collectionViewWidth / 2, 0, collectionViewWidth / 2, 0)];
        
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        self.selectedCellGame = cell;
        self.selectedIndexGame = indexPath;
        image = (UIImageView *)[cell.contentView viewWithTag:2];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@s", [self.gamesType objectAtIndex:indexPath.row]]];
        
        CGPoint offset = CGPointMake(cell.center.x - collectionViewWidth / 2, 0);
        [collectionView setContentOffset:offset animated:YES];
    
        if (indexPath.row > 0)
        {
            [self.buttomButton setBackgroundImage:[UIImage imageNamed:@"12onlygamelist.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.buttomButton setBackgroundImage:[UIImage imageNamed:@"basketBallScreen"] forState:UIControlStateNormal];
        }
        
        self.subGamesType = [self getDataByType:indexPath.row];
        [self.subGameTypeCollection reloadData];
        [self.subGameTypeCollection performBatchUpdates:^{
            [self collectionView:self.subGameTypeCollection didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        } completion:nil];
    }
    else
    {
        UILabel *content = (UILabel *)[self.selectedCellSub.contentView viewWithTag:2];
        
        content.textColor = [UIColor blackColor];
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        
        self.selectedCellSub = cell;
        self.selectedIndexSub = indexPath;
        
        content = (UILabel *)[cell.contentView viewWithTag:2];
        content.textColor = [UIColor whiteColor];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.subGameTypeCollection)
    {
        UILabel *label = [UILabel new];
        label.text = [self.subGamesType objectAtIndex:indexPath.row];
        label.font = [UIFont systemFontOfSize:20];
        int widthIs =
        [label.text
         boundingRectWithSize:label.frame.size
         options:NSStringDrawingUsesLineFragmentOrigin
         attributes:@{ NSFontAttributeName:label.font }
         context:nil]
        .size.width;
        return CGSizeMake(widthIs, 35);
    }
    else
    {
        return CGSizeMake(50, 50);
    }
    return CGSizeZero;
}

- (IBAction)unwindToThisViewController:(UIStoryboardSegue *)unwindSegue
{
    NSLog(@"Rolled back");
}
@end
