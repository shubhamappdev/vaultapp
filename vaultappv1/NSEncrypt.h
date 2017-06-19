/*
 *  NSEncrypt.h
 *  vaultapp
 *
 *  Created by Shubham Banavalikar on 6/19/16
 *  Copyright © 2016 Shubham Banavalikar. All rights reserved.
 *
 */

#import <Foundation/Foundation.h>
#import "NSData.h"

@interface NSString (AESCrypt)

- (NSString *)encryption:(NSString *)msg;
- (NSString *)decryption:(NSString *)msg;

@end
