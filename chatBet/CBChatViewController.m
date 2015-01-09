//
//  CBChatViewController.m
//  chatBet
//
//  Created by dan g / applicaster on 9/12/14.
//  Copyright (c) 2014 chat bet ltd. All rights reserved.
//

#import "CBChatViewController.h"
#import "RNBlurModalView.h"
#import <MessageUI/MessageUI.h>

@interface CBChatViewController ()
{
    int _counterForBetPressed;
}
@end

@implementation CBChatViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _counterForBetPressed = 0;
    self.chat.selected = YES;
    
    UILabel *numberBet = [[UILabel alloc] init];
    numberBet.text = @"1";
    numberBet.textColor = [UIColor whiteColor];
    numberBet.textAlignment = NSTextAlignmentCenter;
    numberBet.tag = 123;
    UILabel *numberChat = [[UILabel alloc] init];
    numberChat.text = @"1";
    numberChat.textColor = [UIColor whiteColor];
    numberChat.textAlignment = NSTextAlignmentCenter;
    numberChat.tag = 123;

    UILabel *numberRank = [[UILabel alloc] init];
    numberRank.text = @"1";
    numberRank.textColor = [UIColor whiteColor];
    numberRank.textAlignment = NSTextAlignmentCenter;
    numberRank.tag = 123;

    self.badgeBet = [[UIView alloc] initWithFrame:CGRectMake(54,74,20,20)];
    self.badgeBet.layer.cornerRadius = 10;
    self.badgeBet.backgroundColor = [UIColor redColor];
    [self.badgeBet addSubview:numberBet];
    numberBet.bounds = [self.badgeBet bounds];
    numberBet.center = CGPointMake(self.badgeBet.frame.size.width / 2, self.badgeBet.frame.size.height / 2);

    self.badgeChat = [[UIView alloc] initWithFrame:CGRectMake(176,74,20,20)];
    self.badgeChat.layer.cornerRadius = 10;
    self.badgeChat.backgroundColor = [UIColor redColor];
    [self.badgeChat addSubview:numberChat];
    numberChat.bounds = [self.badgeChat bounds];
    numberChat.center = CGPointMake(self.badgeChat.frame.size.width / 2, self.badgeChat.frame.size.height / 2);

    self.badgeRank = [[UIView alloc] initWithFrame:CGRectMake(271,74,20,20)];
    self.badgeRank.layer.cornerRadius = 10;
    self.badgeRank.backgroundColor = [UIColor redColor];
    [self.badgeRank addSubview:numberRank];
    numberRank.bounds = [self.badgeRank bounds];
    numberRank.center = CGPointMake(self.badgeRank.frame.size.width / 2, self.badgeRank.frame.size.height / 2);
    
    UISwipeGestureRecognizer *leftRecognizer;
    leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftRecognizer setDirection: UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:leftRecognizer];
    
    UISwipeGestureRecognizer *rightRecognizer;
    rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [rightRecognizer setDirection: UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:rightRecognizer];
    
    self.inlineQuestions = [NSArray arrayWithObjects:@"inlineq3",@"inlineq4", @"inlineq6", @"inlineq7", nil];
    
    self.pregameQuestions = [NSArray arrayWithObjects:@"betCut", @"inlineq5", @"inlineq8", nil];
}

