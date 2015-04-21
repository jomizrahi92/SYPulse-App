//
//  FourthViewController.h
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/2/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FourthViewController : UIViewController <UIWebViewDelegate> {
	
    IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
    int homeFinishedLoading;
    
}

@property(nonatomic,retain) UIWebView *webView;
@property(nonatomic,retain) UIActivityIndicatorView *activityIndicator;

- (IBAction)twitterButton:(id)sender;
- (IBAction)facebookButton:(id)sender;

@end
