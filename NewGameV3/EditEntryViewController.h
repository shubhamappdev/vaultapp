//
//  EditEntryViewController.h
//  NewGameV3
//
//  Created by Bhalachandra Banavalikar on 8/7/16.
//  Copyright © 2016 Bhalachandra Banavalikar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Account;

@interface EditEntryViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *editEntryName;

@property (weak, nonatomic) IBOutlet UITextView *editEntry;

- (IBAction)editEntryConf:(id)sender;

- (NSString *) setentry: (NSString *) befentry befname: (NSString *)befname curr: (NSString *) curr;

- (void) final: (NSString *) fin;

@property (nonatomic, strong) Account *ivc;

@property (weak, nonatomic) IBOutlet UILabel *editConfirm;

@end
