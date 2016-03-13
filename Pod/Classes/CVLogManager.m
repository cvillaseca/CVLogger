//
//  CVLogManager.m
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#define kLogs @"savedLogs"

#import "CVLogManager.h"

@implementation CVLogManager

+ (id)sharedManager {
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

-(void) addLog:(NSString *) log {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *logs = [[userDefaults objectForKey:kLogs] mutableCopy];
    if (!logs) {
        logs = [NSMutableArray array];
    }
    
    [logs addObject:log];
    
    [userDefaults setObject:logs forKey:kLogs];
    [userDefaults synchronize];
}

-(NSArray *) getLogs {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults objectForKey:kLogs] copy];
}

-(void) removeLogs {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kLogs];
}

@end
