//
//  FourthViewController.m
//  SyPulse
//
//  Created by Joseph Mizrahi on 4/2/12.
//  Copyright (c) 2012 Self Employed and Loving It!. All rights reserved.
//

#import "FourthViewController.h"

@interface FourthViewController ()

@end

@implementation FourthViewController

@synthesize webView, activityIndicator;

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"Home started loading.");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; 
    homeFinishedLoading = 0;
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"Home finished loading.");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO]; 
    homeFinishedLoading = 1;

}


- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *urlAddress = @"http://www.sypulse.org/about/";
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:requestObj];
}


-(IBAction) goBack:(id)sender {
    [webView goBack];
}

-(IBAction) goForward:(id)sender {
    [webView goForward];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)twitterButton:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/sypulse"]]; 
}
- (IBAction)facebookButton:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/profile.php?id=100002689727950"]]; 
}

@end