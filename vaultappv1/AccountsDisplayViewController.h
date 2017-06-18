//
//  AccountsDisplayViewController.h
//  NewGameV3
//
//  Created by Shubham Banavalikar on 6/19/16.
//  Copyright © 2016 Shubham Banavalikar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface AccountsDisplayViewController : UITableViewController <NSObject>

@property (nonatomic, strong) NSURL *file;

@property (readonly, strong) NSString *fileName;

- (id)initWithFileURL: (NSURL *)fileURL;

+ (AccountsDisplayViewController *) entityForURL: (NSURL *)url;

@property (nonatomic, strong) NSMutableArray *accounts;

- (IBAction)delete:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *labels;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteBut;

- (NSInteger *) giveNum;

- (void) printArrray;

@property (assign) BOOL *start;

@property (assign) NSUInteger *docount;

@end

@interface ImageEntity : AccountsDisplayViewController

@property (nonatomic, strong) UIImage *image;

@end

@interface FolderEntity : AccountsDisplayViewController

@end
