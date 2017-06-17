//
//  MakeAccountViewController.m
//  NewGameV3
//
//  Created by Bhalachandra Banavalikar on 6/20/16.
//  Copyright © 2016 Bhalachandra Banavalikar. All rights reserved.
//

#import "MakeAccountViewController.h"
#import "AccountsDisplayViewController.h"
#import "Account.h"
#import "NSEncrypt.h"

@interface MakeAccountViewController ()

@end


@implementation MakeAccountViewController

NSString *urlinfo, *URL1, *firstacc;
NSInteger *index1 = 0;
NSUInteger *fincount1, *secondcount1;
BOOL *came1, *isgood3, exists;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.acclist = [NSMutableArray array];
    self.urllist = [NSMutableArray array];
    _initaccName.layer.borderColor=[[UIColor blueColor]CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

void _Log(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    va_end (ap);
    fprintf(stderr,"%s%50s:%3d - %s",[prefix UTF8String], funcName, lineNumber, [msg UTF8String]);
    append(msg);
}

void append(NSString *msg){
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"AccountInformation.txt"];
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
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)doneButton:(id)sender {
    NSString *ma = [[NSString alloc] init];
    NSURL *fileURL = [NSURL fileURLWithPath:[@"~/Documents/AccountNames.txt" stringByExpandingTildeInPath]];
    NSError *error = nil;
    NSString *fileContentsString = [NSString stringWithContentsOfURL:fileURL encoding:NSUTF8StringEncoding error:&error];
    NSCharacterSet *newlineCharSet = [NSCharacterSet newlineCharacterSet];
    NSArray *parsed = [fileContentsString componentsSeparatedByCharactersInSet: newlineCharSet];
    for(int j = parsed.count - 3; j >= 0; j--) {
        NSString *newStr = [ma decryption: [parsed objectAtIndex:j]];
        if([newStr isEqualToString:self.initaccName.text]) {
            self.Conf.text = @"Account Already Exists";
            exists = YES;
        }
        if([newStr isEqualToString: @"end"]) {
            j = -1;
        }
    }
    if([self.initaccName.text isEqualToString: @""] || [self.inituserName.text isEqualToString: @""] || [self.accurl.text isEqualToString: @""] || [self.initpassName.text isEqualToString: @""]) {
        self.Conf.text = @"Populate all fields";
        exists = YES;
    }
    if(exists == NO) {
    if(([self.initpassName.text isEqualToString: self.initconfPass.text]) && (![firstacc isEqual: self.initaccName.text])) {
        self.Conf.text = @"Account Created";
        NSString *preURL = self.accurl.text;
        if(([preURL rangeOfString: @"https://"].location == NSNotFound) && ([preURL rangeOfString: @"http://"].location == NSNotFound)) {
            URL1 = [NSString stringWithFormat: @"%@%@\n", @"https://", preURL];
        }
        else {
            URL1 = [NSString stringWithFormat: @"%@\n", self.accurl.text];
        }
        append([ma encryption: URL1]);
        NSString *acc = [NSString stringWithFormat:@"%@\n", self.initpassName.text];
        append([ma encryption: acc]);
        NSString *user = [NSString stringWithFormat:@"%@\n", self.inituserName.text];
        append([ma encryption: user]);
        NSString *pass = [NSString stringWithFormat:@"%@\n", self.initaccName.text];
        append([ma encryption: pass]);
        firstacc = self.initaccName.text;
        Account *accObj = [[Account alloc] initWithName: pass];
        [self.obj.accounts addObject: accObj];
    }
    else if ([self.initpassName.text isEqualToString: self.initconfPass.text]){
        self.Conf.text = @"Account Created";
    }
    else {
        self.Conf.text = @"Passwords don't match";
    }
    }
    exists = NO;
}
@end
