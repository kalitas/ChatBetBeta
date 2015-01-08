//
//  CBTournamentTypeViewController.m
//  chatBet
//
//  Created by dan g / applicaster on 9/12/14.
//  Copyright (c) 2014 chat bet ltd. All rights reserved.
//

#import "CBTournamentTypeViewController.h"
#import "CBAppDelegate.h"

@interface CBTournamentTypeViewController ()
{
    int secondsLeft;
    NSTimer *timer;
    IBOutlet UILabel *countDownlabel;
}
@end

@implementation CBTournamentTypeViewController

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
    secondsLeft = 800;
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
}

- (void)updateCountdown
{
    int hours, minutes, seconds;
    
    secondsLeft--;
    hours = secondsLeft / 3600;
    minutes = (secondsLeft % 3600) / 60;
    seconds = (secondsLeft %3600) % 60;
    countDownlabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style: UIBarButtonItemStylePlain target:nil action:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CBAppDelegate *appDelegate = (CBAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate urlOpened] == YES)
    {
        [self.buttomFriends sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style: UIBarButtonItemStylePlain target:nil action:nil];}



@end
