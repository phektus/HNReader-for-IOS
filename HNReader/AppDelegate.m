//
//  AppDelegate.m
//  HNReader
//
//  Created by Arbie Samong on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "PostsViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    nc = [[UINavigationController alloc] init];
    [nc.navigationBar setTintColor:[UIColor orangeColor]];
    
    UITabBarController *tc = [[UITabBarController alloc] init];
    tc.navigationItem.title = @"Hacker News";
    
    PostsViewController *pvcFront = [[PostsViewController alloc] initWithSourceURL:@"http://api.ihackernews.com/page" sourceType:@"ihackernews"];
    pvcFront.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Top Items" image:nil tag:0];
        
    PostsViewController *pvcNewest = [[PostsViewController alloc] initWithSourceURL:@"http://api.thriftdb.com/api.hnsearch.com/items/_search?sort_by=score&filter[fields][type]=submission" sourceType:@"hnsearch"];
    pvcNewest.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Newest" image:nil tag:1];
    
    PostsViewController *pvcAsk = [[PostsViewController alloc] initWithSourceURL:@"http://api.thriftdb.com/api.hnsearch.com/items/_search?q=ask%20hn&sort_by=score&filter[fields][type][]=submission&pretty_print=true" sourceType:@"hnsearch"];
    pvcAsk.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Ask" image:nil tag:2];
    
    [tc setViewControllers:[NSArray arrayWithObjects:pvcFront, pvcNewest, pvcAsk, nil ] animated:YES];
    
    //[nc pushViewController:pvc animated:YES];
    [nc pushViewController:tc animated:YES];
    [self.window addSubview:nc.view];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
