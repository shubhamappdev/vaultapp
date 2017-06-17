//
//  EditAccountViewController.h
//  NewGameV3
//
//  Created by Bhalachandra Banavalikar on 6/20/16.
//  Copyright © 2016 Bhalachandra Banavalikar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class AccountsDisplayViewController;

@class Account;

@interface EditAccountViewController : UITableViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UITableViewCell *accCell;

@property (weak, nonatomic) IBOutlet UITextField *curraccName;

@property (weak, nonatomic) IBOutlet UITextField *edituserName;

@property (weak, nonatomic) IBOutlet UITextField *editpassName;

@property (nonatomic, retain) NSMutableData *responseData;

- (IBAction)passConf:(id)sender;

- (IBAction)editdoneButton:(id)sender;

- (IBAction)showPass:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *changeLabel;

@property (weak, nonatomic) IBOutlet UIButton *showpass;

@property (nonatomic, strong) AccountsDisplayViewController *obj1;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *passAgain;

- (void) setInfo: (NSString *) befacc;

@property (weak, nonatomic) IBOutlet UITextField *accURL;

@property (nonatomic, strong) Account *acc1;

@property (weak, nonatomic) IBOutlet UILabel *changing;

@end
