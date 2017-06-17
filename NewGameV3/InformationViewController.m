//
//  InformationViewController.m
//  NewGameV3
//
//  Created by Bhalachandra Banavalikar on 8/2/16.
//  Copyright © 2016 Bhalachandra Banavalikar. All rights reserved.
//

#import "InformationViewController.h"
#import "Account.h"
#import "EntryViewController.h"
#import "AccountsDisplayViewController.h"
#import "EditEntryViewController.h"
#import "NSEncrypt.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

@synthesize information = _information;
NSMutableArray *keeparr;
NSUInteger *viewcount1 = 0;
BOOL isgood1 = NO;
NSMutableArray *savedacc;
BOOL *cameHere = YES;
NSUInteger *mycount1;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if(self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isgood1 = NO;
    cameHere = YES;
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.information = [[NSMutableArray alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

- (void) viewWillAppear:(BOOL)animated {
    NSString *ma = [[NSString alloc] init];
    [super viewWillAppear: animated];
    if(cameHere == YES) {
    if(self.information.count == 0) {
    NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/EntryNames.txt" stringByExpandingTildeInPath]];
    NSError *error = nil;
    NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
    for(int j = parsed.count - 3; j >= 0; j--) {
        NSString *newStr = [ma decryption: [parsed objectAtIndex: j]];
        newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if(!([newStr isEqualToString: @"end"])) {
            Account *accObj8 = [[Account alloc] initWithName: newStr];
            [_information addObject: accObj8];
        }
        if(([newStr isEqualToString: @"end"])) {
            j = -1;
        }
    }
    }
        cameHere = NO;
    }
    [self.tableView reloadData];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSString *ma = [[NSString alloc] init];
    if(_information.count != 0) {
        for (int i = _information.count - 1; i >= 0; i--) {
            Account *account = [self.information objectAtIndex: i];
            append3([ma encryption:[NSString stringWithFormat: @"%@\n", account.accName]]);
        }
        NSString *end = @"end";
        append3([ma encryption:[NSString stringWithFormat: @"%@\n", end]]);
        cameHere = YES;
    }
    else {
        cameHere = NO;
        NSString *end2 = @"end";
        append3([ma encryption:[NSString stringWithFormat: @"%@\n", end2]]);
    }
}

void _Log3(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    NSString *ma = [[NSString alloc] init];
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    va_end (ap);
    fprintf(stderr,"%s%50s:%3d - %s",[prefix UTF8String], funcName, lineNumber, [msg UTF8String]);
    append3([ma encryption: [NSString stringWithFormat: @"%@\n", msg]]);
}

void append3(NSString *msg){
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"EntryNames.txt"];
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


- (IBAction)entryDelete:(id)sender {
    mycount1++;
    [self.entries setEditing:YES animated:YES];
    if(mycount1 == 8) {
        [_del setTitle: @"Done" forState: UIControlStateNormal];
    }
    if(mycount1 == 16) {
        [self.entries setEditing: NO animated: YES];
        [_del setTitle: @"Delete" forState: UIControlStateNormal];
        mycount1 = 0;
    }

}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *ma = [[NSString alloc] init];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_information removeObjectAtIndex: indexPath.row];
        [self.entries deleteRowsAtIndexPaths: [NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    if(_information.count != 0) {
        for (int i = _information.count - 1; i >= 0; i--) {
            Account *account = [self.information objectAtIndex: i];
            append3([ma encryption:[NSString stringWithFormat: @"%@\n", account.accName]]);
        }
        NSString *end = @"end";
        append3([ma encryption:[NSString stringWithFormat: @"%@\n", end]]);
        cameHere = YES;
    }
    else {
        cameHere = NO;
        NSString *end2 = @"end";
        append3([ma encryption:[NSString stringWithFormat: @"%@\n", end2]]);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void) setNew {
    viewcount1 = 0;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ma = [[NSString alloc] init];
    NSString *oneLineStr;
    NSString *subLineStr;
    NSString *msg1 = @"";
    NSInteger *ind1;
    NSInteger *ind2 = 0;
    NSMutableArray *mess = [[NSMutableArray alloc] init];
    NSMutableArray *finmess = [[NSMutableArray alloc] init];
    Account *needobj = [self.information objectAtIndex:indexPath.row];
    NSString *msg = needobj.accName;
    NSString *finmsg = [msg stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    finmsg = [finmsg stringByReplacingOccurrencesOfString: @"\n" withString: @""];
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/EntryInformation.txt" stringByExpandingTildeInPath]];
    NSError *error = nil;
    NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
    NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
    for (int i = parsed.count - 1; i >= 0; i--)
    {
        oneLineStr = [ma decryption:[parsed objectAtIndex: i]];
        oneLineStr = [oneLineStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if([oneLineStr isEqualToString: finmsg]) {
            isgood1 = YES;
        }
        if(isgood1 == YES) {
            if(!([oneLineStr isEqualToString: @"name"] || [oneLineStr isEqualToString: finmsg])) {
                [mess addObject: [parsed objectAtIndex: i]];
            }
            if([oneLineStr isEqualToString: @"name"]) {
                i = -1;
            }
        }
    }
    NSArray* reversedArray = [[mess reverseObjectEnumerator] allObjects];
    EditEntryViewController *edView = [[EditEntryViewController alloc] init];
    for(int h = 0; h < reversedArray.count; h++) {
        msg1 = [edView setentry: [ma decryption:[reversedArray objectAtIndex: h]] befname:finmsg curr: msg1];
    }
    isgood1 = NO;
    [edView final: msg1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.information.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ma = [[NSString alloc] init];
    static NSString *CellIdentifier = @"First";
    
    Account *currentAccount = [self.information objectAtIndex: indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    cell.textLabel.text = currentAccount.accName;
    
    for (int i = _information.count - 1; i >= 0; i--) {
        Account *account = [self.information objectAtIndex: i];
        append3([ma encryption:[NSString stringWithFormat: @"%@\n", account.accName]]);
    }
    NSString *end = @"end";
    append3([ma encryption:[NSString stringWithFormat: @"%@\n", end]]);
    cameHere = YES;
    
    return cell;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationIsPortrait);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString: @"AddInfo"]) {
        EntryViewController *makeAccount = segue.destinationViewController;
        makeAccount.infoObj = self;
    }
    else if([segue.identifier isEqualToString: @"EntryNotDoneSegue"] || [segue.identifier isEqualToString: @"EntryDoneSegue"]) {
        EditEntryViewController *makeEdit = segue.destinationViewController;
        makeEdit.ivc = [self.information objectAtIndex: self.tableView.indexPathForSelectedRow.row];
    }
}


@end
