//
//  ContentViewController.m
//  HNReader
//
//  Created by Arbie Samong on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        spinner = [[UIActivityIndicatorView alloc] 
                   initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        spinner.center = CGPointMake(160, 150);
        spinner.hidesWhenStopped = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:spinner];
    [spinner startAnimating];  
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // load from data source
    [[NSUserDefaults standardUserDefaults] synchronize];

    // load the page
    NSDictionary *post = [[NSUserDefaults standardUserDefaults] objectForKey:@"post"];
    NSURL *url = [NSURL URLWithString:[post objectForKey:@"url"]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[wView loadRequest:requestObj];
	wView.scalesPageToFit = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"web view finished loading");
    [spinner stopAnimating];  
}

@end
