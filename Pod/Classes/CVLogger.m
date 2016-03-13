//
//  CVLogger.m
//  Pods
//
//  Created by Cristian Villaseca on 12/3/16.
//
//

#import "CVLogger.h"


#import "CVLogButton.h"
#import "CVLoggerViewController.h"



@interface CVLogger () <CVLoggerDelegate>

@property (nonatomic, strong) CVLogButton *btLogger;

@end

@implementation CVLogger


-(instancetype)init{
    if (!(self = [super init]))
        return nil;
    
    self.btLogger = [CVLogButton buttonWithType:UIButtonTypeCustom];
    self.btLogger.frame = CGRectMake(50, 50, 30, 30);
    self.btLogger.backgroundColor = [UIColor yellowColor];
    [self.btLogger addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self.btLogger];
    
    return self;
}

-(void) touched:(id) sender {
    self.btLogger.hidden = YES;
    
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = currentWindow.rootViewController;
    
    CVLoggerViewController *loggerVC = [[CVLoggerViewController alloc] initWithNibName:nil bundle:nil];
    loggerVC.delegate = self;
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:loggerVC];
    
    
    [vc presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - CVLoggerDelegate

-(void)CVLoggerDidClosed {
    self.btLogger.hidden = NO;
}


@end
