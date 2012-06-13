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
@synthesize wView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // load from data source
    [[NSUserDefaults standardUserDefaults] synchronize];

    // load the page
    NSURL *url = [NSURL URLWithString:[[NSUserDefaults standardUserDefaults] objectForKey:@"url"]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	[wView loadRequest:requestObj];
	wView.scalesPageToFit = YES;
}

- (void)viewDidUnload
{
    [self setWView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