- (IBAction)invitePressed:(id)sender
{
    if ([UIAlertController class])
    {
        // use UIAlertController
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Which way you preffer to invite more friends?"
                                   message:@""
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *whatsapp = [UIAlertAction actionWithTitle:@"WhatsApp" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                     
                                                       NSURL *whatsappURL = [NSURL URLWithString:@"whatsapp://send?text=chatbet://joinMyGroup"];
                                                       if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
                                                           [[UIApplication sharedApplication] openURL: whatsappURL];
                                                       }
                                                       
                                                   }];
        
        UIAlertAction *sms = [UIAlertAction actionWithTitle:@"SMS" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       
                                                       if([MFMessageComposeViewController canSendText]) {
                                                           MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
                                                           controller.body = @"chatbet://joinMyGroup";
                                                           
                                                           controller.messageComposeDelegate = self;
                                                           [self presentViewController:controller animated:YES completion:nil];
                                                       }
                                                       
                                                   }];
        
        UIAlertAction *contacts = [UIAlertAction actionWithTitle:@"Contacts" style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action){
                                                        
                                                        
                                                        
                                                    }];

        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                           
                                                       }];
        
        [alert addAction:whatsapp];
        [alert addAction:sms];
        [alert addAction:contacts];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else
    {
    
        
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    switch(result) {
        case MessageComposeResultCancelled:
            // user canceled sms
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case MessageComposeResultSent:
            // user sent sms
            //perhaps put an alert here and dismiss the view on one of the alerts buttons
            break;
        case MessageComposeResultFailed:
            // sms send failed
            //perhaps put an alert here and dismiss the view when the alert is canceled
            break;
        default:
            break;
    }
}

- (void)handleSwipeFrom:(UISwipeGestureRecognizer *)gest
{
    if (!self.hasSeenMoneyMessage) //pregame
    {
        if (gest.direction == UISwipeGestureRecognizerDirectionLeft)
        {
            if (self.inlineQuestionsIndex == 2)
            {
                self.inlineQuestionsIndex = 0;
            }
            else
            {
                self.inlineQuestionsIndex += 1;
            }
        }
        else
        {
            if (self.inlineQuestionsIndex == 0)
            {
                self.inlineQuestionsIndex = 2;
            }
            else
            {
                self.inlineQuestionsIndex -= 1;
            }
        }
        [self.betTitleQuestionsNumbers setText:[NSString stringWithFormat:@"%d/3", self.inlineQuestionsIndex + 1]];
        NSString *imageName = [self.pregameQuestions objectAtIndex:self.inlineQuestionsIndex];
        [self.buttomImage setImage:[UIImage imageNamed:imageName]];
    }
    else
    {
        if (gest.direction == UISwipeGestureRecognizerDirectionLeft)
        {
            if (self.inlineQuestionsIndex == 3)
            {
                self.inlineQuestionsIndex = 0;
            }
            else
            {
                self.inlineQuestionsIndex += 1;
            }
        }
        else
        {
            if (self.inlineQuestionsIndex == 0)
            {
                self.inlineQuestionsIndex = 3;
            }
            else
            {
                self.inlineQuestionsIndex -= 1;
            }
        }
        [self.betTitleQuestionsNumbers setText:[NSString stringWithFormat:@"%d/4", self.inlineQuestionsIndex + 1]];
        NSString *imageName = [self.inlineQuestions objectAtIndex:self.inlineQuestionsIndex];
        [self.buttomImage setImage:[UIImage imageNamed:imageName]];
    }
}

//- (void)updateCountdown
//{
//    int hours, minutes, seconds;
//    
//    self.secondsLeftForBadgeDisplay--;
//    hours = self.secondsLeftForBadgeDisplay / 3600;
//    minutes = (self.secondsLeftForBadgeDisplay % 3600) / 60;
//    seconds = (self.secondsLeftForBadgeDisplay %3600) % 60;
//    countDownlabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
//}

