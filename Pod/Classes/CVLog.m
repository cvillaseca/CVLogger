//
//  CVLog.m
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import "CVLog.h"
#import "CVLogManager.h"

void CVLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...)
{
    va_list ap;
    
    va_start (ap, format);

    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    va_end (ap);
    
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    
    NSString *localDate = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
    
    fprintf(stderr, "(%s) (%s:%d) %s",
            [localDate UTF8String], [fileName UTF8String],
            lineNumber, [body UTF8String]);
    
    NSString *message = [NSString stringWithFormat:@"(%@) (%s:%d) %s", localDate
                         , [fileName UTF8String],
                         lineNumber, [body UTF8String]];
    
    [[CVLogManager sharedManager] addLog:message];
}

