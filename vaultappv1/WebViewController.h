//
//  WebViewController.h
//  
//
//  Created by Shubham Banavalikar on 7/11/16.
//  Copyright © 2016 Shubham Banavalikar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void) useInfo: (NSString*) finurl account: (NSString*) account password: (NSString*) password;

@end
