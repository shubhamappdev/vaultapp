//
//  EntryViewController.h
//  NewGameV3
//
//  Created by Bhalachandra Banavalikar on 8/2/16.
//  Copyright © 2016 Bhalachandra Banavalikar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InformationViewController;

@interface EntryViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *entryName;

@property (weak, nonatomic) IBOutlet UITextView *entry;

@property (nonatomic, strong) InformationViewController *infoObj;

- (IBAction)entryDone:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *confirm;

@end
