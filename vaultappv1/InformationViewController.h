/*
 *  InformationViewController.h
 *  vaultapp
 *
 *  Created by Shubham Banavalikar on 6/19/16
 *  Copyright © 2016 Shubham Banavalikar. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

@class AccountsDisplayViewController;

@interface InformationViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UITableView *info;

@property (nonatomic, strong) NSMutableArray *information;

@property (nonatomic, strong) AccountsDisplayViewController *accdis;

- (IBAction)entryDelete:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *entries;

@property (weak, nonatomic) IBOutlet UIButton *del;

- (void) setNew;

@end
