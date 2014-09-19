//
//  CBViewController.h
//  chatBet
//
//  Created by dan g / applicaster on 9/5/14.
//  Copyright (c) 2014 chat bet ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBViewController : UIViewController
@property (nonatomic, strong) NSArray *gamesType;
@property (nonatomic, strong) NSArray *subGamesType;
@property (nonatomic, strong) UICollectionViewCell *selectedCellGame;
@property (nonatomic, strong) NSIndexPath *selectedIndexGame;
@property (nonatomic, strong) UICollectionViewCell *selectedCellSub;
@property (nonatomic, strong) NSIndexPath *selectedIndexSub;
@property (nonatomic, weak) IBOutlet UICollectionView *gameTypeCollection;
@property (nonatomic, weak) IBOutlet UICollectionView *subGameTypeCollection;
@property (nonatomic, weak) IBOutlet UIButton *buttomButton;

@end
