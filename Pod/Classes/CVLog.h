//
//  CVLog.h
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(args...) CVLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif

void CVLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);