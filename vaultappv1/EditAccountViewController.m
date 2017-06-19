/*
 *  EditAccountViewController.m
 *  vaultapp
 *
 *  Created by Shubham Banavalikar on 6/19/16
 *  Copyright © 2016 Shubham Banavalikar. All rights reserved.
 *
 */

#import "EditAccountViewController.h"
#import "WebViewController.h"
#import "MakeAccountViewController.h"
#import "Account.h"
#import "AccountsDisplayViewController.h"
#import "NSEncrypt.h"


@implementation EditAccountViewController
@synthesize responseData;

NSString *acclabel, *userlabel, *passlabel, *urllabel;
NSUInteger *count2, *presscount;
NSString *user, *pass, *URL;
NSUInteger *fincount, *secondcount;
BOOL *isgood;
BOOL *came = NO;
BOOL *editexists;
BOOL *camenow, *cameHere1;
BOOL *proceed, proceed1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    proceed1 = YES;
    NSString *oneLineStr;
    NSString *subLineStr, *us, *pa, *list;
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/AccountInformation.txt" stringByExpandingTildeInPath]];
    NSError *error = nil;
    NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
    NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
    for (int i = parsed.count - 1; i >= 0; i--)
    {
        NSString *ma = [[NSString alloc] init];
        NSString *oneLineStr = [ma decryption: [parsed objectAtIndex:i]];
        oneLineStr = [oneLineStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        NSLog(@"AccLabel: %@ %zd", acclabel, acclabel.length);
        NSLog(@"OneLineStr: %@ %zd", oneLineStr, oneLineStr.length);
        NSLog(@"Equals: %d", [oneLineStr isEqualToString: acclabel]);
        if(fincount == 1) {
            isgood = YES;
        }
        if (([oneLineStr isEqualToString: acclabel]) && (came == NO)) {
            if(acclabel.length == oneLineStr.length) {
                NSLog(@"Loved It");
                fincount = 1;
                came = YES;
            }
        }
        if((isgood == YES) && (secondcount <= 24)) {
            secondcount = secondcount + 1;
            if(secondcount == 8) {
                us = oneLineStr;
                NSLog(@"Loved It More %@", us);
            }
            else if(secondcount == 16) {
                pa = oneLineStr;
                 NSLog(@"Loved It More %@", pa);
            }
            else if(secondcount == 24) {
                list = oneLineStr;
                 NSLog(@"Loved It More %@", list);
                i = -1;
            }
        }
        NSLog(@"Second Count: %zd", secondcount);
    }
    fincount = 0;
    isgood = NO;
    secondcount = 0;
    came = NO;
    
    self.accURL.text = list;
    self.curraccName.text = acclabel;
    self.edituserName.text = us;
    self.editpassName.text = pa;

    NSLog(@"URL: %@", list);
    NSLog(@"Account: %@", acclabel);
    NSLog(@"Username: %@", us);
    NSLog(@"Password: %@", pa);
}

- (void) setInfo: (NSString *) befacc {
    acclabel = befacc;
}

void append1(NSString *msg){
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"AccountInformation.txt"];
    fprintf(stderr,"Creating file at %s",[path UTF8String]);
    // create if needed
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
        fprintf(stderr,"Creating file at %s",[path UTF8String]);
        [[NSData data] writeToFile:path atomically:YES];
    }
    // append
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:path];
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[msg dataUsingEncoding:NSUTF8StringEncoding]];
    [handle closeFile];
}


