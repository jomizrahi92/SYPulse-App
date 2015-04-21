//
//  DetailTableViewController.m
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/2/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//
/*

#import "DetailTableViewController.h"
#import "NSString+HTML.h"
#import "WebViewController.h"
#import "SVWebViewController.h"

typedef enum { SectionTitle, SectionDate, SectionDetail, SectionImage, SectionURL } Sections;
typedef enum { SectionHeaderTitle } TitleRows;
typedef enum { SectionHeaderDate } DateRows;
typedef enum { SectionDetailSummary } DetailRows;
typedef enum { SectionImageView } ImageRow;
typedef enum { SectionURLView } URLRow;

@implementation DetailTableViewController

@synthesize item, dateString, summaryString;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
		
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	// Super
    [super viewDidLoad];

	// Date
	if (item.date) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		self.dateString = [formatter stringFromDate:item.date];
		[formatter release];
	}
	
	// Summary
	if (item.summary) {
		self.summaryString = [item.summary stringByConvertingHTMLToPlainText];
	} else {
		self.summaryString = @"[No Summary]";
	}
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    //[tableView setBackgroundColor:[UIColor blackColor]];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableViewBackground.png"]];
    self.tableView.backgroundColor = background;
    [background release];
    
    tableView.opaque = NO;
    return 5;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (section) {
		case 0: return 1;
		default: return 1;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // Get cell
	static NSString *CellIdentifier = @"CellA";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	// Display
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
    //cell.backgroundColor = [UIColor orangeColor];

	if (item) {
		
		// Item Info
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		
		// Display
		switch (indexPath.section) {
			//case SectionHeader: {
				
				// Header
				//switch (indexPath.row) {
            case SectionTitle:{
                        cell.textLabel.textAlignment = UITextAlignmentCenter;
						cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
						cell.textLabel.text = itemTitle;
                        cell.textLabel.numberOfLines = 0; // Multiline
                        break;
            }
            case SectionDate:{
                        cell.textLabel.textAlignment = UITextAlignmentCenter;
						cell.textLabel.text = dateString ? dateString : @"[No Date]";
						break;
            }
				//}
				//break;
				
			//}
			case SectionDetail: {
				
				// Summary
				cell.textLabel.text = summaryString;
				cell.textLabel.numberOfLines = 0; // Multiline
				break;
				
			}
                
            case SectionImage: {
                cell.textLabel.text = @"Video/Image Here";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
				cell.textLabel.numberOfLines = 0; // Multiline
				break;
				
			}
                
            case SectionURL: {
                cell.textLabel.text = item.link ? item.link : @"[No Link]";
                cell.textLabel.textColor = [UIColor blueColor];
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                break;
            }
		}
	}
    
    return cell;
	
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == SectionURL){

        UILabel *lbl = [[[UILabel alloc] init] autorelease];
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        lbl.text = @"Read More";
        lbl.textColor = [UIColor whiteColor];
        lbl.shadowColor = [UIColor grayColor];
        lbl.shadowOffset = CGSizeMake(0,1);
        lbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackground.png"]];
        //lbl.alpha = 0.9;
        return lbl;
    }
    else {
        UILabel *lbl = [[[UILabel alloc] init] autorelease];
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        lbl.text = @"";
        lbl.textColor = [UIColor whiteColor];
        lbl.shadowColor = [UIColor grayColor];
        lbl.shadowOffset = CGSizeMake(0,1);
        lbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackground.png"]];
        //lbl.alpha = 0.9;
        return lbl;
    }
        
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == SectionTitle){
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        NSString *title = @"[No Title]";
		if (itemTitle) title = itemTitle;
		CGSize s = [title sizeWithFont:[UIFont systemFontOfSize:15] 
                     constrainedToSize:CGSizeMake(self.view.bounds.size.width - 100, MAXFLOAT)  // - 40 For cell padding
                         lineBreakMode:UILineBreakModeWordWrap];
		return s.height + 25; // Add padding //16
    }
    
    else if (indexPath.section == SectionDate) {
        
		// Regular
		return 34;
    }     
    else if (indexPath.section == SectionImage) {
        return 34;

    }
    
    else if (indexPath.section == SectionURL) {
        return 34;
        
    }
    
    else {
		
		// Get height of summary
		NSString *summary = @"[No Summary]";
		if (summaryString) summary = summaryString;
		CGSize s = [summary sizeWithFont:[UIFont systemFontOfSize:15] 
					   constrainedToSize:CGSizeMake(self.view.bounds.size.width - 40, MAXFLOAT)  // - 40 For cell padding
						   lineBreakMode:UILineBreakModeWordWrap];
		return s.height + 16; // Add padding //16
		
	}
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	// Open URL
	if (indexPath.section == SectionURL) {// && indexPath.row == SectionHeaderURL
        //		if (item.link) {
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.link]];
        // Show detail
      /*  
        WebViewController *webview = [[WebViewController alloc] init];
       // SVWebViewController *webview = [[SVWebViewController alloc] init];
        webview.urlString = item.link;
        webview.titleString = item.title;
        [self.navigationController pushViewController:webview animated:YES];
        [self.navigationController setTitle:item.title];
        [webview release];
        //		}
       */
    /*    
        
        NSURL *URL = [NSURL URLWithString: item.link];
        SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
        [self.navigationController pushViewController:webViewController animated:YES];

	}
	
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[dateString release];
	[summaryString release];
	[item release];
    [super dealloc];
}


@end
*/


