//
//  DetailTableViewController.m
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/2/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MWFeedItem.h"

@interface DetailTableViewController : UITableViewController {
	MWFeedItem *item;
	NSString *dateString, *summaryString;
}

@property (nonatomic, retain) MWFeedItem *item;
@property (nonatomic, retain) NSString *dateString, *summaryString;

@end