- (IBAction)passConf:(id)sender {
    camenow = YES;
    NSString *ma = [[NSString alloc] init];
    NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/AccountNames.txt" stringByExpandingTildeInPath]];
    NSError *error = nil;
    NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
    for(int j = parsed.count - 3; j >= 0; j--) {
        NSString *newStr = [ma decryption: [parsed objectAtIndex:j]];
        if(![self.curraccName.text isEqualToString: acclabel]) {
            if([newStr isEqualToString:self.curraccName.text]) {
                self.changeLabel.text = @"Account already exists.";
                editexists = YES;
                cameHere1 = NO;
            }
        }
        if([newStr isEqualToString: @"end"]) {
            j = -1;
        }
    }
    if([self.curraccName.text isEqualToString: @""] || [self.edituserName.text isEqualToString: @""] || [self.accURL.text isEqualToString: @""] || [self.editpassName.text isEqualToString: @""]) {
        self.changeLabel.text = @"Populate all fields";
        editexists = YES;
    }
    /*if([self.curraccName.text isEqualToString: acclabel] && [self.edituserName.text isEqualToString: userlabel] && [self.accURL.text isEqualToString: urllabel] && [self.editpassName.text isEqualToString: passlabel]) {
        editexists = YES;
    }*/
    if(editexists == NO) {
        cameHere1 = YES;
        if(!([self.password.text isEqual:  @""] && [self.passAgain.text isEqual: @""])) {
            if([self.password.text isEqualToString: self.passAgain.text]) {
                self.changeLabel.text = @"Changes mades";
                NSString *preURL = self.accURL.text;
                if(([preURL rangeOfString: @"https://"].location == NSNotFound) && ([preURL rangeOfString: @"http://"].location == NSNotFound)) {
                    URL = [NSString stringWithFormat: @"%@%@\n", @"https://", preURL];
                }
                else {
                    URL = [NSString stringWithFormat: @"%@\n", self.accURL.text];
                }
                append1([ma encryption: URL]);
                NSString *acc = [NSString stringWithFormat:@"%@\n", self.password.text];
                append1([ma encryption: acc]);
                NSString *user = [NSString stringWithFormat:@"%@\n", self.edituserName.text];
                append1([ma encryption: user]);
                NSString *pass = [NSString stringWithFormat:@"%@\n", self.curraccName.text];
                append1([ma encryption: pass]);
                self.acc1.accName = self.curraccName.text;
                urllabel = self.accURL.text;
                passlabel = self.password.text;
                self.editpassName.text = self.password.text;
                userlabel = self.edituserName.text;
                acclabel = self.curraccName.text;
            }
            else {
                cameHere1 = NO;
                self.changeLabel.text = @"Passwords don't match";
                NSString *preURL = self.accURL.text;
                if([preURL rangeOfString: @"https://"].location == NSNotFound) {
                    URL = [NSString stringWithFormat: @"%@%@\n", @"https://", preURL];
                }
                else {
                    URL = [NSString stringWithFormat: @"%@\n", self.accURL.text];
                }
                append1([ma encryption: URL]);
                NSString *acc = [NSString stringWithFormat:@"%@\n", self.editpassName.text];
                append1([ma encryption: acc]);
                NSString *user = [NSString stringWithFormat:@"%@\n", self.edituserName.text];
                append1([ma encryption: user]);
                NSString *pass = [NSString stringWithFormat:@"%@\n", self.curraccName.text];
                append1([ma encryption: pass]);
                self.acc1.accName = self.curraccName.text;
                urllabel = self.accURL.text;
                passlabel = self.editpassName.text;
                userlabel = self.edituserName.text;
                acclabel = self.curraccName.text;
            }
        }
        else {
            self.changeLabel.text = @"Changes mades";
            NSString *preURL = self.accURL.text;
            if([preURL rangeOfString: @"https://"].location == NSNotFound) {
                URL = [NSString stringWithFormat: @"%@%@\n", @"https://", preURL];
            }
            else {
                URL = [NSString stringWithFormat: @"%@\n", self.accURL.text];
            }
            append1([ma encryption: URL]);
            NSString *acc = [NSString stringWithFormat:@"%@\n", self.editpassName.text];
            append1([ma encryption: acc]);
            NSString *user = [NSString stringWithFormat:@"%@\n", self.edituserName.text];
            append1([ma encryption: user]);
            NSString *pass = [NSString stringWithFormat:@"%@\n", self.curraccName.text];
            append1([ma encryption: pass]);
            self.acc1.accName = self.curraccName.text;
            urllabel = self.accURL.text;
            passlabel = self.editpassName.text;
            userlabel = self.edituserName.text;
            acclabel = self.curraccName.text;
        }
        
    }
    else if((camenow == YES) && (cameHere1 == NO)){
        NSLog(@"This button");
        NSLog(@"Yay!");
        proceed = NO;
    }
    camenow = NO;
    cameHere1 = NO;
    proceed1 = YES;
    editexists = NO;
}