//
//  DetailTableViewController.m
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/2/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//


#import "DetailTableViewController.h"
#import "NSString+HTML.h"
#import "WebViewController.h"
#import "SVWebViewController.h"

typedef enum { SectionHeader } Sections;
typedef enum { SectionHeaderTitle, SectionHeaderDate, SectionDetailSummary, SectionImageView, SectionURLView } HeaderRows;

@implementation DetailTableViewController

@synthesize item, dateString, summaryString;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {
    if ((self = [super initWithStyle:style])) {
		
    }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
	
	// Super
    [super viewDidLoad];
    
	// Date
	if (item.date) {
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateStyle:NSDateFormatterMediumStyle];
		[formatter setTimeStyle:NSDateFormatterMediumStyle];
		self.dateString = [formatter stringFromDate:item.date];
		[formatter release];
	}
	
	// Summary
	if (item.summary) {
		self.summaryString = [item.summary stringByConvertingHTMLToPlainText];
       // self.summaryString = [item.summary stringByLinkifyingURLs];
	} else {
		self.summaryString = @"[No Summary]";
	}
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    //[tableView setBackgroundColor:[UIColor blackColor]];
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableViewBackground.png"]];
    self.tableView.backgroundColor = background;
    [background release];
    
    tableView.opaque = NO;
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	switch (section) {
		case 0: return 5;
		default: return 5;
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get cell
	static NSString *CellIdentifier = @"CellA";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	
	// Display
	cell.textLabel.textColor = [UIColor blackColor];
	cell.textLabel.font = [UIFont systemFontOfSize:15];
    //cell.backgroundColor = [UIColor orangeColor];
    
	if (item) {
		
		// Item Info
		NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
		
		// Display
		switch (indexPath.section) {
                case SectionHeader: {
				
				// Header
				switch (indexPath.row) {
                        
            case SectionHeaderTitle:{
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.font = [UIFont boldSystemFontOfSize:20];
                cell.textLabel.text = itemTitle;
                cell.textLabel.numberOfLines = 0; // Multiline
                break;
            }
            case SectionHeaderDate:{
                cell.textLabel.textAlignment = UITextAlignmentCenter;
                cell.textLabel.text = dateString ? dateString : @"[No Date]";
                break;
            }
				
                //}
			case SectionDetailSummary: {
				
				// Summary
				cell.textLabel.text = summaryString;
				cell.textLabel.numberOfLines = 0; // Multiline
				break;
				
			}
                
            case SectionImageView: {
                cell.textLabel.text = @"Video/Image Here";
                cell.textLabel.textAlignment = UITextAlignmentCenter;
				cell.textLabel.numberOfLines = 0; // Multiline
				break;
				
			}
                
            case SectionURLView: {
                cell.textLabel.text = item.link ? item.link : @"[No Link]";
                cell.textLabel.textColor = [UIColor blueColor];
                cell.selectionStyle = UITableViewCellSelectionStyleBlue;
                break;
            }
            
            break;
                
                }
            }
		}
	}
    
    return cell;
	
}
/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(section == SectionURLView){
        
        UILabel *lbl = [[[UILabel alloc] init] autorelease];
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        lbl.text = @"Read More";
        lbl.textColor = [UIColor whiteColor];
        lbl.shadowColor = [UIColor grayColor];
        lbl.shadowOffset = CGSizeMake(0,1);
        lbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackground.png"]];
        //lbl.alpha = 0.9;
        return lbl;
    }
    else {
        UILabel *lbl = [[[UILabel alloc] init] autorelease];
        lbl.textAlignment = UITextAlignmentCenter;
        lbl.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        lbl.text = @"";
        lbl.textColor = [UIColor whiteColor];
        lbl.shadowColor = [UIColor grayColor];
        lbl.shadowOffset = CGSizeMake(0,1);
        lbl.backgroundColor = [UIColor clearColor];//[UIColor colorWithPatternImage:[UIImage imageNamed:@"TableViewBackground.png"]];
        //lbl.alpha = 0.9;
        return lbl;
    }
    
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == SectionHeaderTitle){
        NSString *itemTitle = item.title ? [item.title stringByConvertingHTMLToPlainText] : @"[No Title]";
        NSString *title = @"[No Title]";
		if (itemTitle) title = itemTitle;
		CGSize s = [title sizeWithFont:[UIFont systemFontOfSize:15] 
                     constrainedToSize:CGSizeMake(self.view.bounds.size.width - 100, MAXFLOAT)  // - 40 For cell padding
                         lineBreakMode:UILineBreakModeWordWrap];
		return s.height + 25; // Add padding //16
    }
    
    else if (indexPath.row == SectionDetailSummary){
		
		// Get height of summary
		NSString *summary = @"[No Summary]";
		if (summaryString) summary = summaryString;
		CGSize s = [summary sizeWithFont:[UIFont systemFontOfSize:15] 
					   constrainedToSize:CGSizeMake(self.view.bounds.size.width - 40, MAXFLOAT)  // - 40 For cell padding
						   lineBreakMode:UILineBreakModeWordWrap];
		return s.height + 16; // Add padding //16
		
	}
    else 
        return 34;
    /*
    else if (indexPath.row == SectionHeaderDate) {
        
		// Regular
		return 34;
    }     
    else if (indexPath.row == SectionImageView) {
        return 34;
        
    }
    
    else if (indexPath.row == SectionURLView) {
        return 34;
        
    }
     */

}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Open URL
	if (indexPath.row == SectionURLView) {// && indexPath.row == SectionHeaderURL
        //		if (item.link) {
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:item.link]];
        // Show detail
        /*  
         WebViewController *webview = [[WebViewController alloc] init];
         // SVWebViewController *webview = [[SVWebViewController alloc] init];
         webview.urlString = item.link;
         webview.titleString = item.title;
         [self.navigationController pushViewController:webview animated:YES];
         [self.navigationController setTitle:item.title];
         [webview release];
         //		}
         */
        
        
        NSURL *URL = [NSURL URLWithString: item.link];
        SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
        webViewController.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController:webViewController animated:YES];

	}
	
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[dateString release];
	[summaryString release];
	[item release];
    [super dealloc];
}


@end