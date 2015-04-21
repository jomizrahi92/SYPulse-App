//
//  ThirdViewController.h
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/2/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryViewController.h"

@interface ThirdViewController : UITableViewController <UISearchBarDelegate>
{
    CategoryViewController *detailViewController;
    NSMutableDictionary *data;

}

@property(nonatomic, retain)CategoryViewController *detailViewController;
@property (nonatomic, retain) NSMutableDictionary *data;

@end
