//
//  CVLogManager.h
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import <Foundation/Foundation.h>

@interface CVLogManager : NSObject

+ (id)sharedManager;

-(void) addLog:(NSString *) log;

-(NSArray *) getLogs;

-(void) removeLogs;

@end
