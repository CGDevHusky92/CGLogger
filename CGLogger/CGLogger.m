//
//  CGLogger.m
//  ThisOrThat
//
//  Created by Chase Gorectke on 11/19/13.
//
//

#import "CGLogger.h"
#define TAT_DIR         [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"TATLOG"]

@interface CGLogger()

@end

@implementation CGLogger

+ (void)logMessage:(NSString *)msg
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:TAT_DIR]) {
        [[NSFileManager defaultManager] createFileAtPath:TAT_DIR contents:nil attributes:nil];
    }
    
    NSString *newMsg = [NSString stringWithFormat:@"%@\n", msg];
    NSFileHandle *myHandle = [NSFileHandle fileHandleForWritingAtPath:TAT_DIR];
    [myHandle seekToEndOfFile];
    [myHandle writeData:[newMsg dataUsingEncoding:NSUTF8StringEncoding]];
}

+ (NSString *)printLog
{
    NSError *error = nil;
    NSString *fileString = [NSString stringWithContentsOfFile:TAT_DIR encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return [NSString stringWithFormat:@"Error: %@", [error localizedDescription]];
    } else {
        return [NSString stringWithFormat:@"%@", fileString];
    }
}

+ (NSData *)getLog
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:TAT_DIR]) {
        return [[NSFileManager defaultManager] contentsAtPath:TAT_DIR];
    } else {
        return nil;
    }
}

+ (void)clearLog
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:TAT_DIR]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:TAT_DIR error:&error];
        if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }
}

@end

void CGLogMessage(NSString *message)
{
    [CGLogger logMessage:message];
}