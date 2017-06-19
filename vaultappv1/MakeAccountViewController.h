/*
 *  MakeAccountViewController.h
 *  vaultapp
 *
 *  Created by Shubham Banavalikar on 6/19/16
 *  Copyright © 2016 Shubham Banavalikar. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

@class AccountsDisplayViewController;

@interface MakeAccountViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *initaccName;

@property (weak, nonatomic) IBOutlet UITextField *inituserName;

@property (weak, nonatomic) IBOutlet UITextField *initpassName;

@property (weak, nonatomic) IBOutlet UITextField *initconfPass;

@property (weak, nonatomic) IBOutlet UILabel *Conf;

- (IBAction)doneButton:(id)sender;

@property (nonatomic, strong) AccountsDisplayViewController *obj;

@property (weak, nonatomic) IBOutlet UITextField *accurl;

@property (nonatomic, strong) NSMutableArray *acclist;

@property (nonatomic, strong) NSMutableArray *urllist;

@end
