//
//  EditEntryViewController.m
//  NewGameV3
//
//  Created by Bhalachandra Banavalikar on 8/7/16.
//  Copyright © 2016 Bhalachandra Banavalikar. All rights reserved.
//

#import "EditEntryViewController.h"
#import "Account.h"
#import "NSEncrypt.h"

@interface EditEntryViewController ()

@end

@implementation EditEntryViewController

NSString *entryN;
NSString *Ntry;
NSString *fin1;
BOOL editexists1;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.editEntryName.text = Ntry;
    self.editEntry.text = fin1;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *) setentry: (NSString *) befentry befname: (NSString *)befname curr: (NSString *) curr
{
    NSString *preN = [NSString stringWithFormat: @"%@\n", befentry];
    entryN = [curr stringByAppendingString: preN];
    Ntry = befname;
    return entryN;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.editEntry.layer.borderWidth = 1.0f;
    self.editEntry.layer.borderColor = [[UIColor grayColor] CGColor];
}


- (void) final: (NSString *) fin {
    fin1 = fin;
}

void _Log7(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    NSString *ma = [[NSString alloc] init];
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    va_end (ap);
    fprintf(stderr,"%s%50s:%3d - %s",[prefix UTF8String], funcName, lineNumber, [msg UTF8String]);
    append7([ma encryption: [NSString stringWithFormat: @"%@\n", msg]]);
}

void append7(NSString *msg){
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


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

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

- (IBAction)editEntryConf:(id)sender {
    NSString *ma = [[NSString alloc] init];
    NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/EntryNames.txt" stringByExpandingTildeInPath]];
    NSError *error = nil;
    NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
    for(int j = parsed.count - 3; j >= 0; j--) {
        NSString *oneLineStr = [ma decryption:[parsed objectAtIndex: j]];
        oneLineStr = [oneLineStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if(![self.editEntryName.text isEqualToString: Ntry]) {
            if([oneLineStr isEqualToString:self.editEntryName.text]) {
                self.editConfirm.text = @"Entry Name Already Exists";
                editexists1 = YES;
            }
        }
        if([oneLineStr isEqualToString: @"end"]) {
            j = -1;
        }
    }
    if([self.editEntryName.text isEqualToString: @""] || [self.editEntry.text isEqualToString: @""]) {
        self.editConfirm.text = @"Populate all fields";
        editexists1 = YES;
    }
    if(editexists1 == NO) {
        self.editConfirm.text = @"Changes Made";
    NSString *name1 = @"name";
    NSString *name = [NSString stringWithFormat: @"%@\n", name1];
    append7([ma encryption: name]);
    NSString *info = [NSString stringWithFormat: @"%@\n", self.editEntry.text];
    append7([ma encryption: info]);
    NSString *infoName = [NSString stringWithFormat: @"%@\n", self.editEntryName.text];
    append7([ma encryption: infoName]);
    self.ivc.accName = self.editEntryName.text;
    }
    editexists1 = NO;
}
@end