- (IBAction)editdoneButton:(id)sender {
        NSString *ma = [[NSString alloc] init];
        proceed1 = YES;
        NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/AccountNames.txt" stringByExpandingTildeInPath]];
        NSError *error = nil;
        NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
        NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
        NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
        for(int j = parsed.count - 3; j >= 0; j--) {
            NSString *newStr = [ma decryption: [parsed objectAtIndex:j]];
            if(![self.curraccName.text isEqualToString: acclabel]) {
                if([newStr isEqualToString:self.curraccName.text]) {
                    self.changeLabel.text = @"Account already exists.";
                    proceed = NO;
                    proceed1 = NO;
                }
            }
            if([newStr isEqualToString: @"end"]) {
                j = -1;
            }
        }
        if([self.curraccName.text isEqualToString: @""] || [self.edituserName.text isEqualToString: @""] || [self.accURL.text isEqualToString: @""] || [self.editpassName.text isEqualToString: @""]) {
            self.changeLabel.text = @"Populate all fields.";
            proceed = NO;
        }
        else if(proceed1 == YES) {
            if(!([self.password.text isEqual:  @""] && [self.passAgain.text isEqual: @""])) {
                if([self.password.text isEqualToString: self.passAgain.text]) {
                    self.changeLabel.text = @"Changes mades";
                    NSString *preURL = self.accURL.text;
                    if(([preURL rangeOfString: @"https://"].location == NSNotFound) && ([preURL rangeOfString: @"http://"].location == NSNotFound)) {
                        URL = [NSString stringWithFormat: @"%@%@\n", @"https://", preURL];
                    }
                    else {
                        URL = [NSString stringWithFormat: @"%@\n", self.accURL.text];
                    }
                    append1([ma encryption: URL]);
                    NSString *acc = [NSString stringWithFormat:@"%@\n", self.password.text];
                    append1([ma encryption: acc]);
                    NSString *user = [NSString stringWithFormat:@"%@\n", self.edituserName.text];
                    append1([ma encryption: user]);
                    NSString *pass = [NSString stringWithFormat:@"%@\n", self.curraccName.text];
                    append1([ma encryption: pass]);
                    self.acc1.accName = self.curraccName.text;
                    urllabel = self.accURL.text;
                    passlabel = self.password.text;
                    self.editpassName.text = self.password.text;
                    userlabel = self.edituserName.text;
                    acclabel = self.curraccName.text;
                }
                else {
                    self.changeLabel.text = @"Passwords don't match";
                    NSString *preURL = self.accURL.text;
                    if([preURL rangeOfString: @"https://"].location == NSNotFound) {
                        URL = [NSString stringWithFormat: @"%@%@\n", @"https://", preURL];
                    }
                    else {
                        URL = [NSString stringWithFormat: @"%@\n", self.accURL.text];
                    }
                    append1([ma encryption: URL]);
                    NSString *acc = [NSString stringWithFormat:@"%@\n", self.editpassName.text];
                    append1([ma encryption: acc]);
                    NSString *user = [NSString stringWithFormat:@"%@\n", self.edituserName.text];
                    append1([ma encryption: user]);
                    NSString *pass = [NSString stringWithFormat:@"%@\n", self.curraccName.text];
                    append1([ma encryption: pass]);
                    self.acc1.accName = self.curraccName.text;
                    urllabel = self.accURL.text;
                    passlabel = self.editpassName.text;
                    userlabel = self.edituserName.text;
                    acclabel = self.curraccName.text;
                }
            }
            else {
                self.changeLabel.text = @"Changes mades";
                NSString *preURL = self.accURL.text;
                if([preURL rangeOfString: @"https://"].location == NSNotFound) {
                    URL = [NSString stringWithFormat: @"%@%@\n", @"https://", preURL];
                }
                else {
                    URL = [NSString stringWithFormat: @"%@\n", self.accURL.text];
                }
                append1([ma encryption: URL]);
                NSString *acc = [NSString stringWithFormat:@"%@\n", self.editpassName.text];
                append1([ma encryption: acc]);
                NSString *user = [NSString stringWithFormat:@"%@\n", self.edituserName.text];
                append1([ma encryption: user]);
                NSString *pass = [NSString stringWithFormat:@"%@\n", self.curraccName.text];
                append1([ma encryption: pass]);
                self.acc1.accName = self.curraccName.text;
                urllabel = self.accURL.text;
                passlabel = self.editpassName.text;
                userlabel = self.edituserName.text;
                acclabel = self.curraccName.text;
            }

                WebViewController *wv = [[WebViewController alloc] init];
                [wv useInfo:urllabel account: userlabel password:passlabel];
                self.changing.text = @"";
                self.changeLabel.text = @"";
                proceed = YES;
        }
        else if((camenow == YES) && (cameHere1 == NO)){
            NSLog(@"Yay!");
            proceed = NO;
        }
        else if((camenow == YES) && (cameHere1 == YES)) {
            NSLog(@"Nice!");
            WebViewController *wv = [[WebViewController alloc] init];
            [wv useInfo:urllabel account: userlabel password:passlabel];
            self.changing.text = @"";
            self.changeLabel.text = @"";
            proceed = YES;
        }
    camenow = NO;
    cameHere1 = NO;
    proceed1 = YES;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return proceed;
}

- (IBAction)showPass:(id)sender {
    presscount++;
    if(presscount == 8) {
        [_editpassName setSecureTextEntry:NO];
        [_showpass setTitle: @"Hide Password" forState: UIControlStateNormal];
    }
    else if(presscount == 16) {
        [_editpassName setSecureTextEntry:YES];
        [_showpass setTitle: @"Show Password" forState: UIControlStateNormal];
        presscount = 0;
    }
}



@end
