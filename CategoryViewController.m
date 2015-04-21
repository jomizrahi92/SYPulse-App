//
//  CategoryViewController.m
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/11/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//


#import "CategoryViewController.h"
#import "NSString+HTML.h"
#import "MWFeedParser.h"
#import "DetailTableViewController.h"
#import "SVProgressHUD.h"
#import "ThirdViewController.h"


@implementation CategoryViewController
@synthesize itemsToDisplay, refreshHeaderView = _refreshHeaderView;
@synthesize third, rss;

#pragma mark -
#pragma mark View lifecycle

- (void)loadView
{
    NSLog(@"Loading loadView");
    [super loadView];
    
    /*
     * Load EGORefreshTableHeaderView
     */
    if (_refreshHeaderView == nil) 
    {
        NSLog(@"Loading EGORefreshTableHeaderView");
        
        //EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height) arrowImageName:@"blackArrow.png" textColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0]];
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
        [self.tableView addSubview:view];
		_refreshHeaderView = view;
        [view release];
        
	}
    
    // Update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
    
}


- (void)viewDidLoad {
	// Super
	[super viewDidLoad];
	
    // [SVProgressHUD showInView:self.view];
    [self.tableView addSubview:_refreshHeaderView];
    
	// Setup
    variableNameHere = self.title;
	self.title = @"Loading...";
	formatter = [[NSDateFormatter alloc] init];
	[formatter setDateStyle:NSDateFormatterShortStyle];
	[formatter setTimeStyle:NSDateFormatterShortStyle];
	parsedItems = [[NSMutableArray alloc] init];
	self.itemsToDisplay = [NSArray array];
    [SVProgressHUD showInView:self.view];
    
	/*
     // Refresh button
     self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
     target:self 
     action:@selector(refresh)] autorelease];
     */
    // Parse
	NSURL *feedURL = [NSURL URLWithString:rss];
	feedParser = [[MWFeedParser alloc] initWithFeedURL:feedURL];
	feedParser.delegate = self;
	feedParser.feedParseType = ParseTypeFull; // Parse feed info and all items
	feedParser.connectionType = ConnectionTypeAsynchronously;
	[feedParser parse];
    
}

#pragma mark -
#pragma mark Parsing

// Reset and reparse
- (void)refresh {
    variableNameHere = self.title;
	self.title = @"Refreshing...";
	[parsedItems removeAllObjects];
	[feedParser stopParsing];
	[feedParser parse];
	self.tableView.userInteractionEnabled = NO;
//	self.tableView.alpha = 0.3;
}

- (void)updateTableWithParsedItems {
    //self.title = variableNameHere;
	self.itemsToDisplay = [parsedItems sortedArrayUsingDescriptors:
						   [NSArray arrayWithObject:[[[NSSortDescriptor alloc] initWithKey:@"date" 
																				 ascending:NO] autorelease]]];
	self.tableView.userInteractionEnabled = YES;
	//self.tableView.alpha = 1;
	[self.tableView reloadData];
    [SVProgressHUD dismiss];
    
}

#pragma mark -
#pragma mark MWFeedParserDelegate

- (void)feedParserDidStart:(MWFeedParser *)parser {
	NSLog(@"Started Parsing: %@", parser.url);
}

- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info {
	NSLog(@"Parsed Feed Info: “%@”", info.title);
	self.title = variableNameHere;

}

- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
	NSLog(@"Parsed Feed Item: “%@”", item.title);
	if (item) [parsedItems addObject:item];	
}

- (void)feedParserDidFinish:(MWFeedParser *)parser {
	NSLog(@"Finished Parsing%@", (parser.stopped ? @" (Stopped)" : @""));
    [self updateTableWithParsedItems];
}

- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"Finished Parsing With Error: %@", error);
    if (parsedItems.count == 0) {
        self.title = @"Failed"; // Show failed message in title
    } else {
        // Failed but some items parsed, so show and inform of error
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Parsing Incomplete"
                                                         message:@"There was an error during the parsing of this feed. Not all of the feed items could parsed."
                                                        delegate:nil
                                               cancelButtonTitle:@"Dismiss"
                                               otherButtonTitles:nil] autorelease];
        [alert show];
    }
    [self updateTableWithParsedItems];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{	
	return _reloading; // should return if data source model is reloading	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{	
	return [NSDate date]; // should return date data source was last changed	
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource
{	
    NSLog(@"Pull To Refresh");
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
    [self refresh];
    
}

- (void)doneLoadingTableViewData
{	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //[tableView setBackgroundColor:[UIColor blackColor]];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableViewBackground.png"]];
    self.tableView.backgroundColor = background;
    [background release];
    
    tableView.opaque = NO;
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return itemsToDisplay.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = (UITableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    tableView.separatorColor = [UIColor grayColor];

    // Configure the cell.
	MWFeedItem *item = [itemsToDisplay objectAtIndex:indexPath.row];
	if (item) {
		
		// Process
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        
		//NSString *itemSummary = item.summary ? [item.summary stringByConvertingHTMLToPlainText] : @"[No Summary]";
		
		// Set
		cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
		cell.textLabel.text = itemTitle;
        cell.textLabel.textColor = [UIColor blackColor];
        
        NSMutableString *subtitle = [NSMutableString string];
		if (item.date) [subtitle appendFormat:@"%@", [formatter stringFromDate:item.date]];
		cell.detailTextLabel.text = subtitle;
        
        /*
         NSMutableString *subtitle = [NSMutableString string];
         if (item.date) [subtitle appendFormat:@"%@: ", [formatter stringFromDate:item.date]];
         [subtitle appendString:itemSummary];
         cell.detailTextLabel.text = subtitle;
         */
        
	}
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     if (indexPath.row == 0) {
     return 70;
     }else {
     return 70;
     }	
     */
    return 55;
} 

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Show detail
	DetailTableViewController *detail = [[DetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
	detail.item = (MWFeedItem *)[itemsToDisplay objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:detail animated:YES];
	[detail release];
	
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //   [SVProgressHUD showInView:self.view];
    
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
	_refreshHeaderView = nil;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[formatter release];
	[parsedItems release];
	[itemsToDisplay release];
	[feedParser release];
    _refreshHeaderView = nil;
    [super dealloc];
}

@end