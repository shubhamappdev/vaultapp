//
//  EntryViewController.m
//  NewGameV3
//
//  Created by Shubham Banavalikar on 8/2/16.
//  Copyright © 2016 Shubham Banavalikar. All rights reserved.
//

#import "EntryViewController.h"
#import "Account.h"
#import "InformationViewController.h"
#import "NSEncrypt.h"

@interface EntryViewController ()

@end

@implementation EntryViewController

NSUInteger *count;
BOOL exists1, came2, came3;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    count = 0;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.entry.layer.borderWidth = 1.0f;
    self.entry.layer.borderColor = [[UIColor grayColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

void _Log5(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    NSString *ma = [[NSString alloc] init];
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    va_end (ap);
    fprintf(stderr,"%s%50s:%3d - %s",[prefix UTF8String], funcName, lineNumber, [msg UTF8String]);
    append5([ma encryption: [NSString stringWithFormat: @"%@\n", msg]]);
}

void append5(NSString *msg){
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"EntryInformation.txt"];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)entryDone:(id)sender {
    NSString *ma = [[NSString alloc] init];
    NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/EntryNames.txt" stringByExpandingTildeInPath]];
    NSError *error = nil;
    NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
    for(int j = parsed.count - 3; j >= 0; j--) {
        NSString *newStr = [ma decryption: [parsed objectAtIndex: j]];
        if([newStr isEqualToString:self.entryName.text]) {
            self.confirm.text = @"Entry Name Already Exists";
            exists1 = YES;
            came2= YES;
            count = 0;
        }
        if([newStr isEqualToString: @"end"]) {
            j = -1;
        }
    }
    if([self.entryName.text isEqualToString: @""] || [self.entry.text isEqualToString: @""]) {
        self.confirm.text = @"Populate all fields";
        exists1 = YES;
        came2 = YES;
        count = 0;
    }
    if((came3 == NO) && (came2 == NO)) {
        NSLog(@"YES!");
        exists1 = NO;
        count = 0;
    }
    count++;
    NSLog(@"Count: %lu", count);
    NSLog(@"Exists1: %d", exists1);
    if((count == 8) && (exists1 == NO)) {
        came3 = YES;
        self.confirm.text = @"Entry Made";
    NSString *name1 = @"name";
    NSString *name = [NSString stringWithFormat: @"%@\n", name1];
    append5([ma encryption: name]);
    NSString *info = [NSString stringWithFormat: @"%@\n", self.entry.text];
    append5([ma encryption: info]);
    NSString *infoName = [NSString stringWithFormat: @"%@\n", self.entryName.text];
    append5([ma encryption: infoName]);
    Account *accObj = [[Account alloc] initWithName: self.entryName.text];
    [self.infoObj.information addObject: accObj];
    }
    came2 = NO; 
}
@end
