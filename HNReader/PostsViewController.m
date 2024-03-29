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

@property (nonatomic, strong) NSString *sourceURL;

@end

@implementation PostsViewController

@synthesize sourceURL = _sourceURL;

- (NSString *)sourceURL {
    if (_sourceURL == nil) _sourceURL = @"http://hndroidapi.appspot.com/news/format/json/page/?appid=hnreader";
    return _sourceURL;
}

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

- (id)initWithSourceURL:(NSString *)sourceURL
{
    self = [super init];
    if (self) self.sourceURL = sourceURL;
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
    
    posts = [[NSMutableArray alloc] init];
    
    // retrieve the titles
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    //NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api.ihackernews.com/page"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.sourceURL]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSDictionary *json_data = [parser objectWithString:json_string error:nil];
    
    // update posts and links array
    
    for (NSDictionary *item in [json_data objectForKey:@"items"])
    {
        NSLog(@"Processing: %@", [item objectForKey:@"title"]);
        NSMutableDictionary *post = [[NSMutableDictionary alloc] init];
        
        NSString *title = [item objectForKey:@"title"];
        NSLog(@"Title: %@", title);
        if (self.tabBarItem.tag == 2) {
            // further processing for ask hn
            if ([title isEqualToString:@"Ask HN:"] || [title isEqualToString:@"Ask HN"]) {
                // just show the text for empty title
                title = [item objectForKey:@"text"];
            } else {
                title = [title stringByReplacingOccurrencesOfString:@"Ask HN: " withString:@""];
            } 
        }
        // trim
        title = [title stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [post setObject:title forKey:@"title"];
        
        [post setObject:[item objectForKey:@"url"] forKey:@"url"];
        [posts addObject:post];
    }
    
    NSLog(@"Source URL: %@", self.sourceURL);
    [self.tableView reloadData];
    [spinner stopAnimating];
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
    
    NSMutableDictionary *post = [posts objectAtIndex:indexPath.row];
    cell.textLabel.text = [post objectForKey:@"title"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - Table view delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // save the url data
    NSMutableDictionary *post = [posts objectAtIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:post forKey:@"post"];
    
    // load the view
    ContentViewController *cvc = [[ContentViewController alloc] init];
    cvc.navigationItem.title = [post objectForKey:@"title"];
    [(UINavigationController *)self.parentViewController.parentViewController pushViewController:cvc animated:YES];
}

@end
