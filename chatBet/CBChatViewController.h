//
//  CBChatViewController.h
//  chatBet
//
//  Created by dan g / applicaster on 9/12/14.
//  Copyright (c) 2014 chat bet ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBChatViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *chat;
@property (nonatomic, weak) IBOutlet UIButton *bet;
@property (nonatomic, weak) IBOutlet UIButton *rank;
@property (nonatomic, weak) IBOutlet UIView *buttom;
@property (nonatomic, weak) IBOutlet UIImageView *buttomImage;
@property (nonatomic, weak) IBOutlet UIView *buttonsView;
@property (nonatomic, weak) IBOutlet UIButton *betButton1;
@property (nonatomic, weak) IBOutlet UIButton *betButton2;
@property (nonatomic, weak) IBOutlet UIButton *betButton3;
@property (nonatomic, weak) IBOutlet UILabel *betTitleQuestions;
@property (nonatomic, weak) IBOutlet UILabel *betTitleQuestionsNumbers;
@property (nonatomic, weak) IBOutlet UIButton *storeBtn;

@property (nonatomic, assign) BOOL hasSeenMoneyMessage;
@property (nonatomic, strong) UIView *badgeChat;
@property (nonatomic, strong) UIView *badgeBet;
@property (nonatomic, strong) UIView *badgeRank;
@property (nonatomic, strong) NSTimer *timerForBadgeDisplay;
@property (nonatomic, strong) NSArray *inlineQuestions;
@property (nonatomic, assign) int inlineQuestionsIndex;

@property (nonatomic, assign) int secondsLeftForBadgeDisplay;
- (IBAction)chatPressed:(id)sender;
- (IBAction)betPressed:(id)sender;
- (IBAction)rankPressed:(id)sender;
- (IBAction)storeBtnPressed:(id)sender;
- (IBAction)betButton1Pressed:(id)sender;
- (IBAction)betButton2Pressed:(id)sender;
- (IBAction)betButton3Pressed:(id)sender;
- (IBAction)unwind:(id)sender;
@end
