//
//  PostsViewController.m
//  HNReader
//
//  Created by Arbie Samong on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PostsViewController.h"
#import "ContentViewController.h"
#import "SBJson.h"

@interface PostsViewController ()

@end

@implementation PostsViewController

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
    
    posts = [[NSMutableArray alloc] init];
    links = [[NSMutableArray alloc] init];
    
    // retrieve the titles
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.ihackernews.com/page"]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSDictionary *json_data = [parser objectWithString:json_string error:nil];
    
    // update posts and links array
    for (NSDictionary *item in [json_data objectForKey:@"items"])
    {
        [posts addObject:[item objectForKey:@"title"]];
        [links addObject:[item objectForKey:@"url"]];
    }
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [posts objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // save the url data
    [[NSUserDefaults standardUserDefaults] setObject:[posts objectAtIndex:indexPath.row] forKey:@"title"];
    [[NSUserDefaults standardUserDefaults] setObject:[links objectAtIndex:indexPath.row] forKey:@"url"];
    
    // load the view
    ContentViewController *cvc = [[ContentViewController alloc] init];
    [self presentModalViewController:cvc animated:YES];
}

@end
