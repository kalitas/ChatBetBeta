//
//  CBSettingsViewController.m
//  chatBet
//
//  Created by dan g / applicaster on 9/18/14.
//  Copyright (c) 2014 chat bet ltd. All rights reserved.
//

#import "CBSettingsViewController.h"
#import "CBAppDelegate.h"

@interface CBSettingsViewController ()

@end

@implementation CBSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style: UIBarButtonItemStylePlain target:nil action:nil];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CBAppDelegate *appDelegate = (CBAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if ([appDelegate urlOpened] == YES)
    {
        [self.buttomFriends sendActionsForControlEvents:UIControlEventTouchUpInside];
        appDelegate.urlOpened = NO;
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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style: UIBarButtonItemStylePlain target:self action:@selector(backPressed)];
}


@end
