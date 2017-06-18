//
//  NSEncrypt.h
//  
//
//  Created by Shubham Banavalikar on 6/20/16.
//  Copyright © 2016 Shubham Banavalikar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData.h"

@interface NSString (AESCrypt)

- (NSString *)encryption:(NSString *)msg;
- (NSString *)decryption:(NSString *)msg;

@end
