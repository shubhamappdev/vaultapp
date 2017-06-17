#import "NSEncrypt.h"

@interface NSString ()

@end

@implementation NSString (AESCrypt)

- (NSString *)encryption:(NSString *)msg
{
    NSString *key = @"qwaserdftyghijuklpombnvczx";
    NSData *plainData = [msg dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES256EncryptWithKey:key];
    
    NSString *encryptedString = [encryptedData base64Encoding];
    
    return [encryptedString stringByAppendingString: @"\n"];
}

- (NSString *)decryption:(NSString *)msg
{
    NSString *key = @"qwaserdftyghijuklpombnvczx";
    NSData *encryptedData = [NSData dataWithBase64EncodedString:msg];
    NSData *plainData = [encryptedData AES256DecryptWithKey:key];
    
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    
    return plainString;
}

@end
