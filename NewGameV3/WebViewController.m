//
//  WebViewController.m
//  NewGameV3
//
//  Created by Bhalachandra Banavalikar on 7/11/16.
//  Copyright © 2016 Bhalachandra Banavalikar. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

NSString *finaccount;
NSString *finpassword;
NSString *finalurl;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSURL *url = [NSURL URLWithString:finalurl];
    self.webView.frame=self.view.bounds;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    self.webView.delegate = self;
}

- (void) useInfo: (NSString*) finurl account: (NSString*) account password: (NSString*) password {
    finalurl = finurl;
    finaccount = account;
    finpassword = password;
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0 diskCapacity:0 diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    
    //Clear All Cookies
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *loadUsernameJS =
    [NSString stringWithFormat:@"var inputFields = document.querySelectorAll(\"input[type='email']\"); \
     for (var i = inputFields.length >>> 0; i--;) { inputFields[i].value = '%@';}", finaccount];
    [webView stringByEvaluatingJavaScriptFromString: loadUsernameJS];
    NSString *loadText =
    [NSString stringWithFormat:@"var inputFields = document.querySelectorAll(\"input[type='text']\"); \
     for (var i = inputFields.length >>> 0; i--;) { inputFields[i].value = '%@';}", finaccount];
    [webView stringByEvaluatingJavaScriptFromString: loadText];
    NSString *loadPasswordJS =
    [NSString stringWithFormat:@"var passFields = document.querySelectorAll(\"input[type='password']\"); \
     for (var i = passFields.length>>> 0; i--;) { passFields[i].value ='%@';}", finpassword];
    [webView stringByEvaluatingJavaScriptFromString: loadPasswordJS];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"start");
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"Error for WEBVIEW: %@", [error description]);
}

@end
