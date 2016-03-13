//
//  CVAppDelegate.m
//  CVLogger
//
//  Created by Cristian Villaseca on 03/12/2016.
//  Copyright (c) 2016 Cristian Villaseca. All rights reserved.
//

#import "CVAppDelegate.h"


@implementation CVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:45.0f/255.0f green:149.0f/206.0f blue:206.0f/255.0f alpha:1]];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UIViewController *mainViewController = [storyboard instantiateInitialViewController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = mainViewController;
    [self.window makeKeyAndVisible];
    
#ifdef DEBUG
    self.cvlogger =[[CVLogger alloc] init];
#endif
    
    for (int i = 0; i < 10; i++) {
        NSLog(@"Lorem ipsum dolor sit amet, at ridiculus fringilla tristique, ante commodo sed, commodo condimentum turpis, quam euismod praesent tincidunt. Erat vestibulum dui auctor dictumst sem in, ullamcorper sed morbi magna et suscipit dolore, consequatur ante laoreet, nisl eget. Sociis libero et sed euismod. Quis dictum lacus in quam, est duis integer pede facilisis mauris. In nec egestas lorem in morbi platea, enim aliquam consequat, cursus saepe blanditiis, ut risus malesuada quisque ornare ornare iaculis. Adipiscing dolor sed sed ut netus, ut at aenean interdum. Ligula sed adipiscing, adipiscing nisl pede eget adipisicing mauris proin, ac quam dui suspendisse diam ultrices massa. A a odio volutpat auctor.");
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
