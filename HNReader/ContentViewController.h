//
//  ContentViewController.h
//  HNReader
//
//  Created by Arbie Samong on 6/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController {
    IBOutlet UIWebView *wView;
}

@property (strong, nonatomic) IBOutlet UIWebView *wView;

@end
