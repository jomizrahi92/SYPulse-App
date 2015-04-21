//
//  LoadingViewController.m
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/5/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//

#import "LoadingViewController.h"

@interface LoadingViewController ()

- (void)perform;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(perform) userInfo:nil repeats:NO];
}

- (void)perform {
    [self performSegueWithIdentifier:@"toTabController" sender:self];
}

@end
