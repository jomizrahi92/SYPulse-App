//
//  ThirdViewController.m
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/2/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController;


@synthesize detailViewController;
@synthesize data;

- (void)viewDidLoad
{
    self.title = @"Categories";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    NSData *theData = [[NSData alloc] initWithContentsOfFile:path];
    
    NSPropertyListFormat format;
    NSString *error;
    
    NSDictionary *dic = [NSPropertyListSerialization propertyListFromData:theData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];
    
    data = [[dic objectForKey:@"Categories"] mutableCopy];
    NSLog(@"data = %@", data);


    [super viewDidLoad];
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // [tableView setBackgroundColor:[UIColor blackColor]];
	
    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"TableViewBackground.png"]];
    self.tableView.backgroundColor = background;
    [background release];
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   // return [data count];  
    
    int count = 0;
    for (id something in data)
        count++;
    
    NSLog(@"%d", count);
    
    return count;

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

	//cell.textLabel.text = [NSString stringWithFormat:@"%@", [[data allKeys] objectAtIndex:indexPath.row]];
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    
    for (id object in data)
        [mArray addObject:object];
    
    mArray = [mArray sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    cell.textLabel.text = [mArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.textColor = [UIColor blackColor];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *title = selectedCell.textLabel.text;
    NSLog(title);
    

	CategoryViewController *detail = [[CategoryViewController alloc] initWithStyle:UITableViewStyleGrouped];
       	/*NSString *selectedCategory = [[[data valueForKey:selectedNews] allKeys] objectAtIndex:indexPath.row];
        detail.title = selectedCategory;
        detail.rss = [[data valueForKey:selectedNews] valueForKey:selectedCategory];*/
    
    detail.title = title;
    detail.rss = [data objectForKey:title];

	[self.navigationController pushViewController:detail animated:YES];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [detailViewController release];
    [data release];
    [super dealloc];
}

@end
