//
//  WebViewController.h
//  NewGameV3
//
//  Created by Bhalachandra Banavalikar on 7/11/16.
//  Copyright © 2016 Bhalachandra Banavalikar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void) useInfo: (NSString*) finurl account: (NSString*) account password: (NSString*) password;

@end
