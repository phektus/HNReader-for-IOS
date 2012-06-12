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
@synthesize navBar;

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
    NSString *myTitle = [[NSUserDefaults standardUserDefaults] objectForKey:@"title"];
    NSString *myUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"url"];
    
    NSLog(@"%@: %@", myTitle, myUrl);
    navBar.title = myTitle;
    
    // load the page
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:myUrl]];
	[wView loadRequest:requestObj];
	wView.scalesPageToFit = YES;
}

- (void)viewDidUnload
{
    [self setWView:nil];
    [self setNavBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)dismiss:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"url"];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)reload:(id)sender {
    [wView reload];
}
@end
