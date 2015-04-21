//
//  CategoryViewController.h
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/11/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
#import "EGORefreshTableHeaderView.h"
@class ThirdViewController;

@interface CategoryViewController : UITableViewController <MWFeedParserDelegate, EGORefreshTableHeaderDelegate> {
	
	// Parsing
	MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	
	// Displaying
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;
    
    NSString *variableNameHere;
    
    BOOL _reloading;
    
    ThirdViewController *third;
    NSString *rss;

}

// Properties
@property (nonatomic, retain) NSArray *itemsToDisplay;
@property (strong) EGORefreshTableHeaderView *refreshHeaderView;

@property (nonatomic, retain) NSString *variableNameHere;

@property (nonatomic, retain) ThirdViewController *third;
@property (nonatomic, retain) NSString *rss;

@end
