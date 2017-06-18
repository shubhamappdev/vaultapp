//
//  Account.m
//  
//
//  Created by Shubham Banavalikar on 6/19/16.
//  Copyright © 2016 Shubham Banavalikar. All rights reserved.
//

#import "Account.h"

@implementation Account

@synthesize accName = _accName;
@synthesize userName = _userName;
@synthesize passName = _passName;

- (id)initWithName: (NSString *) accName {
    self = [super init];
    
    if(self) {
        self.accName = accName;
    }
    return self;
}


@end
