/*
 *  EntryViewController.h
 *  vaultapp
 *
 *  Created by Shubham Banavalikar on 6/19/16
 *  Copyright © 2016 Shubham Banavalikar. All rights reserved.
 *
 */

#import <UIKit/UIKit.h>

@class InformationViewController;

@interface EntryViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *entryName;

@property (weak, nonatomic) IBOutlet UITextView *entry;

@property (nonatomic, strong) InformationViewController *infoObj;

- (IBAction)entryDone:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *confirm;

@end