- (void)animateBadge:(UIView *)badge shouldHide:(BOOL)hide withNumber:(int)number
{
    if (hide)
    {
        [badge removeFromSuperview];
    }
    else
    {
        UILabel *label =  (UILabel *)[badge viewWithTag:123];
        label.text = [NSString stringWithFormat:@"%d", number];
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anim.duration = 0.155;
        anim.repeatCount = 1;
        anim.autoreverses = YES;
        anim.removedOnCompletion = YES;
        anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3, 1.3, 1.0)];
        [badge.layer addAnimation:anim forKey:nil];
        [self.view addSubview:badge];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self animateBadge:self.badgeBet shouldHide:NO withNumber:1];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chatPressed:(id)sender
{
    [self animateBadge:self.badgeChat shouldHide:YES withNumber:0];
    self.buttom.hidden = YES;
    self.rank.selected = NO;
    self.bet.selected = NO;
    self.chat.selected = YES;
    self.buttonsView.hidden = YES;
    self.storeBtn.hidden = YES;

    
    [self.timerForBadgeDisplay invalidate];
    self.timerForBadgeDisplay = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(showBadgeOn:) userInfo:self.badgeBet repeats:NO];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (IBAction)betPressed:(id)sender
{
    ++_counterForBetPressed;
    if (_counterForBetPressed > 1)
    {
        self.hasSeenMoneyMessage = YES;
    }
    [self animateBadge:self.badgeBet shouldHide:YES withNumber:0];
    self.betTitleQuestions.hidden = NO;
    
    self.buttom.hidden = NO;
    self.bet.selected = YES;
    self.rank.selected = NO;
    self.chat.selected = NO;
    self.storeBtn.hidden = NO;
    
    [self.timerForBadgeDisplay invalidate];
    self.timerForBadgeDisplay = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(showBadgeOn:) userInfo:self.badgeChat repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:35.0 target:self selector:@selector(showBadgeOn:) userInfo:self.badgeRank repeats:NO];
    if (!self.hasSeenMoneyMessage)
    {
        [self.betTitleQuestions setText:@"PREGAME QUESTIONS"];
        [self.buttomImage setImage:[UIImage imageNamed:@"betCut"]];
        self.buttonsView.hidden = NO;
        [self.betTitleQuestionsNumbers setText:[NSString stringWithFormat:@"1/3"]];

    }
    else
    {
        [self.betTitleQuestions setText:@"IN PLAY QUESTIONS"];
        [self.buttomImage setImage:[UIImage imageNamed:@"inlineq3"]];
        self.buttonsView.hidden = NO;
        self.betTitleQuestionsNumbers.hidden = NO;
        [self.betTitleQuestionsNumbers setText:[NSString stringWithFormat:@"1/4"]];
        
    }
}

- (IBAction)storeBtnPressed:(id)sender
{
    UIImageView *storeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popup"]];
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self view:storeView];
    [modal show];
}

- (void)showBadgeOn:(NSTimer *)timer
{
    [self animateBadge:timer.userInfo shouldHide:NO withNumber:7];
}

- (IBAction)rankPressed:(id)sender
{
    self.betTitleQuestions.hidden = YES;
    self.betTitleQuestionsNumbers.hidden = YES;
    [self animateBadge:self.badgeRank shouldHide:YES withNumber:0];
    [self.buttomImage setImage:[UIImage imageNamed:@"winCut"]];
    self.buttom.hidden = NO;
    self.rank.selected = YES;
    self.bet.selected = NO;
    self.chat.selected = NO;
    self.buttonsView.hidden = YES;
    self.storeBtn.hidden = YES;
}

- (void)showMoneyMessage
{
    if (!self.hasSeenMoneyMessage)
    {
//        RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:self title:@"Daniel Challenged You!" message:@"Enter fee 5$" andPositiveTitle:@"I'm in!"];
//        [modal show];
    }
    
}

- (IBAction)betButton1Pressed:(id)sender
{
    [self showMoneyMessage];
    self.betButton1.selected = YES;
    self.betButton2.selected = NO;
    self.betButton3.selected = NO;
}

- (IBAction)betButton2Pressed:(id)sender
{
    [self showMoneyMessage];

    self.betButton1.selected = NO;
    self.betButton2.selected = YES;
    self.betButton3.selected = NO;
    
}

- (IBAction)unwind:(id)sender
{
    [self performSegueWithIdentifier:@"unwindToStart" sender:self];
}

- (IBAction)betButton3Pressed:(id)sender
{
    [self showMoneyMessage];

    self.betButton1.selected = NO;
    self.betButton2.selected = NO;
    self.betButton3.selected = YES;
}

@end
