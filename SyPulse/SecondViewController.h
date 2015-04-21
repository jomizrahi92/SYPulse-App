//
//  SecondViewController.h
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/2/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"
#import "EGORefreshTableHeaderView.h"


@interface SecondViewController : UITableViewController <MWFeedParserDelegate, EGORefreshTableHeaderDelegate> {
	
	// Parsing
	MWFeedParser *feedParser;
	NSMutableArray *parsedItems;
	
	// Displaying
	NSArray *itemsToDisplay;
	NSDateFormatter *formatter;
    
    BOOL _reloading;

}

// Properties
@property (nonatomic, retain) NSArray *itemsToDisplay;
@property (strong) EGORefreshTableHeaderView *refreshHeaderView;

@end
