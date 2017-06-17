#import <Foundation/Foundation.h>
#import "NSData.h"

@interface NSString (AESCrypt)

- (NSString *)encryption:(NSString *)msg;
- (NSString *)decryption:(NSString *)msg;

@end
