/*
 *  AccountsDisplayViewController.m
 *  vaultapp
 *
 *  Created by Shubham Banavalikar on 6/19/16
 *  Copyright © 2016 Shubham Banavalikar. All rights reserved.
 *
 */

#import "AccountsDisplayViewController.h"
#import "Account.h"
#import "MakeAccountViewController.h"
#import "EditAccountViewController.h"
#import "InformationViewController.h"
#import "NSEncrypt.h"
#import "TouchIDViewController.h"

@implementation AccountsDisplayViewController

@synthesize accounts = _accounts;
NSString *us, *pa, *list, *newlabel;
NSUInteger *count1 = 0;
NSUInteger *other = 0;
NSUInteger *viewcount = 0;
NSUInteger *mynum, *mycount;
NSMutableArray *savedAcc;
BOOL  *isgood2 = YES;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if(self) {
        
    }
    return self;
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accounts = [[NSMutableArray alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

- (void) viewDidUnload {
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    if(isgood2 == YES) {
    if(self.docount == 0) {
    NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/AccountNames.txt" stringByExpandingTildeInPath]];
    NSError *error = nil;
    NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
        for(int j = parsed.count - 3; j >= 0; j--) {
            NSString *ma = [[NSString alloc] init];
            NSString *newStr = [ma decryption: [parsed objectAtIndex:j]];
            newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSLog(@"%@", newStr);
            if(([newStr isEqualToString: @"end"])) {
                j = -1;
            }
            if(!([newStr isEqualToString: @"end"] ||[newStr isEqualToString: @"\n"] || [newStr isEqualToString: @""] || [newStr isEqualToString: @" "])) {
                Account *accObj8 = [[Account alloc] initWithName: newStr];
                [_accounts addObject: accObj8];
            }
        }
        isgood2 = NO;
    }
    }
    self.docount++;
    [self.tableView reloadData];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSString *ma = [[NSString alloc] init];
    if(_accounts.count != 0) {
        for (int i = _accounts.count - 1; i >= 0; i--) {
            Account *account = [self.accounts objectAtIndex: i];
            append4([ma encryption: [NSString stringWithFormat: @"%@\n", account.accName]]);
        }
        NSString *end = @"end";
        append4([ma encryption: [NSString stringWithFormat: @"%@\n", end]]);
        isgood2 = YES;
    }
    else {
        isgood2 = NO;
    }

}

void _Log4(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    va_end (ap);
    fprintf(stderr,"%s%50s:%3d - %s",[prefix UTF8String], funcName, lineNumber, [msg UTF8String]);
    NSString *ma = [[NSString alloc] init];
    append4([ma encryption: [NSString stringWithFormat: @"%@\n", msg]]);
}

void append4(NSString *msg){
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"AccountNames.txt"];
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

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Account *needobj = [self.accounts objectAtIndex:indexPath.row];
    NSString *msg = needobj.accName;
    NSString *finmsg = [msg stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    finmsg = [finmsg stringByReplacingOccurrencesOfString: @"\n" withString: @""];
    EditAccountViewController *editacc = [[EditAccountViewController alloc] init];
    [editacc setInfo: finmsg];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationIsPortrait);
}

- (void) haveInfo: (NSString *) name {
    newlabel = name;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Came here");
    if([segue.identifier isEqualToString: @"AddSegue"]) {
        MakeAccountViewController *makeAccount = segue.destinationViewController;
        makeAccount.obj = self;
    }
    else if([segue.identifier isEqualToString: @"EditDoneSegue"] || [segue.identifier isEqualToString: @"EditNotDoneSegue"]) {
        EditAccountViewController *ev3 = segue.destinationViewController;
        ev3.acc1 = [self.accounts objectAtIndex: self.tableView.indexPathForSelectedRow.row];
    }
    else if([segue.identifier isEqualToString: @"same"]) {
        InformationViewController *ev41 = [[InformationViewController alloc] init];
        [ev41 setNew];
        self.docount == 0;
    }
}

- (void) printArrray {
    NSLog(@"%@", self.accounts);
}

- (NSInteger *) giveNum {
    return mynum;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.accounts.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"First Label";
    
    Account *currentAccount = [self.accounts objectAtIndex: indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    cell.textLabel.text = currentAccount.accName;

    return cell;
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *ma = [[NSString alloc] init];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_accounts removeObjectAtIndex: indexPath.row];
        [self.labels deleteRowsAtIndexPaths: [NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    if(_accounts.count != 0) {
        for (int i = _accounts.count - 1; i >= 0; i--) {
            Account *account = [self.accounts objectAtIndex: i];
            append4([ma encryption: [NSString stringWithFormat: @"%@\n", account.accName]]);
        }
        NSString *end = @"end";
        append4([ma encryption: [NSString stringWithFormat: @"%@\n", end]]);
        isgood2 = YES;
    }
    else {
        NSString *end = @"end";
        append4([ma encryption: [NSString stringWithFormat: @"%@\n", end]]);
        isgood2 = NO;
    }

}
- (IBAction)delete:(id)sender {
    mycount++;
    [self.labels setEditing:YES animated:YES];
    if(mycount == 8) {
        _deleteBut.title = @"Done";
    }
    if(mycount == 16) {
        [self.labels setEditing: NO animated: YES];
        _deleteBut.title = @"Delete";
         mycount = 0;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
@end
