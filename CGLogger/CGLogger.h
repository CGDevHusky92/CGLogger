//
//  CGLogger.h
//  ThisOrThat
//
//  Created by Chase Gorectke on 11/19/13.
//
//

#import <Foundation/Foundation.h>

@interface CGLogger : NSObject

+(void)logMessage:(NSString *)msg;
#ifndef TAT_LOGGING
+(NSString *)printLog;
#endif
+(NSData *)getLog;
+(void)clearLog;

@end

#ifdef __cplusplus
extern "C" {
#endif
    
extern void CGLogMessage(NSString *message);

#ifdef __cplusplus
};
#endif