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

#define kCollapseHeight 150

@interface CVLogger () <CVLoggerDelegate>

@property (nonatomic, strong) CVLogButton *btLogger;

@end

@implementation CVLogger


-(instancetype)init {
    if (!(self = [super init]))
        return nil;
    
    self.collapseHeight = kCollapseHeight;
    self.btLogger = [CVLogButton buttonWithType:UIButtonTypeCustom];

    [self.btLogger addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
    UIWindow* currentWindow = [UIApplication sharedApplication].keyWindow;
    [currentWindow addSubview:self.btLogger];
    
    return self;
}

#pragma mark - Action senders

-(void) touched:(id) sender {

    CVLoggerViewController *loggerVC = [[CVLoggerViewController alloc] initWithNibName:nil bundle:nil];
    loggerVC.collapseHeight = self.collapseHeight;
    loggerVC.delegate = self;
    UINavigationController *navigationController =
    [[UINavigationController alloc] initWithRootViewController:loggerVC];
    
    [[self topMostController] presentViewController:navigationController animated:YES completion:^{
        self.btLogger.hidden = YES;
    }];
}

#pragma mark - Private methods

- (UIViewController*) topMostController {
    
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

#pragma mark - CVLoggerDelegate

-(void)CVLoggerDidClosed {
    self.btLogger.hidden = NO;
}


@end

