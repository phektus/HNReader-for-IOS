//
//  PostsViewController.h
//  HNReader
//
//  Created by Arbie Samong on 6/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsViewController : UITableViewController {
    NSMutableArray *posts;
}

- (id)initWithSourceURL:(NSString *)sourceURL sourceType:(NSString *)sourceType;

@end
